-- 005 · El formulario de ANTES del retiro
--
-- OJO: no es el formulario de captación (004). Son dos cosas distintas y se
-- confunden con facilidad:
--
--   · 004 · formulario_envios        → la PUERTA DE ENTRADA. Lo rellena quien
--                                      todavía no conoce a nadie. Pide lo mínimo.
--   · 005 · retiro_respuestas (esto) → lo rellena quien YA HA RESERVADO Y PAGADO.
--                                      Sirve para preparar el retiro: las comidas,
--                                      el nivel de yoga, qué trae cada una.
--
-- Mismo modelo de seguridad que el cuaderno (001) y que 004: RLS activado y
-- NINGUNA policy, así que por REST directo no entra nadie. La única puerta es la
-- función, que es security definer y SOLO SABE INSERTAR. Leer no puede ni el
-- anon ni la página: lo lee la dueña desde su panel de Supabase.
--
-- ⚠ AQUÍ HAY DATOS QUE NO SE COPIAN A NINGÚN SITIO.
--
--   `alimentacion`  son alergias, intolerancias y restricciones. Es información
--                   de salud. Se guarda porque hace falta para dar de comer a
--                   doce personas sin envenenar a nadie, y para NADA más.
--                   **No entra en el registro de personas, ni en el gestor de
--                   interesadas, ni en ningún correo, ni en ninguna hoja.**
--                   Se mira la semana del retiro y se olvida.
--
--   `consent_imagen` es un permiso, no una preferencia: si está en false, esa
--                   persona NO sale en ninguna foto ni vídeo publicado. Quien
--                   prepare contenido del retiro tiene que mirar esta columna
--                   antes de publicar nada.
--
-- Y como todo lo de 004: estos datos no salen nunca del repositorio
-- (CLAUDE.md §11) — viven solo en esta tabla.

create table if not exists retiro_respuestas (
  id              uuid primary key default gen_random_uuid(),
  sitio           text        not null,           -- 'reviondo'
  retiro          text        not null,           -- 'octubre-2026' · qué edición
  -- Para conocerte
  nombre          text        not null,
  email           text        not null,
  ciudad          text,
  telefono        text,
  instagram       text,                           -- opcional, lo dice ella
  -- Por qué viene
  motivo          text,                           -- 1 · qué le ha llevado y qué quiere cambiar
  sobre_ti        text,                           -- 2 · lo que quiera contar
  -- Su relación con el móvil
  tiempo_apps     text,                           -- 3 · cuánto tiempo en sus 3 apps
  uso_apps        text,                           -- 4 · para qué las usa (varias)
  gesto_automatico text,                          -- 5 · qué hace al coger el móvil sin motivo
  momentos        text,                           -- 6 · cuándo recurre al móvil (varias)
  quiere_cambiar  text,                           -- 7 · qué le gustaría entender o cambiar
  siente_antes    text,                           -- 8 · qué siente ANTES de coger el móvil
  siente_despues  text,                           -- 8b · y cómo se siente DESPUÉS de soltarlo
  -- Para disfrutar del retiro
  yoga_nivel      text,                           -- 8 · nunca | alguna vez | habitualmente
  yoga_tipos      text,                           -- 8b · qué tipos ha practicado
  esterilla       text,                           -- 9 · si | no
  alimentacion    text,                           -- 10 · ⚠ dato de salud · ver cabecera
  consent_imagen  boolean     not null,           -- 11 · ⚠ permiso de imagen · ver cabecera
  origen          text,                           -- la URL desde la que se envió
  creado_en       timestamptz not null default now()
);

create index if not exists retiro_respuestas_idx on retiro_respuestas (sitio, retiro, creado_en desc);

alter table retiro_respuestas enable row level security;
-- Sin policies, a propósito. Ver el comentario de arriba.

create or replace function retiro_responder(
  p_sitio            text,
  p_retiro           text,
  p_nombre           text,
  p_email            text,
  p_consent_imagen   boolean,
  p_ciudad           text default null,
  p_telefono         text default null,
  p_instagram        text default null,
  p_motivo           text default null,
  p_sobre_ti         text default null,
  p_tiempo_apps      text default null,
  p_uso_apps         text default null,
  p_gesto_automatico text default null,
  p_momentos         text default null,
  p_quiere_cambiar   text default null,
  p_siente_antes     text default null,
  p_siente_despues   text default null,
  p_yoga_nivel       text default null,
  p_yoga_tipos       text default null,
  p_esterilla        text default null,
  p_alimentacion     text default null,
  p_origen           text default null
) returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_id     uuid;
  v_nombre text := btrim(coalesce(p_nombre, ''));
  v_mail   text := btrim(lower(coalesce(p_email, '')));
begin
  if v_nombre = '' then
    raise exception 'Falta el nombre';
  end if;
  if v_mail = '' or position('@' in v_mail) = 0 then
    raise exception 'Falta el correo';
  end if;
  -- El permiso de imagen es obligatorio CONTESTARLO, no obligatorio darlo:
  -- un null aquí acabaría en alguien publicado sin haber dicho que sí.
  if p_consent_imagen is null then
    raise exception 'Falta contestar lo de las fotos';
  end if;

  insert into retiro_respuestas (
    sitio, retiro, nombre, email, ciudad, telefono, instagram,
    motivo, sobre_ti, tiempo_apps, uso_apps, gesto_automatico, momentos, quiere_cambiar,
    siente_antes, siente_despues,
    yoga_nivel, yoga_tipos, esterilla, alimentacion, consent_imagen, origen
  ) values (
    left(btrim(coalesce(p_sitio, 'desconocido')), 40),
    left(btrim(coalesce(p_retiro, 'sin-edicion')), 60),
    left(v_nombre, 120),
    left(v_mail, 160),
    left(btrim(coalesce(p_ciudad, '')), 80),
    left(btrim(coalesce(p_telefono, '')), 40),
    left(btrim(coalesce(p_instagram, '')), 80),
    left(btrim(coalesce(p_motivo, '')), 2000),
    left(btrim(coalesce(p_sobre_ti, '')), 2000),
    left(btrim(coalesce(p_tiempo_apps, '')), 300),
    left(btrim(coalesce(p_uso_apps, '')), 300),
    left(btrim(coalesce(p_gesto_automatico, '')), 1000),
    left(btrim(coalesce(p_momentos, '')), 400),
    left(btrim(coalesce(p_quiere_cambiar, '')), 2000),
    left(btrim(coalesce(p_siente_antes, '')), 2000),
    left(btrim(coalesce(p_siente_despues, '')), 2000),
    left(btrim(coalesce(p_yoga_nivel, '')), 40),
    left(btrim(coalesce(p_yoga_tipos, '')), 300),
    left(btrim(coalesce(p_esterilla, '')), 10),
    left(btrim(coalesce(p_alimentacion, '')), 1000),
    p_consent_imagen,
    left(btrim(coalesce(p_origen, '')), 300)
  )
  returning id into v_id;

  return v_id;
end;
$$;

-- 24/09: la firma de estas dos líneas se había quedado en la de 20 parámetros
-- (antes de siente_antes y siente_despues). Son 22.
revoke all on function retiro_responder(text,text,text,text,boolean,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text) from public;
grant execute on function retiro_responder(text,text,text,text,boolean,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text,text) to anon;

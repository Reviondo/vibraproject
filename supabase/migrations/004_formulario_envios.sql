-- 004 · El formulario de captación de un cliente
--
-- Dónde cae lo que rellena alguien en la landing o en el formulario de un cliente.
-- Mismo modelo de seguridad que el cuaderno (001): RLS activado y NINGUNA policy,
-- así que por REST directo no entra nadie. La única puerta es la función, que es
-- security definer y solo sabe INSERTAR. Leer no puede ni el anon ni la página:
-- lo leemos nosotros por el conector, o el cliente desde su panel de Supabase.
--
-- Aquí sí hay datos personales de las personas que se apuntan. Por eso:
--   · no salen nunca del repositorio (CLAUDE.md §11) — viven solo en esta tabla
--   · la función exige el consentimiento marcado, o no guarda
--   · se guarda de dónde vienen (palanca), que es lo que mide qué puerta funciona

create table if not exists formulario_envios (
  id           uuid primary key default gen_random_uuid(),
  sitio        text        not null,          -- 'reviondo' · qué cliente
  formulario   text        not null,          -- 'comunidad' · qué formulario de ese cliente
  palanca      text,                          -- por qué puerta entró: modo-avion | gestalt | desconexion | (vacío)
  nombre       text        not null,
  telefono     text,
  email        text,
  ciudad       text,                          -- la pidió ella el 22/09; opcional
  mensaje      text,
  consent      boolean     not null default false,
  origen       text,                          -- la URL desde la que se envió
  creado_en    timestamptz not null default now()
);

-- Para las bases donde la tabla ya existía antes de que se pidiera la ciudad.
alter table formulario_envios add column if not exists ciudad text;

create index if not exists formulario_envios_sitio_idx on formulario_envios (sitio, creado_en desc);

alter table formulario_envios enable row level security;
-- Sin policies, a propósito. Ver el comentario de arriba.

-- La firma cambia al entrar `p_ciudad`, y en Postgres una firma nueva NO
-- sustituye a la vieja: crea una segunda funcion con el mismo nombre y la
-- llamada se vuelve ambigua. Por eso la vieja se tira primero.
drop function if exists formulario_enviar(text,text,text,text,text,text,text,boolean,text);

create or replace function formulario_enviar(
  p_sitio      text,
  p_formulario text,
  p_nombre     text,
  p_telefono   text default null,
  p_email      text default null,
  p_palanca    text default null,
  p_mensaje    text default null,
  p_consent    boolean default false,
  p_origen     text default null,
  p_ciudad     text default null
) returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_id uuid;
  v_nombre text := btrim(coalesce(p_nombre, ''));
  v_tel    text := btrim(coalesce(p_telefono, ''));
  v_mail   text := btrim(lower(coalesce(p_email, '')));
begin
  if not coalesce(p_consent, false) then
    raise exception 'Falta el consentimiento';
  end if;
  if v_nombre = '' then
    raise exception 'Falta el nombre';
  end if;
  -- Desde el 22/09 los dos son obligatorios: el telefono porque la comunidad
  -- es de WhatsApp y sin el no se puede meter a nadie, y el correo porque es
  -- por donde salen los 8 microhabitos y la lista de avisos.
  if v_tel = '' then
    raise exception 'Falta el telefono';
  end if;
  if v_mail = '' then
    raise exception 'Falta el correo';
  end if;

  insert into formulario_envios (sitio, formulario, palanca, nombre, telefono, email, mensaje, consent, origen, ciudad)
  values (
    left(btrim(coalesce(p_sitio, 'desconocido')), 40),
    left(btrim(coalesce(p_formulario, 'desconocido')), 40),
    left(btrim(coalesce(p_palanca, '')), 40),
    left(v_nombre, 120),
    left(v_tel, 40),
    left(v_mail, 160),
    left(btrim(coalesce(p_mensaje, '')), 1000),
    true,
    left(btrim(coalesce(p_origen, '')), 300),
    left(btrim(coalesce(p_ciudad, '')), 80)
  )
  returning id into v_id;

  return v_id;
end;
$$;

revoke all on function formulario_enviar(text,text,text,text,text,text,text,boolean,text,text) from public;
grant execute on function formulario_enviar(text,text,text,text,text,text,text,boolean,text,text) to anon;

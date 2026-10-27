-- 007 · Las visitas de sus páginas (documento 4, 27/10)
--
-- Cuánta gente llega a cada página y desde dónde, para su panel.
--
-- De cada visita se guarda: qué página, qué día, el ?c= y el ?p= del enlace,
-- de qué web viene (instagram, whatsapp, google… o «directo») y el aparato
-- (móvil, tablet u ordenador). NADA MÁS: ni la hora, ni la IP, ni el navegador,
-- ni cookies. Con esto no se puede saber quién es nadie.
--
-- Quién escribe: solo la función de Netlify del sitio de la comunidad
-- (sitios/comunidad/netlify/functions/visita.mjs), que lleva la llave del
-- contador en las variables de su Netlify (CONTADOR_LLAVE). La página no la
-- lleva: con la clave publicable sola, visita_contar no guarda nada.
-- La llave vive en el Vault de Supabase con el nombre 'contador_llave', nunca en
-- este repositorio. Para cambiarla, en los dos sitios a la vez:
--   select vault.update_secret((select id from vault.secrets where name = 'contador_llave'), '<nueva>');
--   y CONTADOR_LLAVE en las variables de reviondo-comunidad (se aplica al publicar).
--
-- Quién lee: nadie por la API (RLS activado y ninguna policy, como 004 y 005).
-- Su panel lo lee con el conector de Supabase de Sara.

create table if not exists visitas (
  id       bigint generated always as identity primary key,
  dia      date not null default ((now() at time zone 'Europe/Madrid')::date),
  pagina   text not null,   -- comunidad | retiro-formulario | venta | retiro-itinerario…
  c        text,            -- ?c= del enlace: bio, qr, flowfest…
  p        text,            -- ?p= del enlace: la puerta (modo-avion, gestalt, desconexion…)
  origen   text,            -- de qué web viene: instagram, whatsapp, google, facebook, tiktok, directo, otra web, o una de sus páginas
  aparato  text             -- movil | tablet | ordenador
);

create index if not exists visitas_dia_idx on visitas (dia desc);

alter table visitas enable row level security;
-- Sin policies, a propósito. Ver el comentario de arriba.

create or replace function visita_contar(
  p_llave   text,
  p_pagina  text,
  p_c       text default null,
  p_p       text default null,
  p_origen  text default null,
  p_aparato text default null
) returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_llave text;
begin
  select decrypted_secret into v_llave
    from vault.decrypted_secrets where name = 'contador_llave' limit 1;
  if v_llave is null or p_llave is distinct from v_llave then
    raise exception 'Llave del contador no válida';
  end if;
  if coalesce(p_pagina, '') !~ '^[a-z0-9-]{1,40}$' then
    raise exception 'Página no válida';
  end if;

  insert into visitas (pagina, c, p, origen, aparato) values (
    p_pagina,
    nullif(left(regexp_replace(lower(coalesce(p_c, '')), '[^a-z0-9._-]', '', 'g'), 40), ''),
    nullif(left(regexp_replace(lower(coalesce(p_p, '')), '[^a-z0-9._-]', '', 'g'), 40), ''),
    nullif(left(regexp_replace(lower(coalesce(p_origen, '')), '[^a-z0-9._-]', '', 'g'), 60), ''),
    case when p_aparato in ('movil', 'tablet', 'ordenador') then p_aparato end
  );
end;
$$;

-- Solo escribe y no devuelve nada: no deja leer a nadie.
revoke all on function visita_contar(text,text,text,text,text,text) from public;
grant execute on function visita_contar(text,text,text,text,text,text) to anon;

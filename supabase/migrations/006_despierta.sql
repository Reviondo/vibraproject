-- 006 · Que la base no se duerma
--
-- En el plan gratuito, Supabase pausa el proyecto cuando pasa una semana sin
-- actividad en la base. Si eso pasa, los formularios dejan de guardar y la
-- persona ve "No he podido guardarlo". Ya pasó una vez (13 al 24 de septiembre).
--
-- Una tarea de GitHub (.github/workflows/mantener-la-base-despierta.yml) llama a
-- esta función tres veces al día con la clave publicable. No devuelve nada de
-- nadie: toca la tabla para que cuente como actividad y contesta 'ok'.
-- Es security invoker: como anon, RLS no le deja ver ninguna fila.

create or replace function despierta() returns text
language plpgsql
set search_path = public
as $$
begin
  perform 1 from formulario_envios limit 1;
  return 'ok';
end;
$$;

revoke all on function despierta() from public;
grant execute on function despierta() to anon;

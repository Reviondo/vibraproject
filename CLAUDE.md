# Reviondo · páginas, formularios y panel

Este repositorio es de Sara (Reviondo). Aquí viven sus tres páginas de Netlify,
las migraciones de su base de datos (Supabase) y el panel donde ve lo que llega.
Hablas con Sara o con el equipo que la acompaña (VIBRA). En español, de tú,
en bloques cortos que se lean en el móvil. Sara no es técnica: sin jerga.

Estado a 27/10/2026: los tres sitios están enlazados a este repositorio y
publicados desde el 24-25/09. Cualquier push a `main` vuelve a publicar
comunidad e itinerario (ver «Publicar gasta créditos»). **El repositorio es
público** (visto el 27/10), aunque más abajo se diga privado: lo que se suba
aquí lo ve cualquiera.

## Qué hay y dónde va

| Carpeta | Dónde se ve | Para qué |
|---|---|---|
| `sitios/comunidad/` | https://reviondo-comunidad.netlify.app | La puerta de entrada a su comunidad de WhatsApp. Pública. Su página del retiro enlaza aquí con `?p=modo-avion`, `?p=gestalt` o `?p=desconexion` |
| `sitios/comunidad/netlify.toml` | `…/qr` y `…/qr/<lugar>` | Su QR impreso (27/10). Hoy lleva a su Instagram (lo pidió ella); para contar por lugar, a `?c=qr` o `?c=qr-<lugar>`. El QR no cambia nunca: se cambia el `to` |
| `sitios/retiro-formulario/` | https://reviondo-retiro-formulario.netlify.app | El formulario de ANTES del retiro. Solo para quien ya ha pagado, por privado. La edición va en `?r=` (por defecto `octubre-2026`) |
| `sitios/retiro-itinerario/` | https://reviondo-retiro-itinerario.netlify.app | El itinerario del retiro. Solo para quien ya tiene plaza. Sin precio ni venta |
| `panel/buzon.html` | https://claude.ai/artifact/QSWyWWamURJjkbXVa9d96a | Su panel: quién ha rellenado qué. Solo lectura |
| `supabase/migrations/` | proyecto `loarpexzqkwkrctfrxgq` | 004 comunidad · 005 retiro · 006 despierta. Las tres están aplicadas |
| `.github/workflows/` | pestaña Actions | Toca la base 3 veces al día para que no se pause |
| `docs/instrucciones-23-sep/` | — | Por qué cada página es como es. Manda este archivo |

Sitios de Netlify, en su cuenta (equipo `reviondo-r`, plan gratis):
`reviondo-comunidad` (f2b972f7-e1d3-4715-ac1b-d204b548d0d1) ·
`reviondo-retiro-formulario` (8a245dc1-b6c1-4332-a25a-63d002407a32) ·
`reviondo-retiro-itinerario` (5f6919f9-3ac2-4d21-b1f5-8fdb37d03438).
Producción es pública; las vistas previas piden entrar con la cuenta del equipo.
**Las direcciones no se cambian**: ya están en botones y en mensajes.

Cada sitio publica solo su `public/`, que es un único `index.html`. Nunca se
publica un `.md`, un `.sql` ni nada de `docs/`.

## Publicar gasta créditos: los cambios se agrupan

- Netlify gratis = 300 créditos al mes. **Cada publicación en producción cuesta
  15** (unas 20 al mes entre los tres sitios). Si se acaban, Netlify **apaga los
  tres sitios** hasta el mes siguiente, formulario de la comunidad incluido.
- Por eso: los cambios se hacen en la rama `cambios` y se acumulan ahí. A `main`
  solo se lleva cuando digan «publica», **en un solo merge**. Nunca se empuja a
  `main` para probar.
- **Cualquier push a `main` publica `reviondo-comunidad` y
  `reviondo-retiro-itinerario`, aunque su carpeta no cambie** (visto el 27/10:
  un push que solo tocaba `CLAUDE.md` los publicó a los dos, 15 créditos cada
  uno). `reviondo-retiro-formulario` no se publicó. Así que a `main` no va
  nada que no sea para publicar, ni siquiera documentación, y cada publicación
  cuesta al menos 30.
- Antes de publicar, dilo en una línea: qué sitios salen y cuántos créditos
  cuesta. Las vistas previas de ramas y de pull requests no gastan créditos.
- El panel no pasa por Netlify: republicarlo no cuesta créditos.

## Varias conversaciones a la vez (desde el 27/10)

Sara abre una conversación de Claude Code por encargo. Los encargos están en su
Drive: Sara · Reviondo › 05 · Tu Claude › «Fase 2 · paquetes del 27 oct»
(primero «0 · LÉEME»). Si un documento dice que va en otra conversación o en su
proyecto de Claude, da igual: va en la conversación donde te lo pegan. Si algo
no cuadra con su Drive o con este repositorio, manda lo de Sara.

- **Todas trabajan sobre `cambios` a la vez.** Antes de empezar y antes de cada
  push, trae lo último (`git pull --rebase origin cambios`). Si el push falla
  porque otra conversación ha subido algo, actualiza y repite. Nunca `--force`.
- **A `cambios` solo sube lo que Sara ya ha visto y aprobado.** Lo que está a
  medias se queda en la rama de tu conversación: un merge a `main` publica todo
  lo que haya en `cambios`, también lo de las demás.
- **Antes de publicar**, además de qué sitios salen y cuántos créditos cuesta,
  dile qué hay en `cambios` de otras conversaciones (`git log main..cambios`):
  sale todo junto.
- **Lo que depende de qué:**
  - El QR (documento 9) tiene que estar publicado antes de imprimirlo (30/10).
  - El panel (4) pone el contador de visitas. La puerta (8) y la página de
    venta (7) lo usan si ya existe; si no, deja preparado dónde va y dile a Sara
    que lo pida cuando acabe el panel.
  - Las páginas de gracias (5) y el correo (6) dependen del enlace de reserva
    (2), que se hace con el conector de Stripe, fuera de este repositorio.
- **La página de venta del retiro no está aquí todavía.** Su borrador es un
  artefacto de Sara (conversación «Web Principal», 24/09) y su sitio,
  `reviondo-modo-avion`, está en la cuenta de Netlify de VIBRA, con una
  dirección que ya ha mandado por WhatsApp. Se trae aquí antes de tocarlo; no
  se crea otro sitio sin hablarlo con ella.

## La base de datos (Supabase de Sara)

- Proyecto `loarpexzqkwkrctfrxgq` · organización Reviondo · eu-west-1 · plan gratis.
  URL `https://loarpexzqkwkrctfrxgq.supabase.co` · clave publicable
  `sb_publishable_gq4sOdP2W1BRcsRJ8WOHxA_Vp9fIUKD` (va dentro de los formularios;
  es pública por diseño). **La clave secreta no se escribe nunca en ningún archivo.**
- `formulario_envios` (comunidad) y `retiro_respuestas` (retiro): RLS activado y
  **ninguna policy**. La única entrada son `formulario_enviar` y `retiro_responder`
  (security definer, solo insertan). `despierta()` solo contesta `'ok'`.
  Probado el 24/09 como anónimo: guardan, rechazan sin consentimiento, sin móvil
  o sin contestar lo de las fotos, y anónimo no puede leer ni insertar directo.
- Cambiar una función: en Postgres una firma nueva NO sustituye a la vieja. Se
  tira la vieja primero y el `revoke`/`grant` lleva la firma nueva completa (la
  005 que llegó en el zip tenía la firma vieja en el `grant`; aquí está corregida).
- Cambios de esquema: migración nueva numerada (`007_…`), aplicada con el
  conector de Supabase o en su editor SQL, y guardada en `supabase/migrations/`.
- Si la base se pausa, los formularios dicen «No he podido guardarlo». Se
  reactiva en supabase.com (Resume) o con el conector. Los datos no se pierden.
- **Nunca** crear una vista, policy o función que deje leer a `anon`: la
  clave publicable está en páginas públicas y cualquiera la tiene.

## Datos de personas: reglas que no se tocan

- **Ningún dato de ninguna persona entra en este repositorio**: ni
  exportaciones, ni capturas, ni hojas. `.gitignore` bloquea csv y xlsx.
- `alimentacion` es un **dato de salud**. Sirve para dar de comer en el retiro y
  para nada más: no se copia al registro de personas, ni a correos, ni a hojas,
  ni a contenido. Se mira la semana del retiro y se olvida.
- `consent_imagen` es **un permiso, no una preferencia**. Si es `false`, esa
  persona no sale en nada publicado. Antes de preparar contenido de un retiro,
  se mira. Si alguien pide publicar algo de un retiro, recuérdalo tú.
- El formulario de la comunidad **no pide datos de salud nunca** ni más datos
  de los que tiene (ni DNI, ni dirección, ni pagos). El consentimiento no se
  quita ni se marca por defecto: la función rechaza sin él.
- Los formularios solo escriben. No se publica en abierto nada que lea de la base.

## Las páginas: lo que no se cambia sin preguntarle

- Las preguntas del formulario del retiro **las escribió Sara**: no se
  reescriben para mejorarlas. Se le pregunta. Desde el 23/09 todo es
  obligatorio menos Instagram (lo pidió ella).
- Comunidad: nombre, móvil y correo obligatorios (22/09); ciudad opcional. Cada
  campo nuevo le cuesta gente. Guarda por qué puerta entró cada persona.
- Itinerario: escrito para quien YA ha pagado. La prueba: ¿se lo dirías a
  alguien que ya viene? Si sirve para convencer, va en la página de venta, no
  aquí. Sin nombres de asistentes, sin horas que ella no haya confirmado (va por
  momentos: «Amanece», «Mediodía»), sin modo oscuro, sin prometer nada que no
  esté en su dossier. En cada edición cambian la fecha, los tres días
  (Desacelerar · Profundizar · Integrar), la maleta y las fotos.
- Las dos páginas del retiro llevan `noindex` y no se enlazan desde nada público.

## Marca y voz

- Colores: crema `#EFE8D1` · hueso `#EBE9DD` · oliva `#6B6955` · terracota
  `#8D6657` · marrón `#473328`. Titulares en Noto Serif Display; texto en Jost
  (en lugar de NOW, que es de pago). Siempre en claro.
- Tono: cercano, natural, transparente. Nada de gurú, coach ni marketing. Frases
  cortas. Tuteo.
- **Reviondo NO es solo para chicas**: todo en neutro.
- Prohibido: embudo, funnel, lead, lead magnet, CRM, conversión. Quemadas:
  «desconecta para reconectar», «date el permiso», «mereces», «hazlo por ti».
- Su vocabulario: Reviondera (a quien habla) · evento (media jornada, 2,5 h) ·
  retiro (fin de semana, dos noches) · la comunidad (su grupo de WhatsApp) ·
  las 57 (su lista) · Modo Avión (el retiro y la sesión de las seis semanas).
- Sus tres palancas son las tres puertas: «Necesito parar» (modo avión) ·
  «Quiero conocerme mejor» (Gestalt) · «El móvil me come el día» (desconexión).
- Sus números de móvil: 4 horas al día, 28 a la semana, más de 1.400 al año. No
  se inventan otros. Si falta un dato: FALTA, y de dónde tendría que salir.

## El panel

- `panel/buzon.html` es el artefacto https://claude.ai/artifact/QSWyWWamURJjkbXVa9d96a,
  en la cuenta de Sara. Para cambiarlo: editar el archivo y publicarlo con la
  herramienta Artifact **pasando esa url**, nunca como uno nuevo.
- Lee en directo con el conector de Supabase de quien lo abre (`execute_sql`,
  solo `select`). No guarda ni una respuesta dentro. Solo lo puede abrir ella.
- Si se añade un formulario nuevo: su tabla, su función de entrada, y una
  pestaña más en el panel.

## Cómo trabajar

- Honestidad por delante de agradar: si algo no va a funcionar, se dice antes
  de hacerlo, con datos.
- Con un «sí» corto, se hace sin volver a preguntar.
- Si te piden un archivo, se devuelve entero, no trozos.

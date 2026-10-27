# Reviondo · páginas, formularios y panel

Este repositorio es de Sara (Reviondo). Aquí viven sus tres páginas de Netlify,
las migraciones de su base de datos (Supabase) y el panel donde ve lo que llega.
Hablas con Sara o con el equipo que la acompaña (VIBRA). En español, de tú,
en bloques cortos que se lean en el móvil. Sara no es técnica: sin jerga.

Estado a 27/10/2026: los tres sitios están enlazados a este repositorio y
publicados desde el 24-25/09. Hasta el arreglo del 27/10, cualquier push a
`main` publicaba los tres (ver «Publicar gasta créditos»). **El repositorio es
público** (visto el 27/10), aunque más abajo se diga privado: lo que se suba
aquí lo ve cualquiera.

## Qué hay y dónde va

| Carpeta | Dónde se ve | Para qué |
|---|---|---|
| `sitios/comunidad/` | https://reviondo-comunidad.netlify.app | La puerta de entrada a su comunidad de WhatsApp. Pública. Su página del retiro enlaza aquí con `?p=modo-avion`, `?p=gestalt` o `?p=desconexion` |
| `sitios/comunidad/netlify.toml` | https://reviondo-comunidad.netlify.app/qr | Su QR impreso (27/10): uno solo, un solo diseño («Escanea y entra»). Hoy lleva a su Instagram (lo pidió ella). El QR no cambia nunca: se cambia el `to` y se publica comunidad |
| `sitios/retiro-formulario/` | https://reviondo-retiro-formulario.netlify.app | El formulario de ANTES del retiro. Solo para quien ya ha pagado, por privado. La edición va en `?r=` (por defecto `febrero-2027` desde el 27/10) |
| `sitios/retiro-formulario/public/gracias/` | …/gracias/ | Gracias al pagar la señal del retiro (27/10). Botón al formulario con `?r=febrero-2027`. Su grupo llega en el enlace de pago (`?grupo=`), nunca en el archivo |
| `sitios/retiro-formulario/public/gracias-evento/` | …/gracias-evento/ | Gracias al pagar un evento (27/10). Día, hora, sitio, mapa y grupo llegan en el enlace de pago de cada evento (`?dia=&hora=&lugar=&mapa=&grupo=`): un evento nuevo no se publica |
| `sitios/retiro-itinerario/` | https://reviondo-retiro-itinerario.netlify.app | El itinerario del retiro. Solo para quien ya tiene plaza. Sin precio ni venta |
| `sitios/modo-avion/` | ¿https://reviondo-modo-avion.netlify.app? (por confirmar) | La página de venta del retiro que toca vender ahora: hoy, el de febrero de 2027. **No es su web principal.** Pública. El sitio está en la cuenta de Netlify de VIBRA y **no está enlazado**: un merge a `main` no la publica. Vista previa: https://claude.ai/artifact/WhD5XTvGs2RNHZCBCBLuN5 |
| `sitios/puerta/` | Aún no existe (prevista https://reviondo.netlify.app, si está libre) | Su página principal, la «puerta» (documento 8, 27/10): el único enlace de su biografía, con eventos, retiros y programa Modo Avión a la vista. Pública. **No hay sitio en Netlify todavía**: un merge a `main` no la publica. Vista previa: https://claude.ai/artifact/Uq4pbXjtctHT9SBVADkS8c |
| `panel/panel.html` | https://claude.ai/artifact/5XZTAvvNu5UmEHroyT4tx5 | **Su panel de Reviondo** (documento 4, 27/10): el camino de su gente en directo, de su Supabase y su Stripe. Solo lectura. Ver «El panel» |
| `panel/buzon.html` | https://claude.ai/artifact/QSWyWWamURJjkbXVa9d96a | Su buzón: quién ha rellenado qué, con todas las respuestas. Solo lectura. Sigue como estaba |
| `sitios/comunidad/netlify/functions/visita.mjs` | …/api/visita | El contador de visitas de todas sus páginas (27/10). Ver «El contador de visitas» |
| `supabase/migrations/` | proyecto `loarpexzqkwkrctfrxgq` | 004 comunidad · 005 retiro · 006 despierta · 007 visitas. Las cuatro están aplicadas |
| `.github/workflows/` | pestaña Actions | Toca la base 3 veces al día para que no se pause |
| `docs/instrucciones-23-sep/` | — | Por qué cada página es como es. Manda este archivo |

Sitios de Netlify, en su cuenta (equipo `reviondo-r`, plan gratis):
`reviondo-comunidad` (f2b972f7-e1d3-4715-ac1b-d204b548d0d1) ·
`reviondo-retiro-formulario` (8a245dc1-b6c1-4332-a25a-63d002407a32) ·
`reviondo-retiro-itinerario` (5f6919f9-3ac2-4d21-b1f5-8fdb37d03438).
Producción es pública; las vistas previas piden entrar con la cuenta del equipo.
**Las direcciones no se cambian**: ya están en botones y en mensajes.

Cada sitio publica solo su `public/`: un `index.html` (y en el del formulario,
también `gracias/` y `gracias-evento/`, que llevan el `noindex` del sitio y no se
enlazan desde nada: se llega pagando). La puerta lleva además `fotos/`: WebP
reducidas y sin datos dentro (ni ubicación ni cámara), sueltas para que cada una
cargue solo cuando se ve. Nunca se publica un `.md`, un `.sql` ni nada de `docs/`.

## Publicar gasta créditos: los cambios se agrupan

- Netlify gratis = 300 créditos al mes. **Cada publicación en producción cuesta
  15** (unas 20 al mes entre los tres sitios). Si se acaban, Netlify **apaga los
  tres sitios** hasta el mes siguiente, formulario de la comunidad incluido.
- Por eso: los cambios se hacen en la rama `cambios` y se acumulan ahí. A `main`
  solo se lleva cuando digan «publica», **en un solo merge**. Nunca se empuja a
  `main` para probar.
- **Hasta el 27/10, cualquier push a `main` publicaba los tres sitios, aunque
  su carpeta no cambiara** (visto en su Netlify el 27/10: el push de las 07:46,
  que solo tocaba `CLAUDE.md`, publicó comunidad, itinerario y formulario: 45
  créditos). Por eso cada `netlify.toml` lleva ahora un `ignore` que solo deja
  publicar si cambia su carpeta. En formulario e itinerario no cuenta su propio
  `netlify.toml` (para que meter el `ignore` no los publicara): si solo cambia
  ese archivo, ese sitio no se publica. Comprobado el 27/10 a las 12:09: el push
  1b52927 (solo el QR) publicó comunidad y nada más; formulario e itinerario
  siguieron con su publicación de las 07:46. Aun así, a
  `main` no va nada que no sea para publicar.
- Antes de publicar, dilo en una línea: qué sitios salen y cuántos créditos
  cuesta. Las vistas previas de ramas y de pull requests no gastan créditos.
- Sus dos paneles (buzón y panel) no pasan por Netlify: republicarlos no cuesta
  créditos.

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
  - El contador de visitas (4) ya existe (27/10) y está en la puerta, la venta,
    comunidad y formulario. Una página nueva que quiera contar: ver «El contador
    de visitas».
  - Las páginas de gracias (5) y el correo (6) dependen del enlace de reserva
    (2), que se hace con el conector de Stripe, fuera de este repositorio.
- **La página de venta del retiro** (`sitios/modo-avion/`, desde el 27/10) es
  una página solo para el retiro que toca vender ahora, no su web principal.
  Su web principal es otra cosa: el artefacto de la conversación «Web
  Principal» (https://claude.ai/artifact/C5D7tYs7kHWz41ULbFPyAV, que no se toca
  desde aquí) y la puerta del documento 8. El sitio `reviondo-modo-avion` sigue
  en la cuenta de Netlify de VIBRA, sin enlazar, con una dirección que ya ha
  mandado por WhatsApp: no se crea otro sitio sin hablarlo con ella. Para
  enseñarle la página se republica su vista previa
  (https://claude.ai/artifact/WhD5XTvGs2RNHZCBCBLuN5): no gasta créditos. Los
  huecos marcados «FALTA» se rellenan con lo que diga ella antes de publicarla.
- **La puerta** (`sitios/puerta/`, documento 8, 27/10). Está en `cambios` porque
  lo pidió Sara, sin publicar: no tiene sitio en Netlify, así que un merge a
  `main` no la saca. Se publica cuando ella diga «sí»: se crea el sitio en su
  cuenta (gratis), se enlaza con Base directory = `sitios/puerta` y sale su
  primera publicación (15 créditos). Su `ignore` lleva una guarda: sin ella, la
  primera vez (sin caché) cancelaría su propia publicación.
  - Mide desde el primer día sin contador: cada botón a la comunidad lleva
    `?b=` (portada, eventos, retiros, programa, final), `?p=` (evento, retiro,
    programa → `palanca`) y `?c=` (el que traía al llegar, o `puerta`), más las
    `utm_*` de Instagram. Todo cae en `origen` del formulario.
  - El contador (4) va donde lo marca su script: contar la visita y cada clic
    en `[data-boton]`.
  - Cuando la página de venta (7) esté publicada, el botón de Retiros va allí
    («Ver el retiro →»). Hasta entonces lleva a la comunidad.
  - Eventos: solo el próximo. Cuando se sepa la fecha, se deja solo esa.
  - Testimonios: literales, de la pregunta de testimonio de sus formularios,
    sin nombre. Con el sí de una persona, su nombre va en su `figcaption`.
  - Cuando esté publicada, Sara decide si su biografía y su QR pasan a la
    puerta (en el QR, el `to` de `sitios/comunidad/netlify.toml`).

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

Tiene dos, los dos en su cuenta de Claude, solo los puede abrir ella, y no
guardan ni una respuesta ni un pago dentro: leen en directo con los conectores
de quien los abre. Para cambiar cualquiera: editar el archivo y publicarlo con
la herramienta Artifact **pasando su url**, nunca como uno nuevo.

- **`panel/panel.html`**, su panel de Reviondo (documento 4, 27/10):
  https://claude.ai/artifact/5XZTAvvNu5UmEHroyT4tx5. Lo pidió **en Claude, no en
  Netlify** («un enlace que corre en directo»): por eso no hay llave `?t=`, ni
  función de Netlify que lea su base, ni clave de Stripe en ningún sitio.
  Lee su Supabase (`execute_sql`, solo `select`, solo las columnas que enseña)
  y su Stripe (`stripe_api_read`: `GetCheckoutSessions` y `GetPaymentLinks`,
  cuenta `acct_1UURpH9zz9XRvFad`, en real). Va en el orden que pidió ella, el
  camino de su gente: llegan (visitas) → entran (comunidad) → reservan (pagos)
  → lo cobrado este mes → su retiro de febrero (plazas de 9; las 3 primeras
  señales, a 435 €; el resto, a 485 €) → todas sus personas. Arriba, «hoy ·
  esta semana · 30 días». No quiso objetivo de ingresos al lado (27/10).
- Cada persona sale una vez: se juntan por correo o teléfono sus filas de
  comunidad, formulario del retiro y pagos. Lo que le interesa: lo que pagó; si
  no, lo que marcó en «¿Qué te gustaría encontrar?» (retiros → retiro, planes
  para parar → evento, conocerme mejor → programa) o el `?p=` con el que entró
  (evento, retiro, programa, desde su puerta). Lo eligió ella.
- Su siguiente paso y el mensaje de WhatsApp los decide `siguientePaso()`:
  pagó la señal sin formulario → mandárselo; vino a otra edición → contarle la
  de ahora; le interesa retiro, evento o programa → contárselo; acaba de entrar
  → saludarle. Los mensajes los propuso Claude: si Sara cambia uno, se cambia ahí.
- Cada edición nueva del retiro: `CONFIG.retiro` (clave, fechas, plazas,
  precios, enlace del formulario). Los pagos se reconocen por el `metadata` del
  enlace de pago (`retiro: febrero-2027`); un evento, por `tipo: evento` o por
  «evento» en su descripción. Quien haga enlaces de pago, que siga igual.
- **`panel/buzon.html`**, su buzón: https://claude.ai/artifact/QSWyWWamURJjkbXVa9d96a.
  Todas las respuestas de los formularios, tal cual. Si se añade un formulario
  nuevo: su tabla, su función de entrada, y una pestaña más en el buzón.

## El contador de visitas

- Cada página lleva al final un trocito («Contador de visitas») que avisa a
  `sitios/comunidad/netlify/functions/visita.mjs`. Esa función es la única que
  apunta visitas (`visita_contar()`, migración 007) con la llave del contador.
- Se guarda la página, el día, el `?c=` y el `?p=`, de qué web viene y el aparato.
  Ni hora, ni IP, ni navegador, ni cookies. No cuentan robots, vistas previas ni
  direcciones que no estén en `PAGINAS` de la función.
- **La llave**: está en el Vault de Supabase (`contador_llave`), creada allí sin
  que nadie la viera, y su copia tiene que estar en las variables de Netlify de
  `reviondo-comunidad` como `CONTADOR_LLAVE`. La copia la pone Sara a mano (27/10:
  el paso a paso se lo dio su conversación del panel). **Nunca** se escribe en un
  archivo ni en una conversación. Sin ella, la función no cuenta nada (lo dice
  en sus registros) y las páginas siguen igual.
- Sara no cuenta: abre una vez cada página con `#no-me-cuentes` al final (los
  enlaces están en su panel, en «Que no te cuente a ti»).
- Una página nueva: su dirección en `PAGINAS` de la función (y en
  `CONFIG.paginas` del panel) y el trocito al final. Ojo: la puerta va con
  https://reviondo.netlify.app y la venta con https://reviondo-modo-avion.netlify.app;
  si al crearlas la dirección es otra, se cambia ahí o no cuentan.
- El itinerario **todavía no lo lleva**: se le pone cuando se actualice para
  febrero, para no publicarlo solo por esto (15 créditos).

## Cómo trabajar

- Honestidad por delante de agradar: si algo no va a funcionar, se dice antes
  de hacerlo, con datos.
- Con un «sí» corto, se hace sin volver a preguntar.
- Si te piden un archivo, se devuelve entero, no trozos.

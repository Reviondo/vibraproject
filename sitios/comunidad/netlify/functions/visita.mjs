// Contador de visitas de las páginas de Sara (documento 4, 27/10).
//
// Cada página avisa aquí al abrirse (el trocito «Contador de visitas» al final
// de su index.html). Esta función es la única que apunta la visita en su base:
// lleva la llave del contador, que vive en las variables de este sitio en
// Netlify (CONTADOR_LLAVE) y nunca en una página ni en el repositorio.
//
// Se guarda qué página, el día, el ?c= y el ?p= del enlace, de qué web viene y
// el aparato. Ni la IP, ni el navegador entero, ni cookies. No cuentan los
// robots, ni las vistas previas, ni Sara (ver el trocito de las páginas).
//
// Una página nueva que quiera contar: su dirección aquí, en PAGINAS, y el
// trocito al final de su página. La base: supabase/migrations/007_visitas.sql.

const SUPA = 'https://loarpexzqkwkrctfrxgq.supabase.co'
const KEY = 'sb_publishable_gq4sOdP2W1BRcsRJ8WOHxA_Vp9fIUKD' // la PUBLICABLE, la de los formularios

// Solo cuentan sus direcciones de verdad, no las vistas previas.
const PAGINAS = {
  'https://reviondo-comunidad.netlify.app': 'comunidad',
  'https://reviondo-retiro-formulario.netlify.app': 'retiro-formulario',
  'https://reviondo-retiro-itinerario.netlify.app': 'retiro-itinerario',
  'https://reviondo-modo-avion.netlify.app': 'venta',
}

const ROBOT = /bot|crawl|spider|slurp|preview|facebookexternalhit|whatsapp|telegram|discord|skype|headless|lighthouse|pagespeed|python|curl|wget|okhttp|httpclient|java\//i

// De qué web viene, en una palabra. Si es otra, su dirección sin «www.».
export function deDonde(ref, ua) {
  const h = String(ref || '').toLowerCase().replace(/^www\./, '').slice(0, 100)
  if (!h) {
    // Instagram y Facebook abren los enlaces en su navegador y a veces no dicen de dónde.
    if (/instagram/i.test(ua)) return 'instagram'
    if (/FBAN|FBAV/i.test(ua)) return 'facebook'
    return 'directo'
  }
  if (/(^|\.)instagram\.com$/.test(h)) return 'instagram'
  if (/(^|\.)(whatsapp\.com|wa\.me)$/.test(h)) return 'whatsapp'
  if (/(^|\.)(facebook\.com|fb\.com|messenger\.com)$/.test(h)) return 'facebook'
  if (/(^|\.)google\.[a-z.]+$/.test(h)) return 'google'
  if (/(^|\.)tiktok\.com$/.test(h)) return 'tiktok'
  if (/(^|\.)linktr\.ee$/.test(h)) return 'linktree'
  for (const [direccion, pagina] of Object.entries(PAGINAS)) {
    if (direccion === 'https://' + h) return pagina // viene de otra de sus páginas
  }
  return h
}

export function aparato(ua) {
  if (/iPad|Tablet|Android(?!.*Mobile)/i.test(ua)) return 'tablet'
  if (/Mobi|iPhone|iPod|Android/i.test(ua)) return 'movil'
  return 'ordenador'
}

export default async (req, context) => {
  const origen = req.headers.get('origin') || ''
  const pagina = PAGINAS[origen]
  // Las páginas de los otros sitios llaman desde fuera: el navegador pide este permiso.
  const cabeceras = pagina ? { 'access-control-allow-origin': origen, vary: 'Origin' } : { vary: 'Origin' }
  const listo = () => new Response(null, { status: 204, headers: cabeceras })

  if (req.method !== 'POST' || !pagina) return listo()
  if (context.deploy?.context !== 'production') return listo()
  const ua = req.headers.get('user-agent') || ''
  if (!ua || ROBOT.test(ua)) return listo()
  const llave = Netlify.env.get('CONTADOR_LLAVE')
  if (!llave) {
    console.log('Falta CONTADOR_LLAVE en las variables de Netlify de este sitio')
    return listo()
  }

  let d = {}
  try { d = JSON.parse((await req.text()).slice(0, 2000)) || {} } catch {}
  const corto = (v, n) => String(v ?? '').slice(0, n)

  try {
    const r = await fetch(SUPA + '/rest/v1/rpc/visita_contar', {
      method: 'POST',
      headers: { apikey: KEY, authorization: 'Bearer ' + KEY, 'content-type': 'application/json' },
      body: JSON.stringify({
        p_llave: llave,
        p_pagina: pagina,
        p_c: corto(d.c, 40),
        p_p: corto(d.p, 40),
        p_origen: deDonde(corto(d.r, 100), ua),
        p_aparato: aparato(ua),
      }),
    })
    if (!r.ok) console.log('visita_contar no ha guardado:', r.status, (await r.text()).slice(0, 200))
  } catch (e) {
    console.log('visita_contar no contesta:', String(e).slice(0, 200))
  }
  return listo()
}

export const config = { path: '/api/visita' }

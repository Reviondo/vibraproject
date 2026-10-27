# Reviondo · páginas y formularios

Las tres páginas de Sara, su base de datos y su panel. Las reglas completas
están en `CLAUDE.md`; esto es lo mínimo para ponerlo en marcha.

| Página | Dirección | Carpeta |
|---|---|---|
| Formulario de la comunidad | https://reviondo-comunidad.netlify.app | `sitios/comunidad` |
| Formulario de antes del retiro | https://reviondo-retiro-formulario.netlify.app | `sitios/retiro-formulario` |
| Itinerario del retiro | https://reviondo-retiro-itinerario.netlify.app | `sitios/retiro-itinerario` |
| Página de venta del retiro (en la cuenta de VIBRA, sin enlazar) | https://reviondo-modo-avion.netlify.app | `sitios/modo-avion` |
| Su panel (en Claude) | https://claude.ai/artifact/QSWyWWamURJjkbXVa9d96a | `panel/buzon.html` |

Lo que rellena la gente cae en **su** Supabase (organización Reviondo,
proyecto `loarpexzqkwkrctfrxgq`), y lo ve en su panel. Nada de eso pasa por aquí.

## Ponerlo en marcha (una sola vez)

1. **Subir este repositorio a `main`.** Tal cual, en un commit.
2. **Enlazar cada sitio de Netlify al repositorio.** Con la cuenta de Sara en
   Netlify, para cada uno de los tres sitios:
   *Project configuration → Build & deploy → Continuous deployment → Link repository*
   → GitHub → `Reviondo/vibraproyect` → rama `main` y:

   | Sitio | Base directory | Build command | Publish directory |
   |---|---|---|---|
   | reviondo-comunidad | `sitios/comunidad` | (vacío) | `sitios/comunidad/public` |
   | reviondo-retiro-formulario | `sitios/retiro-formulario` | (vacío) | `sitios/retiro-formulario/public` |
   | reviondo-retiro-itinerario | `sitios/retiro-itinerario` | (vacío) | `sitios/retiro-itinerario/public` |

   Al enlazar, cada sitio se publica solo una vez: 3 × 15 = 45 créditos.
   **Los sitios no se crean de nuevo**: ya existen y sus direcciones no cambian.
3. **Comprobar.** Abrir las tres direcciones y mandar una respuesta de prueba en
   cada formulario. Tienen que salir en el panel.

## Publicar cambios después

Los cambios se acumulan en la rama `cambios`. Cuando haya que publicar, un solo
merge a `main`. Hoy (27/10) cualquier push a `main` publica los tres sitios,
hayan cambiado o no: 3 × 15 = 45 créditos. El plan gratis da 300 al mes; si se
acaban, Netlify apaga los tres sitios. Más detalle en `CLAUDE.md`.

La página de venta del retiro (`sitios/modo-avion`) no se publica desde aquí:
su sitio está en la cuenta de Netlify de VIBRA y no está enlazado.

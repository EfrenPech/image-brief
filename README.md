# image-brief

Skill de agente para dirigir la generación de imágenes con IA.

La idea central: **la calidad de una imagen se decide antes de generarla**. El agente nunca genera a ciegas; primero pregunta.

Implementa el método de siete líneas publicado por [beailabs](https://blog.beailabs.com/p/crear-imagenes-chatgpt) — ver [atribución](#atribución).

## Instalación

```bash
git clone https://github.com/EfrenPech/image-brief
cd image-brief
./scripts/install.sh --dry-run     # ver qué cambiaría
./scripts/install.sh                # instalar en todos los runtimes
./scripts/install.sh claude codex   # solo algunos
```

Cada instalación es un **directorio real**, no un symlink: Codex ignora los enlaces durante el descubrimiento de skills y una instalación enlazada nunca cargaría ahí.

| Runtime | Ruta |
| --- | --- |
| Claude Code | `~/.claude/skills/image-brief/` |
| Codex | `~/.codex/skills/image-brief/` |
| OpenCode | `~/.config/opencode/skills/image-brief/` |
| Pi / estándar `.agents` | `~/.agents/skills/image-brief/` |
| Antigravity | `~/.gemini/antigravity/skills/image-brief/` |
| Antigravity CLI | `~/.gemini/antigravity-cli/skills/image-brief/` |
| Gemini CLI | `~/.gemini/skills/image-brief/` |

## Cómo funciona

Pides una imagen. El agente no genera: extrae de tu petición todo lo que ya has dicho, carga tu perfil de marca si existe, y pregunta **solo las líneas que faltan**, en lotes de máximo 4, cada una con una propuesta por defecto para que puedas responder "sí".

Las siete líneas del encargo:

```
Formato: [proporción y orientación]
Qué es: [tipo de imagen y uso]
Tema: [contenido, escena o composición principal]
Estilo: [diseño, movimiento artístico o técnica]
Texto exacto: "[texto 1]", "[texto 2]" y ningún otro texto
Tipografía y paleta: [tipo de letra y colores]
Evita: [elementos concretos que no quieres]
```

Después emite el brief completo, genera con la herramienta de imagen que tenga disponible, y antes de mostrarte el resultado pasa una revisión de cuatro puntos: **texto** (tildes, fechas, sin frases añadidas), **dirección visual** (que el estilo se vea en la composición y no solo en el color), **fidelidad** (forma y logo del producto) y **uso real** (encuadre, tamaño, legibilidad).

Al iterar, cambia **una sola línea** por vez y reimprime el brief entero, para que veas qué cambió.

## Perfil de marca

Para no preguntar estilo, tipografía, paleta y exclusiones en cada imagen, el skill usa un perfil de marca:

- global: `~/.config/image-brief/brand.md`
- por proyecto: `<proyecto>/.image-brief/brand.md` (tiene prioridad campo por campo)

No existe hasta la primera vez que el agente te ofrezca guardar tus defaults y aceptes. La plantilla está en `skills/image-brief/assets/brand.template.md`.

## Estructura

```
skills/image-brief/
├── SKILL.md                          # contrato que ejecuta el agente (inglés)
├── references/
│   ├── brand-profile.md              # contrato y rutas del perfil de marca
│   ├── styles.md                     # catálogo de estilos en 3 capas
│   ├── product-images.md             # vocabulario de imágenes de producto
│   ├── generic-ai-tells.md           # vocabulario de exclusiones
│   └── brief.es.md                   # el método en español
└── assets/
    └── brand.template.md             # plantilla del perfil de marca

scripts/install.sh                    # instalador multiruntime
research/SOURCES.md                   # atribución y procedencia
odd/tasks/image-brief-skill.md        # especificación y tareas del trabajo
```

`SKILL.md` está en inglés a propósito: los agentes lo ejecutan con más fidelidad en ese idioma, y es la convención del ecosistema de skills. La referencia en español está en `references/brief.es.md`.

## Modificar el skill

Edita `skills/image-brief/` y vuelve a ejecutar `./scripts/install.sh`. Las copias instaladas se sobrescriben; si editas una copia directamente, la siguiente instalación la pierde.

## Atribución

El método de las siete líneas, el modelo de tres capas del estilo y el catálogo de estilos son de **beailabs** ([video](https://youtu.be/FX8c_ytLuIQ) · [blog](https://blog.beailabs.com/p/crear-imagenes-chatgpt)). Su blog publica el método de forma abierta y ofrece una guía descargable, que es justo lo que este skill automatiza.

El contrato de entrevista, el perfil de marca, el vocabulario de producto y el instalador son implementación propia. El detalle está en [`research/SOURCES.md`](research/SOURCES.md).

La transcripción literal del video se usó como material de trabajo y **no se distribuye aquí**: es una obra de terceros.

## Licencia

Apache-2.0. Ver [LICENSE](LICENSE). La licencia cubre el código y la documentación de este repositorio, no el método de beailabs, que conserva sus derechos.
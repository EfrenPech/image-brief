# skill-diseño

Skill de agente para dirigir la generación de imágenes con IA, construido a partir del método del video [«Deja de generar imágenes genéricas con ChatGPT»](https://youtu.be/FX8c_ytLuIQ) (beailabs).

La idea central: **la calidad de una imagen se decide antes de generarla**. El agente nunca genera a ciegas; primero pregunta.

## Qué hay aquí

| Ruta | Qué es |
| --- | --- |
| `research/transcript.es.md` | Transcripción completa con timestamps (18:05). Carruseles omitidos. |
| `skills/image-brief/` | El skill. Fuente de verdad. |
| `scripts/install.sh` | Instala el skill en todos los runtimes de agente de esta máquina. |
| `odd/tasks/image-brief-skill.md` | Especificación y tareas del trabajo. |

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

No existe todavía. Se crea la primera vez que el agente te ofrezca guardar tus defaults y aceptes. La plantilla está en `skills/image-brief/assets/brand.template.md`.

## Instalación

```bash
./scripts/install.sh --dry-run     # ver qué cambiaría
./scripts/install.sh                # instalar en todos
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

El script verifica después de cada copia que el contenido instalado coincide con la fuente.

## Estructura del skill

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
```

## Modificar el skill

Edita `skills/image-brief/` y vuelve a ejecutar `./scripts/install.sh`. Las copias instaladas se sobrescriben; si editas una copia directamente, la siguiente instalación la pierde.

Al terminar, refresca el índice con `/skill-registry:refresh`.
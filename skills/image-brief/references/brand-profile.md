# Brand profile

The profile removes the questions you would otherwise answer on every single image: style, typography, palette and exclusions. Only `Formato`, `Qué es`, `Tema` and `Texto exacto` remain per-request.

## Resolution order

1. `<project>/.image-brief/brand.md` — project override, where `<project>` is the root of
   the repository or working directory the agent runs in.
2. `~/.config/image-brief/brand.md` — global profile.
3. No file — ask for every line, and offer to persist the answers once.

Load the first file that exists. A project override wins field by field, not file by file: merge the two, project value wins per field.

An empty or missing field always falls back to the global file, and then to asking. A field is never simply suppressed.

## Schema

```markdown
# Brand profile

house_style: <design layer — e.g. contemporary editorial, clean tech>
art_movement: <second layer, optional>
technique: <third layer, optional>
typography: <typeface name + description of its character and width>
palette: <named colors>
avoid: <the exclusions that always apply, comma separated>
```

Every field is optional. An empty or missing field means "ask the user".

## Lifecycle

- **Ask once.** When a field is unknown, ask it inside the first batched interview, with a proposed default.
- **Offer to persist.** After the first generated image, ask once: save style, typography, palette and exclusions as the brand profile.
- **Write only on approval.** Create `~/.config/image-brief/brand.md` from `assets/brand.template.md` only after the user says yes.
- **Update on explicit instruction.** Never rewrite an existing field silently. When the user changes a default, confirm and then write.
- **Project scope wins.** If the user asks for a profile that belongs to one project, write `<project>/.image-brief/brand.md` instead.

## Precedence inside the brief

| Line | Source |
| --- | --- |
| `Estilo` | profile `house_style` + `art_movement` + `technique`, overridable per request |
| `Tipografía y paleta` | profile `typography` + `palette`, overridable per request |
| `Evita` | profile `avoid` + `references/generic-ai-tells.md`, always merged |
| `Formato`, `Qué es`, `Tema`, `Texto exacto` | always per request |

A request that contradicts the profile wins for that image. Note the override in the brief so the user sees it.

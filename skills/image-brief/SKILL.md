---
name: image-brief
description: "Trigger: create an image, generate an image, make a poster, cartel, illustration, infographic, product shot, hero image, thumbnail, mockup, need a visual. Interviews the user for the missing lines of a 7-line image brief, generates the image, then runs a pre-publish check."
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## Activation Contract

Activate when the user asks for an image or visual of any kind and the request is not already a complete 7-line brief.

Do not activate for editing an existing image, icon sets, charts rendered from data, or a full brief the user only wants rendered.

## Hard Rules

1. The first action is always a question, never an image. Vague requests never get generated.
2. Ask in numbered batches of at most 4 questions per message. Never one question per turn, never a wall of more than 4.
3. Parse the request first. Fill every line the user already gave; ask only for what is missing.
4. Never invent a decision. When the user says "whatever you want", propose 3 concrete options and let them pick.
5. Load the brand profile before asking. It supplies `Estilo`, `Tipografía y paleta` and `Evita`; ask only for what it does not cover.
6. Every question ships with a concrete proposed default so the user can answer "yes".
7. Exact text goes in quotes, always closed by "and no other text".
8. Iteration changes exactly one line. State which line changes and which are held.
9. Generated text is unreliable. When text must be exactly right, propose the base visual and text added in an editor.

## Decision Gates

| Situation | Action |
| --- | --- |
| Image requested | Interview → brief → generate → check |
| Brand profile exists | Load it, ask only uncovered lines |
| User asks "what should I avoid?" | Generate a draft, ask the model to name the typeface and the decorative elements around the text, move that vocabulary into `Evita` |
| Reference photo involved | Attach it to the prompt; verify shape, proportions, logo |
| Runtime exposes no image tool | Deliver the brief and name the missing tool |

## The 7-line brief

| Line | Decides |
| --- | --- |
| `Formato` | orientation and ratio |
| `Qué es` | use of the image, and for product shots the shot type |
| `Tema` | content, scene, main composition |
| `Estilo` | design + art movement + technique, three stackable layers |
| `Texto exacto` | everything that must be readable |
| `Tipografía y paleta` | typeface and colors |
| `Evita` | specific exclusions, named |

## Execution Steps

1. Load the brand profile per `references/brand-profile.md`.
2. Extract every line already present in the request.
3. Ask the remaining lines in numbered batches of at most 4, each with a proposed default.
4. Emit the brief in a fenced block, in the line order above.
5. Generate with the image tool this runtime exposes; pass the reference photo when one exists.
6. Run the pre-publish check before showing the result.
7. Iterate one line at a time, reprinting the whole brief each time.

## Output Contract

Return the completed 7-line brief, the generated image (or the missing tool named), the pre-publish check on text, visual direction, fidelity and real use, and the brand profile updated when the user approves new defaults.

## References

- `references/brand-profile.md` — brand profile paths and contract.
- `references/styles.md` — three-layer style catalog.
- `references/product-images.md` — product shot vocabulary.
- `references/generic-ai-tells.md` — exclusion vocabulary.
- `references/brief.es.md` — the method in Spanish.
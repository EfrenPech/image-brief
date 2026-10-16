# Feature: image-brief skill

Turn the image-generation method from the beailabs video into a cross-harness agent skill that interviews the user before generating anything.

## Specs

- **S1** — "analiza este video transcribelo". Source: https://youtu.be/FX8c_ytLuIQ ("Deja de generar imágenes genéricas con ChatGPT", beailabs, 18:05). Deliverable: a timestamped transcript. **Not distributed** — it is a literal reproduction of a third-party work, so it is excluded from the public tree by `.gitignore` and kept as local working material. See `research/SOURCES.md`.
- **S2** — "que las recomendaciones para crear imagenes las volvamos un skill para claude, antigravity, py, codex opencode". One skill bundle, installed as real directories into every listed runtime.
- **S3** — "con el objetivo de que si necesito una imagen la ia me pide informacion como lo hacen en el video para tner mejores resultados en la generacion de imagenes". The skill's first action is always a question, never an image.
- **S4** — "del video solo omite lo de los carouseles". Chapters 13:02–18:05 are excluded from every artifact.
- **S5** — Decision: `SKILL.md` and agent-facing references in English; one Spanish reference (`brief.es.md`) for the user.
- **S6** — Decision: full loop — interview, emit the brief, generate, then run the 4-point pre-publish check from the video.
- **S7** — Decision: persistent brand profile so the agent stops asking for style, typography, palette and exclusions on every request.
- **S8** — Decision: install into the 5 requested runtimes plus Gemini CLI.

## Tasks

| ID | Task | Specs | Route | Commit |
| --- | --- | --- | --- | --- |
| T1 | Transcribe the video and extract the method, carousels omitted | S1, S4 | inline | (not published) |
| T2 | Write the skill bundle: `SKILL.md`, `references/`, `assets/` | S2, S3, S5, S6 | inline | `245e9f2` |
| T3 | Define the brand-profile contract and template | S7 | inline | `245e9f2` |
| T4 | Installer that copies the bundle to every harness, real dirs not symlinks | S8 | inline | `eb10c3d` |
| T5 | Verify: frontmatter valid, installs byte-identical, discovery per runtime, dry-run interview | S2, S6, S8 | verify | verified, no commit |
| T6 | Document the skill and index it in the skill registry | S2 | inline | `c62f73e` |

## Log

- **L1 (verbatim user request):** "https://youtu.be/FX8c_ytLuIQ?si=k4N4hIoSM8g0OxTS analiza este video transcribelo y me gustaria que las reocmendaciones para crear imagenes las volvamos un skill para claude, antigravity , py, codex opencode con el objetivo de que si necesito una imagen  la ia me pida infomracion  como lo hacen en el video para tner mejores resultados en la generacion de imagenes, del video solo omite lo de los carouseles"
- **L2 (evidence):** Video method reduces to 3 causes of generic output (no specification, "make it pretty", unnamed exclusions), a 7-line brief, a 3-layer style model, and a product-image vocabulary driven by the `Qué es` line. Companion blog https://blog.beailabs.com/p/crear-imagenes-chatgpt carries the full style catalog and the pre-publish checklist.
- **L3 (evidence):** Harness skill roots on this machine — Codex skips symlinks, so every install must be a real directory. `~/.agents/skills/` is read by Pi and OpenCode, so it is the highest-value single target.
- **L4 (decision, user):** English `SKILL.md` + Spanish reference; full loop with pre-publish check; persistent brand profile; install to 5 runtimes + Gemini CLI.- **L5 (evidence):** `gentle-ai-verify` blocked the first draft on a real contradiction — `max 4 questions per message` against `one batched message` cannot both hold with 7 lines missing. Fixed to numbered batches of at most 4. Three partials also closed: watercolor and other finishes missing from the style catalog, the fourth catalog section unmapped to a layer, and `<project>` undefined in the brand-profile merge rule. Re-verified clean, 7 installed copies byte-identical, carousel grep empty.
- **L6 (evidence):** Installer shipped as a real directory copy, not a symlink, because Codex skips symlinks during skill discovery. A linked install would load in four runtimes and silently never load in the fifth.
- **L7 (outcome):** Branch `feat/image-brief-skill`, 5 commits, unpushed. Skill installed to 7 roots: Claude, Codex, OpenCode, `~/.agents`, Antigravity, Antigravity CLI, Gemini CLI.
- **L8 (evidence):** History rewritten with `git filter-branch` to purge the verbatim transcript from every commit, not just the tip. A normal push of the branch transfers zero transcript objects; the transcript survives on disk, gitignored. The rewrite orphaned the in-flight native review lineage `review-13cb8d3f6fe0a2eb`, whose candidate worktree is a detached HEAD on a commit that no longer exists in the branch.

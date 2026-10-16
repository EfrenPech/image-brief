#!/usr/bin/env bash
# Install the image-brief skill into every agent runtime on this machine.
#
# Every install is a real directory: Codex skips symlinks during skill
# discovery, so a linked install would silently never load there.
#
# Usage:
#   scripts/install.sh                 # install to every root
#   scripts/install.sh --dry-run       # show what would change
#   scripts/install.sh claude codex    # install to named roots only

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_NAME="image-brief"
SRC="$REPO_ROOT/skills/$SKILL_NAME"
HOME_DIR="${HOME:?HOME is not set}"

# Parallel arrays: every root is scanned by at least one runtime listed.
ROOT_NAMES=(claude codex opencode agents antigravity antigravity-cli gemini)
ROOT_PATHS=(
  "$HOME_DIR/.claude/skills"
  "$HOME_DIR/.codex/skills"
  "$HOME_DIR/.config/opencode/skills"
  "$HOME_DIR/.agents/skills"
  "$HOME_DIR/.gemini/antigravity/skills"
  "$HOME_DIR/.gemini/antigravity-cli/skills"
  "$HOME_DIR/.gemini/skills"
)

DRY_RUN=0
SELECTED=()

known_root() {
  local candidate="$1" i
  for i in "${!ROOT_NAMES[@]}"; do
    [[ "${ROOT_NAMES[$i]}" == "$candidate" ]] && return 0
  done
  return 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) sed -n '2,12p' "${BASH_SOURCE[0]}"; exit 0 ;;
    *)
      known_root "$1" || { echo "unknown root: $1" >&2; echo "available: ${ROOT_NAMES[*]}" >&2; exit 2; }
      SELECTED+=("$1"); shift ;;
  esac
done

[[ -f "$SRC/SKILL.md" ]] || { echo "missing source: $SRC/SKILL.md" >&2; exit 1; }
[[ ${#SELECTED[@]} -gt 0 ]] || SELECTED=("${ROOT_NAMES[@]}")

# Fingerprint of the source, used to confirm every install matches.
fingerprint() { find "$1" -type f -exec sha256sum {} + | sed "s| $1/| |" | sort -k2 | sha256sum | cut -d' ' -f1; }
SRC_SUM="$(fingerprint "$SRC")"

fail=0
for name in "${SELECTED[@]}"; do
  i=0
  while [[ "${ROOT_NAMES[$i]}" != "$name" ]]; do i=$((i + 1)); done
  root="${ROOT_PATHS[$i]}"
  dest="$root/$SKILL_NAME"

  if [[ -L "$dest" ]]; then
    echo "FAIL  $name: $dest is a symlink; Codex will not discover it"
    fail=1
    continue
  fi

  if [[ "$DRY_RUN" -eq 1 ]]; then
    if [[ -d "$dest" ]]; then echo "would replace  $dest"; else echo "would create  $dest"; fi
    continue
  fi

  mkdir -p "$root"
  rm -rf "$dest"
  cp -R "$SRC" "$dest"

  if [[ "$(fingerprint "$dest")" == "$SRC_SUM" ]]; then
    echo "ok    $name -> $dest"
  else
    echo "FAIL  $name: install does not match source"
    fail=1
  fi
done

[[ "$DRY_RUN" -eq 1 ]] && echo && echo "dry run: source fingerprint $SRC_SUM"
exit "$fail"
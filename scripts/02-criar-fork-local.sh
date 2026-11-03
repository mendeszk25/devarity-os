#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/upstream/lilith"
DEST="$ROOT/worktrees/devarity-lilith"
[[ -d "$SRC/.git" ]] || { echo 'Primeiro rode scripts/01-sincronizar-lilith.sh'; exit 1; }
[[ ! -e "$DEST" ]] || { echo 'Fork local já existe; não sobrescreverei alterações.'; exit 1; }
mkdir -p "$ROOT/worktrees"
git clone --local "$SRC" "$DEST"
git -C "$DEST" switch -c devarity/main
python3 "$ROOT/scripts/aplicar-patch.py" "$DEST" "$ROOT/assets/tokens/devarity-core.json"
printf '\nFork de trabalho: %s\n' "$DEST"
printf 'Reveja as alterações: git -C "%s" diff\n' "$DEST"
printf 'NÃO houve make install, nem alteração de sua sessão atual.\n'

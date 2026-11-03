#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$ROOT/upstream/lilith"
REV='4acbf2871316dce751a5448ea799953bf0bd3ad8'
if [[ -e "$DEST" ]]; then
  echo "Parando: $DEST já existe; nenhuma alteração foi feita."
  echo "Para atualizar manualmente, inspecione o repositório e use git dentro dele."
  exit 1
fi
command -v git >/dev/null || { echo 'git não encontrado'; exit 1; }
mkdir -p "$ROOT/upstream"
git clone https://github.com/ohto121/lilith.git "$DEST"
git -C "$DEST" checkout --detach "$REV"
actual="$(git -C "$DEST" rev-parse HEAD)"
[[ "$actual" == "$REV" ]] || { echo "Commit inesperado: $actual"; exit 1; }
printf 'Lilith upstream fixado no commit %s\n' "$actual"
printf 'Não houve instalação no Arch.\n'

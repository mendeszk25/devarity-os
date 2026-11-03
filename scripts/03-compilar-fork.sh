#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$ROOT/worktrees/devarity-lilith"
[[ -d "$DEST/.git" ]] || { echo 'Primeiro crie o fork com scripts/02-criar-fork-local.sh'; exit 1; }
command -v pkg-config >/dev/null || { echo 'pkg-config não instalado'; exit 1; }
pkg-config --exists wlroots-0.19 || { echo 'wlroots-0.19 não foi encontrado via pkg-config'; exit 1; }
command -v make >/dev/null || { echo 'make não instalado'; exit 1; }
make -C "$DEST" -j"$(nproc)"
[[ -x "$DEST/lilith" ]] || { echo 'Build terminou sem binário Lilith'; exit 1; }
printf '\nBinário LOCAL compilado: %s/lilith\n' "$DEST"
printf 'Não houve instalação. Para testar, execute num TTY separado, NÃO dentro de outra sessão Wayland.\n'

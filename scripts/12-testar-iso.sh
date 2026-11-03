#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
command -v run_archiso >/dev/null || { echo 'run_archiso não encontrado'; exit 1; }
shopt -s nullglob
isos=("$ROOT"/build/out/*.iso)
if (( ${#isos[@]} != 1 )); then echo "Esperada uma ISO em build/out; encontradas: ${#isos[@]}. Use uma imagem por vez."; exit 1; fi
printf 'Iniciando ISO Foundation no QEMU: %s\n' "${isos[0]}"
exec run_archiso -i "${isos[0]}"

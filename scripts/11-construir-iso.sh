#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="$ROOT/archiso/profile"
[[ -f "$PROFILE/profiledef.sh" ]] || { echo 'Primeiro execute scripts/10-preparar-archiso.sh'; exit 1; }
command -v mkarchiso >/dev/null || { echo 'mkarchiso ausente; instale archiso'; exit 1; }
free_kib=$(df -Pk "$ROOT" | awk 'NR==2 {print $4}')
if (( free_kib < 20*1024*1024 )) && [[ "${DEVARITY_ALLOW_LOW_SPACE:-0}" != "1" ]]; then
  echo 'Menos de 20 GiB livres. Build bloqueada preventivamente.'
  echo 'Escolha uma pasta com mais espaço em disco ou defina DEVARITY_ALLOW_LOW_SPACE=1 após avaliar os riscos.'
  exit 1
fi
mkdir -p "$ROOT/build/work" "$ROOT/build/out"
exec mkarchiso -v -w "$ROOT/build/work" -o "$ROOT/build/out" "$PROFILE"

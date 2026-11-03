#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
printf '[DEVARITY] Checando scripts...\n'
for file in "$ROOT"/scripts/*.sh; do bash -n "$file"; done
python3 - <<'PYCODE' "$ROOT"
import json,sys
from pathlib import Path
r=Path(sys.argv[1]); p=r/'assets/tokens/devarity-core.json';d=json.loads(p.read_text())
assert d['palette']['crt_blue'].startswith('#')
print('Tokens JSON: OK')
PYCODE
python3 - <<'PYCODE' "$ROOT"
import ast,sys
from pathlib import Path
r=Path(sys.argv[1]);ast.parse((r/'scripts/aplicar-patch.py').read_text())
print('Sintaxe Python: OK')
PYCODE
python3 -m unittest discover -s "$ROOT/tests" -p "test_*.py"
if command -v shellcheck >/dev/null 2>&1; then shellcheck "$ROOT"/scripts/*.sh; else echo 'shellcheck ausente (checagem opcional não executada)'; fi
if [[ -d "$ROOT/worktrees/devarity-lilith/.git" ]]; then
  printf '\nMudanças em fork local:\n'
  git -C "$ROOT/worktrees/devarity-lilith" status --short
fi
printf '\nValidação estática concluída. Isto NÃO comprova que o Lilith compila ou roda no hardware.\n'

#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE=/usr/share/archiso/configs/releng
DEST="$ROOT/archiso/profile"
[[ -f "$SOURCE/profiledef.sh" ]] || { echo 'Instale archiso para obter o perfil releng'; exit 1; }
[[ ! -e "$DEST" ]] || { echo 'O perfil já existe: não vou apagar suas alterações.'; exit 1; }
mkdir -p "$ROOT/archiso"
cp -a "$SOURCE" "$DEST"
python3 - "$DEST/profiledef.sh" <<'PYCODE'
import re,sys
from pathlib import Path
p=Path(sys.argv[1]);s=p.read_text()
for key,value in {
 'iso_name':'devarity',
 'iso_label':'DEVARITY_001',
 'iso_publisher':'Devarity OS Community',
 'iso_application':'Devarity OS 0.1 Foundation Live',
}.items():
 pattern=rf'^(\s*{key}=)[^\n]*$'
 s,n=re.subn(pattern,lambda m,v=value:m.group(1)+'"'+v+'"',s,flags=re.M)
 if n!=1: raise SystemExit(f'Campo de perfil não localizado: {key} (verifique versão Archiso)')
p.write_text(s)
PYCODE
mkdir -p "$DEST/airootfs/etc"
cat > "$DEST/airootfs/etc/motd" <<'EOF'
DEVARITY OS 0.1 / FOUNDATION
===================================
Ambiente Live experimental baseado no Arch Linux.
Esta imagem NÃO contém ainda o Lilith, o instalador gráfico ou a shell Devarity.
Visite o README do repositório para os próximos marcos.
EOF
printf 'Perfil Archiso Foundation preparado: %s\n' "$DEST"

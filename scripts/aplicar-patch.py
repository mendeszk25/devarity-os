#!/usr/bin/env python3
"""Modifica somente arquivos de configuração auditados de um clone local de Lilith.
Executar sobre clone novo: falha fechada quando um padrão esperado mudou.
"""
import json
import re
import sys
from pathlib import Path

if len(sys.argv) != 3:
    raise SystemExit('Uso: aplicar-patch.py CAMINHO_FORK tokens.json')
root=Path(sys.argv[1]).resolve()
tokens=Path(sys.argv[2]).resolve()
if not (root/'.git').is_dir() or not (root/'config').is_dir():
    raise SystemExit('Recusando: destino não parece ser um clone Lilith com .git e config/')
info=json.loads(tokens.read_text(encoding='utf-8'))
def color(name):
    raw=info['palette'][name]
    if not re.fullmatch(r'#[0-9A-Fa-f]{6}',raw):
        raise SystemExit('Cor inválida: '+name)
    return '0x'+raw[1:].lower()+'ff'

pending = {}

def patch(file, replacements):
    path=root/file
    source=path.read_text(encoding='utf-8')
    target=source
    for regex,replacement in replacements:
        target,count=re.subn(regex,replacement,target,count=1,flags=re.MULTILINE)
        if count!=1:
            raise SystemExit(f'ABORTADO: padrão incompatível em {file}: {regex}')
    # Acumula alterações: só escreve depois que TODOS os arquivos forem validados.
    pending[path] = target
    print('Validado:',file)

patch('config/config_appearance.h',[
    (r'(static const float rootcolor\[\]\s*=\s*)COLOR\(0x[0-9a-fA-F]+\)',lambda m:m[1]+'COLOR('+color('void')+')'),
    (r'(static const float focused_outer_border_color\[\]\s*=\s*)COLOR\(0x[0-9a-fA-F]+\)',lambda m:m[1]+'COLOR('+color('crt_blue')+')'),
    (r'(static const float unfocused_outer_border_color\[\]\s*=\s*)COLOR\(0x[0-9a-fA-F]+\)',lambda m:m[1]+'COLOR('+color('graphite')+')'),
])
patch('config/config_animation.h',[
    (rf'(#define\s+{key}\s+)[0-9.]+',lambda m,v=value:m[1]+str(v))
    for key,value in [('tagduration',.24),('openduration',.22),('closeduration',.20),('canvasduration',.36),('zoomduration',.34)]
])
patch('config/config_keys.h',[
    (r'(static const char \*termcmd\[\]\s*=\s*\{\s*)"foot"',r'\g<1>"kitty"'),
    (r'(static const char \*wlaunch\[\]\s*=\s*\{\s*)"wmenu-run"',r'\g<1>"fuzzel"'),
    # Browser shortcut appears first and shadows Super+Shift+F for togglefullscreen.
    (r'^\s*\{[^\n]*XKB_KEY_f[^\n]*spawn[^\n]*browser[^\n]*\},?[^\n]*\n',''),
])
# Default is local ABNT2; international locale selection will come with onboarding.
patch('config/config_input.h',[
    (r'(\.layout\s*=\s*)"us"',r'\g<1>"br"'),
    (r'(\s*\.layout\s*=\s*"br",\s*\n)',lambda m:m[1]+'    .variant = "abnt2",\n'),
])
# Keep Lilith's native bar for phase 00. External QML shell replaces it only after integration tests.
for path, content in pending.items():
    path.write_text(content, encoding='utf-8')
print('Patch Devarity aplicado em', len(pending), 'arquivos. Releia git diff antes de compilar.')

#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
printf '\n[DEVARITY] Diagnóstico do host\n'
printf 'Projeto: %s\n' "$ROOT"
if [[ -r /etc/arch-release ]]; then echo 'Distribuição host: Arch Linux (arquivo /etc/arch-release detectado)'; else echo 'AVISO: host não identificado como Arch Linux'; fi
printf 'Arquitetura: %s\n' "$(uname -m)"
printf '\nDisco do projeto:\n'
df -h "$ROOT"
printf '\nMemória:\n'
free -h || true
printf '\nFerramentas:\n'
for c in git python3 make cc pkg-config mkarchiso run_archiso qemu-system-x86_64 shellcheck; do
  if command -v "$c" >/dev/null 2>&1; then printf '[OK] %s => %s\n' "$c" "$(command -v "$c")"; else printf '[--] %s não encontrado\n' "$c"; fi
done
printf '\nBibliotecas pkg-config:\n'
for lib in wlroots-0.19 wayland-server xkbcommon libinput libdrm fcft pixman-1; do
  if command -v pkg-config >/dev/null 2>&1 && pkg-config --exists "$lib"; then echo "[OK] $lib"; else echo "[--] $lib"; fi
done
free_kib=$(df -Pk "$ROOT" | awk 'NR==2 {print $4}')
if (( free_kib < 20*1024*1024 )); then printf '\nATENÇÃO: menos de 20 GiB livres no sistema de arquivos do projeto. Não construa a ISO sem avaliar espaço.\n'; fi
printf '\nDiagnóstico concluído sem modificar o sistema.\n'

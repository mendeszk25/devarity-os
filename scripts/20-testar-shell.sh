#!/usr/bin/env bash
# Run *only* inside an existing experimental Wayland session.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ -z "${WAYLAND_DISPLAY:-}" ]]; then
    echo '[DEVARITY] Inicie primeiro o Devarity Lilith em outro TTY.'
    echo '[DEVARITY] Este script não abre nem substitui seu compositor.'
    exit 1
fi
if ! command -v quickshell >/dev/null 2>&1; then
    echo '[DEVARITY] Quickshell ausente. No Arch: sudo pacman -S --needed quickshell'
    exit 1
fi
for app in kitty dolphin fuzzel; do
    if ! command -v "$app" >/dev/null 2>&1; then
        printf '[AVISO] %s não encontrado. Seu botão pode não abrir nada.\n' "$app"
    fi
done
printf '[DEVARITY] Iniciando shell experimental. Ctrl+C encerra apenas Quickshell.\n'
exec quickshell --path "$ROOT/desktop/quickshell/shell.qml"

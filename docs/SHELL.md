# Devarity Shell v0.1 — primeira integração (experimental)

**Status:** protótipo em Quickshell/QML criado, revisado estaticamente; **ainda não foi executado no hardware do usuário**. Não altera o compositor, login ou a sessão principal.

## Escopo entregue

- Topbar monocromática/CRT com marca, identificação de sessão e relógio atualizado por `SystemClock`.
- Dock inferior centrado com botões Terminal (Kitty), Arquivos (Dolphin), Apps e Buscar (Fuzzel).
- Menu próprio de aplicativos: lista real de entradas `.desktop`, filtro de texto, ícones e execução via `DesktopEntry.execute()`.
- Um painel por monitor usando `Variants` sobre `Quickshell.screens`.
- Tema com tokens de cores/propriedades em `Theme.js` e foco visual acessível.
- Testes estáticos mínimos; QML/runtime **não validado** por falta de ambiente Quickshell no executor de desenvolvimento.

## Pré-requisitos no Arch

```bash
sudo pacman -S --needed quickshell kitty dolphin fuzzel
```

O Quickshell está no repositório **extra** do Arch (0.3.2). Dependência Wayland: o compositor precisa expor `wlr-layer-shell`. O código auditado do Lilith registra o protocolo, mas a integração visual deve ser testada. Fontes monoespaçadas usuais bastam.

## Teste sem mexer na sessão atual

1. Inicie seu **Devarity Lilith** existente a partir de um TTY separado, usando seu comando já validado.
2. Abra o Kitty (`Super+Q`).
3. Desative **temporariamente** a barra interna do Lilith com `Super+B` (atalho do upstream auditado), para não sobrepor a Devarity Topbar.
4. No terminal **dentro** do Devarity Lilith, clone o repositório em uma pasta nova ou atualize seu clone existente e entre na raiz.
5. Rode: `./scripts/20-testar-shell.sh` (sem sudo).

Para encerrar a shell experimental, use `Ctrl+C` **no terminal onde o script roda**. Para sair do compositor use `Super+Shift+Q` (não é um comando da shell). Se o menu não receber foco, encerre Quickshell com Ctrl+C; Fuzzel continua sendo o launcher de recuperação via Super+R.

O script **não** copia arquivos para `~/.config`, não liga autostart, não instala serviços ou sobrescreve o Lilith original.

## Verificações manuais

- [ ] Barra mostra o relógio em ambos os monitores (se conectados).
- [ ] Clique DEVARITY_ abre menu; clique CLOSE e Esc o fecham.
- [ ] Filtro exibe apenas aplicativos instalados e Enter abre o primeiro resultado.
- [ ] Dock abre Kitty, Dolphin, Fuzzel; Apps abre menu.
- [ ] Esconder barra original evita conflitos de layer-shell.
- [ ] Captura de tela, foco, fullscreen e jogos continuam funcionando.
- [ ] Sem piscadas/glitches intencionais que atrapalhem o uso.
- [ ] Medir RAM/CPU comparando com e sem Quickshell.

## Limitações conhecidas

- Não integra IPC do Lilith (tags, seleção de janelas, atalhos globais ou controle de zoom); isso requer patch/testes.
- Botões de apps dependem dos programas instalados.
- O Quickshell adiciona Qt/QML à memória; a meta de até 500 MiB precisa ser medida.
- Se o compositor não entregar foco aos painéis layer-shell, o campo de filtro pode não aceitar digitação: preferir Fuzzel até corrigir a integração.
- Visual ainda é estrutural: efeitos CRT animados, monitoramento, wallpapers e lock screen ficam para uma fase posterior.
- O `Theme.js` espelha manualmente o JSON; sincronização automática virá depois.

## Referências da API

- https://quickshell.org/docs/v0.3.2/types/Quickshell/PanelWindow/
- https://quickshell.org/docs/v0.3.2/types/Quickshell/Variants/
- https://quickshell.org/docs/v0.3.2/types/Quickshell/DesktopEntries/
- https://quickshell.org/docs/v0.3.2/types/Quickshell/DesktopEntry/
- https://quickshell.org/docs/v0.3.2/types/Quickshell/SystemClock/

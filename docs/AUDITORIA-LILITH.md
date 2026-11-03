# Auditoria do Lilith (fase 00)

Fonte: https://github.com/ohto121/lilith

Revisão auditada: `4acbf2871316dce751a5448ea799953bf0bd3ad8` (upstream de 2026-10-17). Auditoria estática do código, complementada por relato de compilação e teste em TTY do usuário em 2026-11-03.

## Arquitetura observada

- Compositor Wayland em C + wlroots 0.19. `config.mk` define `WLR_INCS` e `WLR_LIBS` via `pkg-config wlroots-0.19`.
- Código principal `src/lilith.c`: aproximadamente 6.064 linhas na revisão analisada.
- Módulos: `src/bar.h` (barra nativa via fcft e pixman), `src/wallpaper.h`, `src/client.h` e `src/util.c`.
- Configuração em `config_appearance.h`, `config_animation.h`, `config_bar.h`, `config_input.h` e `config_keys.h` via `config.h`; mudanças normalmente exigem recompilação.
- `Makefile` inclui `make install`, que instala em `/usr/local` por padrão. **Não executar durante a fase de experimentação.**
- Código registra XDG Shell, layer-shell v1, session-lock v1, screencopy v1, export-dmabuf e XWayland opcional. Isso **não garante** integração com portal, compartilhamento de tela ou lock seguro sem testes.

## Funcionalidades existentes

Canvas infinito, movimento e zoom, janelas flutuantes com encaixe magnético, bordas internas/externas, animações de abrir/fechar/tags/canvas/inércia e barra nativa. Sem tiling automático tradicional no projeto-base.

## Defeito de atalhos

Em `config/config_keys.h`, **Super+Shift+F** aparece duas vezes: primeiro para abrir o navegador (`spawn browser`) e depois para `togglefullscreen`. A primeira entrada vence, impedindo a segunda. Nosso patch remove o atalho conflitante do navegador, preservando tela cheia.

## Dependência legada

O fork auditado depende de `wlroots-0.19`. A disponibilidade dessa versão mudou nos repositórios Arch; confira com `pkg-config --exists wlroots-0.19`. Não substitua a biblioteca do sistema por conta dessa dependência. Em futuras builds, planejar ferramenta de build isolada ou migração para API mais recente.

## Riscos a validar

| Área | Risco e próximo teste |
|---|---|
| Shell externa | Compatibilidade do layer-shell, input, foco e sobreposição com barra nativa |
| Configuração dinâmica | Os headers C não expõem API de configuração em tempo real; futura UI precisa de gerador/IPC |
| Captura/compartilhamento | Verificar PipeWire, xdg-desktop-portal e screencopy em aplicativos reais |
| Bloqueio | Avaliar session-lock e impedir bypass de autenticação |
| Jogos | Testar XWayland, cursor, fullscreen e Proton |
| Monitores | Validar monitor externo, escalas, suspensão e retomada |
| Recursos | RAM ≤ 500 MiB é meta experimental, não resultado aferido |
| Licenças | Conservar GPL-3.0-or-later e avisos dos projetos herdados |

## Evidência do teste local

O usuário confirmou: patch em quatro headers, validação de dois testes, build/link com warnings (não erros), `ldd` sem bibliotecas ausentes e abertura da sessão gráfica em TTY. Esta evidência **não valida** estabilidade prolongada nem todos os protocolos.

## Fontes examinadas

- https://github.com/ohto121/lilith/blob/main/Makefile
- https://github.com/ohto121/lilith/blob/main/config/config_keys.h
- https://github.com/ohto121/lilith/blob/main/config/config_animation.h
- https://github.com/ohto121/lilith/blob/main/config/config_appearance.h
- https://github.com/ohto121/lilith/blob/main/src/lilith.c

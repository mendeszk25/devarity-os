# DEVARITY OS — Foundation v0.1

**Status:** desenvolvimento experimental. O fork do Lilith compilou e iniciou em um TTY no Arch Linux x86_64 do mantenedor em 03/11/2026. **Ainda não é uma distribuição instalável.**

Distribuição Linux baseada no Arch, voltada a desenvolvedores e usuários avançados. Identidade visual: **Cyber Grunge, Retro Hacker, Digital Brutalism e Y2K Underground**. Foco em desempenho, confiabilidade e personalização.

## Arquitetura

- **Base:** Arch Linux rolling release, Linux kernel, pacman, Flatpak opcional.
- **Compositor em avaliação:** Lilith (C + wlroots 0.19), com Niri como alternativa.
- **Interface atual:** barra nativa do Lilith, terminal Kitty, launcher Fuzzel.
- **Interface futura:** Devarity Shell própria, inicialmente prototipada sobre protocolos Wayland/Quickshell.
- **Visual:** preto e branco, azul CRT, tipografia mono, janelas industriais, glitch opcional e modo de movimento reduzido.
- **ISO:** base experimental preparada a partir do perfil `releng` do Archiso, ainda não construída ou testada nesta entrega.

## O que o repositório já contém

- Scripts de diagnóstico do host, clone fixado do Lilith, fork isolado, aplicação de patch, compilação e verificação.
- Tokens visuais em JSON e patch reproduzível para quatro arquivos de configuração do Lilith.
- Testes Python (`2` casos de unidade) e documentação da auditoria.
- Scripts de preparação de ISO Foundation CLI e teste em QEMU, **não** um instalador gráfico.
- Checkpoints do primeiro teste real no Arch.

**Não incluídos:** binários gerados, código upstream de terceiros vendorizado, wallpapers de referência, sistema de login personalizado, lock screen, shell QML ou uma ISO pronta. Os diretórios `upstream/`, `worktrees/` e `build/` são ignorados pelo Git.

## Requisitos para testar o Lilith

Host Arch x86_64 com `git`, `python`, `make`, toolchain C, `pkgconf`, Wayland/wlroots 0.19, `libinput`, `libxkbcommon`, `libdrm`, `fcft`, `pixman`, `wayland-protocols`, `xorg-xwayland`, `xcb-util-wm`, `kitty` e `fuzzel`. Confira a disponibilidade real de `wlroots-0.19` com `pkg-config --modversion wlroots-0.19` antes da compilação. **Não substitua bibliotecas do sistema** para satisfazer esta dependência legada.

```bash
./scripts/00-diagnostico.sh
./scripts/01-sincronizar-lilith.sh
./scripts/02-criar-fork-local.sh
./scripts/04-validar.sh
git -C worktrees/devarity-lilith diff --check
git -C worktrees/devarity-lilith diff
./scripts/03-compilar-fork.sh
```

Para teste gráfico, use um TTY separado e não substitua a sessão existente:

```bash
env -u WAYLAND_DISPLAY -u DISPLAY dbus-run-session -- ./worktrees/devarity-lilith/lilith
```

Nenhum desses scripts instala o compositor globalmente. **Não execute `make install` nem remova sua sessão atual.**

## ISO Foundation (somente base CLI)

Após instalar `archiso` e reservar espaço suficiente, preferencialmente em um SSD com **20 GiB ou mais livres**:

```bash
./scripts/10-preparar-archiso.sh
./scripts/11-construir-iso.sh
./scripts/12-testar-iso.sh
```

A ISO Foundation inicial não inclui ainda o Lilith, o desktop Devarity ou instalador gráfico. A execução desses comandos é manual; a construção pode consumir bastante armazenamento.

## Devarity Shell v0.6 — Underground Interface

A marca oficial foi verificada visualmente na topbar e dock em v0.5.1. A v0.6 adiciona molduras industriais/CRT estáticas e mudanças tipográficas, sem alterar as funções principais do menu e dos aplicativos. Ainda precisa de QA no Lilith real. Ver [documentação da shell](docs/SHELL.md), [brand pack](assets/branding/README.md) e o checkpoint de [Underground v0.6](docs/checkpoints/2026-11-03-shell-underground-v0.6.md).

\n## Documentação

- [Arquitetura](docs/ARQUITETURA.md)
- [Auditoria do Lilith](docs/AUDITORIA-LILITH.md)
- [Roadmap](docs/ROADMAP.md)
- [Licenciamento](docs/LICENCIAMENTO.md)
- [Estado e testes locais](docs/TESTES-LOCAIS.md)
- [Sincronização com GitHub](docs/GITHUB.md)
- [Checkpoint do teste gráfico](docs/checkpoints/2026-11-03-lilith-tested.md)

## Código original e licenças

Lilith upstream: https://github.com/ohto121/lilith (referência fixada no commit `4acbf2871316dce751a5448ea799953bf0bd3ad8`). Archiso: https://github.com/archlinux/archiso. O código original de Lilith e seus avisos de licença devem ser preservados no fork. Não presuma que as imagens de referência recebidas podem ser republicadas. A licença geral do Devarity OS ainda está em análise.

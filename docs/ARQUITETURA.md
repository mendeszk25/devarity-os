# DEVARITY OS — arquitetura proposta (r0)

## Público e princípios

Público: usuários Linux avançados/desenvolvedores. Valores: personalização, desempenho e confiabilidade. Base: Arch Linux rolling release x86_64, kernel Linux padrão, Pacman e Flatpak, AUR opt-in.

## Camadas

1. **Arch Linux:** kernel, systemd, drivers, PipeWire/WirePlumber, NetworkManager.
2. **Compositor primário:** fork auditável de Lilith C + wlroots 0.19. **Niri** permanece como alternativa de engenharia, não deve ser removido do host.
3. **Shell:** inicial — barra Lilith; futura — Devarity Shell via Quickshell/QML, após teste de layer-shell.
4. **Apps:** Kitty/Fish; Dolphin; menu tradicional primeiro com launcher leve; navegador escolhido no onboarding; Steam/Proton opcionais.
5. **Experiência:** identidade CRT azul / preto / branco, wallpapers opcionais, tema dark, tela de bloqueio e Plymouth após testes.
6. **Construção:** Archiso (releng), scripts versionados, pacotes próprios após prova de conceito e repositório assinado.

## Perfis visuais

- **Core:** animações curtas, wallpaper estático, ruído/glitch desativados.
- **Underground:** elementos experimentais seletivos, wallpaper animado opcional, sem comprometer tela de login, avisos de segurança ou acessibilidade.

## Instalação, boot e segurança (futuro, ainda não implementado)

- systemd-boot para UEFI e Plymouth como animação de boot. Menu gráfico próprio só após protótipo seguro; não reescrever bootloader por estética.
- Instalador gráfico próprio visualmente, mas usar backend Calamares auditado inicialmente.
- Btrfs + Snapper (snapshots), Borg/Vorta para backups externos, LUKS2 opcional recomendado, firewall ativado e telemetria desativada.
- Atualizações completas com pacman, nunca partial upgrades; AUR isolado, marcado como não oficial.
- Fonte de terceiros e licenças devidamente preservadas.

## Contratos técnicos planejados

- `devarity-theme` (dados JSON de tokens) -> gerador de configuração C do Lilith.
- `devarity-shell` -> Quickshell (status da sessão e comandos via protocolos/IPC documentados após protótipo).
- `devarity-welcome` -> configurações do usuário, instalação opt-in de apps e tutoriais.
- `devarity-iso` -> perfil Archiso controlado por Git, incluindo pacotes devidamente empacotados.

**Nota:** o zip atual só implementa fundação de arquivos/scripts e patch visual de configuração. Os contratos acima ainda são intenções técnicas.

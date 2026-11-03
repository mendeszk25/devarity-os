# Devarity Shell v0.6 — Underground Interface (primeira iteração)

**Estado:** v0.5.1 validada visualmente pelo usuário, com logo visível na Topbar e Dock. A marca dentro do menu ainda não foi comprovada na captura. A v0.6 é uma modificação gráfica incremental e necessita de teste manual em Wayland.

## Alterações v0.6

- `TechFrame.qml`: moldura gráfica reutilizável com cantos industriais, barra de pequenos segmentos e detalhe inclinado derivado do corte da logo.
- `Topbar.qml`: edição 0.6, identificação Underground e composição tipográfica ajustada.
- `Dock.qml`: ornamentos compartilhados e marcador `DVR/04`.
- `AppMenu.qml`: microtipografia `SYS://UNDERGROUND/APPS`, marcação `DVR.06` e moldura técnica.

## Restrições

- Efeitos **estáticos**, sem animação contínua, shader ou ruído calculado por frame.
- Não mudar comportamento de busca, Enter, Fuzzel, Dolphin e Kitty.
- Não editar arquivos do Lilith em C, greeter, bootloader ou autostart.
- A aparência ainda é uma base; evitar afirmar que o design Cyber Grunge completo está concluído.

## Testar na sessão experimental

Encerre o Quickshell da v0.5.1 com `Ctrl+C` e, dentro do Lilith de teste:

```bash
cd /mnt/ssd-extra/Devarity-OS/devarity-os-github
git pull --ff-only
./scripts/20-testar-shell.sh
```

Valide a logo na barra, dock **e menu aberto**. Digite `kitty`, pressione Enter, volte ao menu, teste Escape, botões TERM/FILES/SEARCH e confira o comportamento nas duas telas. Se houver warnings, cole a saída do terminal.

## Critérios para a v0.7

Antes de incluir animações CRT, medir consumo de RAM e FPS, comparar contra v0.5.1 e adicionar opção de movimento reduzido. O dock ainda pode sobrepor janelas devido a `ExclusionMode.Ignore` e precisa de uma decisão técnica para o canvas infinito.

# Devarity Shell v0.4 — legibilidade e feedback de busca

**Status:** barra e dock originais da v0.1 apareceram na captura do usuário em 2026-11-03. A v0.2 foi confirmada visualmente por capturas do usuário: barra, dock, menu com 76 entradas e Kitty aberto. O usuário confirmou que a busca por kitty filtra e que Enter abre o aplicativo selecionado. A v0.4 ainda precisa ser testada graficamente.

## Entregáveis

- `Topbar.qml`: layout técnico em blocos, rótulo de versão, relógio com hierarquia, detalhes CRT estáticos.
- `Dock.qml`: barra industrial com quatro ações **reais**: Kitty, Dolphin, menu e Fuzzel; hover contido.
- `AppMenu.qml`: preserva pesquisa e Enter já testados, aumenta a legibilidade, mostra mensagem para buscas sem resultado e evita cortar a última linha da lista.
- `shell.qml`: coordena janelas Quickshell por monitor, sem autostart.
- `Theme.js`: paleta provisória; cores podem mudar após aprofundamento das referências.
- `tests/test_shell_layout.py`: testes de estrutura, não comprovam renderização Qt/QML.

## Testar sem alterar sua sessão original

1. Dentro do Devarity Lilith experimental, esconda a barra original com **Super+B**, se necessário.
2. No clone do repositório GitHub, execute:

```bash
git pull --ff-only
./scripts/20-testar-shell.sh
```

3. Encerrar somente shell: **Ctrl+C** no terminal do script.
4. Se tiver erros QML, envie saída do terminal.
5. Testar o menu: clicar em **DEVARITY_OS** ou **APPS**, procurar um aplicativo, pressionar Enter, fechar com Esc.

Não execute `sudo make install` nem edite as sessões originais.

## QA que ainda falta

- Menu v0.3 exibido em screenshot com 76 entradas; filtro por kitty e Enter confirmados. Setas e Esc ainda precisam de teste específico.
- Falta validar a atualização visual 0.4 em monitores 1920×1080 e 1366×768.
- Falta medir RAM/CPU, som, screencopy e interação com layer-shell.
- Meta de 500 MiB em repouso não demonstrada.
- Recursos de glitch animado, travamento e boot serão feitos separadamente, com efeitos ajustáveis e sem enganar o usuário sobre erros de sistema.

Checklist completo: [checkpoint de QA](checkpoints/2026-11-03-shell-visual-qa.md).

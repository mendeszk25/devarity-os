# Devarity Shell v0.2 — primeiro refinamento visual

**Status:** barra e dock originais da v0.1 apareceram na captura do usuário em 2026-11-03. Esta v0.2 foi refinada a partir da captura, mas **ainda precisa de teste de execução no hardware**. O menu de aplicativos não foi confirmado em screenshot.

## Entregáveis

- `Topbar.qml`: layout técnico em blocos, rótulo de versão, relógio com hierarquia, detalhes CRT estáticos.
- `Dock.qml`: barra industrial com quatro ações **reais**: Kitty, Dolphin, menu e Fuzzel; hover contido.
- `AppMenu.qml`: mantém implementação v0.1 de catálogo real de arquivos desktop e busca.
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

- Menu não está visível no screenshot recebido.
- Falta validar a atualização visual 0.2 em monitores 1920×1080 e 1366×768.
- Falta medir RAM/CPU, som, screencopy e interação com layer-shell.
- Meta de 500 MiB em repouso não demonstrada.
- Recursos de glitch animado, travamento e boot serão feitos separadamente, com efeitos ajustáveis e sem enganar o usuário sobre erros de sistema.

Checklist completo: [checkpoint de QA](checkpoints/2026-11-03-shell-visual-qa.md).

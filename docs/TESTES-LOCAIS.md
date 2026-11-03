# Testes e estado da Foundation v0.1

## Automatizados

- `bash -n` dos scripts: aprovado no ambiente de preparação.
- Parsing de tokens JSON: aprovado.
- Parsing do script Python: aprovado.
- `python3 -m unittest discover -s tests`: 2 casos aprovados.
- `git diff --check` do fork: sem erros reportados pelo usuário.
- `shellcheck`: opcional, não disponível no ambiente original de preparação.

## Verificados no Arch do usuário (relato com saída de terminal)

- Host Arch Linux x86_64; código Lilith upstream fixado na revisão auditada.
- Dependência `wlroots-0.19` e bibliotecas adicionais detectadas.
- Patch aplicado aos quatro headers pretendidos.
- Compilação e linkedição concluídas com warnings do upstream.
- Arquivo ELF x86-64 gerado; `ldd` não mostrou bibliotecas ausentes.
- Compositor iniciado a partir de TTY; usuário confirmou abertura e funcionamento inicial.

## Ainda não validados

- ISO criada com `mkarchiso`, boot por QEMU e instalação em disco virtual.
- Uso de RAM ≤ 500 MiB, desempenho de GPU, duração de bateria.
- Portals PipeWire, screen sharing, multimonitor, suspensão, lock screen, estabilidade e jogos.
- Shell própria, boot branding e instalador gráfico.

Esta etapa comprova um primeiro smoke test positivo do compositor, **não uma distro pronta para uso diário**.

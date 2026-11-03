# Checkpoint — Lilith Foundation v0.1

Data: 2026-11-03. Teste realizado pelo usuário em um host Arch Linux x86_64.

## Evidências reportadas
- Scripts `01-sincronizar-lilith.sh` e `02-criar-fork-local.sh` completaram sem erros.
- Upstream fixado em `4acbf2871316dce751a5448ea799953bf0bd3ad8`.
- Patch local aplicado a `config_appearance.h`, `config_animation.h`, `config_input.h` e `config_keys.h`.
- `04-validar.sh`: dois testes de unidade aprovados, sem erro de sintaxe.
- `git diff --check`: sem erros de whitespace.
- Compilação: linkedição concluída com warnings de origem; o binário foi criado.
- `ldd`: nenhuma biblioteca marcada como `not found`.
- Usuário confirmou que o compositor iniciou num TTY separado e abriu os programas testados.

## Limites
- O compositor ainda não tem marca e UI final do Devarity OS.
- Benchmark de memória, estabilidade e desempenho ainda não foi executado.
- Não é uma ISO instalável.
- O código-fonte derivado do Lilith é obtido pelo script de sincronização, não vendorizado neste repositório.

## Próximos passos
1. Prototipar integração da barra/launcher externos com a barra nativa do Lilith.
2. Definir interface mínima de runtime/IPC para configurações visuais (requer implementação).
3. Medir RAM/CPU/GPU e compatibilidade de captura de tela/portals.
4. Só depois integrar à ISO Archiso e testar em QEMU.

# Devarity Shell v0.5.1 — correção do carregamento da logo

Após o teste da v0.5 em 03/11/2026, a captura mostrou **espaços vazios onde a marca deveria aparecer** na Topbar e no Dock. A aplicação em si renderiza, mas os PNGs não estavam visíveis. A causa precisa ainda ser confirmada com os logs do Quickshell.

## Mudanças desta revisão

- Substituição do PNG claro por uma versão **RGBA 8-bit** (tipo PNG 6) do mesmo desenho, preservando a transparência.
- A URL agora é construída com `Quickshell.shellPath()`, independentemente do diretório de onde o comando foi iniciado.
- Carregamento síncrono de uma imagem pequena para simplificar a fase de diagnóstico.
- `BrandMark.qml` exibe `D/` como fallback quando a imagem não está pronta, evitando áreas completamente vazias.
- Se o Qt não conseguir ler a imagem, o Quickshell exibirá `[DEVARITY][BRAND] Failed loading logo:` no terminal.
- Não houve mudança no compositor Lilith, na barra, nos atalhos, no instalador ou no login.

## Teste local

Encerre a shell anterior com `Ctrl+C` e, na sessão experimental Lilith, execute:

```bash
cd /mnt/ssd-extra/Devarity-OS/devarity-os-github
git pull --ff-only
./scripts/20-testar-shell.sh 2>&1 | tee /tmp/devarity-shell-brand.log
```

Abra o menu para confirmar os três pontos de uso: Topbar, Dock e Application Index. Confira se o símbolo branco aparece; caso apareça apenas `D/`, envie linhas relacionadas ao erro:

```bash
grep -iE 'DEVARITY.*BRAND|Failed loading|Image|png' /tmp/devarity-shell-brand.log | tail -n 30
```

O `tee` grava somente logs da shell experimental, não instala nada nem modifica seu sistema.

## Limites

A nova versão **ainda não foi testada em um compositor real** neste executor. A confirmação visual deve vir do teste do usuário. Os testes GitHub Actions validam arquivos, PNG e sintaxe estática, não renderização QML.

# Devarity Shell v0.5 — Brand Integration

O usuário confirmou o funcionamento da v0.4, incluindo busca e lançamento do Kitty. A v0.5 integra pela primeira vez a logo oficial no desktop, porém **ainda não foi testada graficamente no host**.

## Novidades

- `BrandMark.qml`: componente de imagem reutilizável, carregando ativos PNG transparentes de 64×64.
- `Topbar.qml`: logo ao lado do wordmark e atualização do marcador para v0.5.
- `Dock.qml`: miniatura da marca ao lado de Quick Access; os quatro botões não mudaram.
- `AppMenu.qml`: substitui `D/` pelo emblema oficial, sem mudar a busca nem Enter.
- `tests/test_brand_assets.py`: valida assinaturas PNG e resolução.
- `assets/branding/README.md`: regras de utilização da marca.

## Teste no Arch

Na sessão experimental do Devarity Lilith, com barra nativa oculta (se necessário), encerre Quickshell com Ctrl+C e execute:

```bash
cd /mnt/ssd-extra/Devarity-OS/devarity-os-github
git pull --ff-only
./scripts/20-testar-shell.sh
```

Se a marca não aparecer, envie a saída do terminal. Não execute `sudo make install`; nenhuma mudança de login ou autostart é necessária.

## Verificação

1. Logo aparece na topbar, no menu e no dock.
2. Menu filtra `kitty` e Enter continua iniciando o aplicativo.
3. Todos os controles e a disposição funcionam em 1920×1080 e 1366×768.
4. Os arquivos PNG devem ser carregados sem warnings de path, URL ou decodificação.

A renderização QML ainda depende de testes no computador do usuário; o CI somente cobre verificações estáticas.

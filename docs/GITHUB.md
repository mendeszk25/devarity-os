# Repositório oficial Devarity OS

Repositório público: https://github.com/mendeszk25/devarity-os

A fundação foi publicada diretamente no GitHub em commits por área: bootstrap Lilith, patch com testes, preparação Archiso e documentação. O repositório original do Lilith **não** foi incluído como subdiretório vendorizado; o script de sincronização baixa o upstream na revisão fixada, respeitando a licença e seus créditos.

## Usar o projeto no Arch

Para obter o código remoto sem sobrescrever seu diretório experimental atual, clone em um diretório **novo**:

```bash
cd /mnt/ssd-extra/Devarity-OS
git clone https://github.com/mendeszk25/devarity-os.git devarity-os-github
cd devarity-os-github
git log --oneline -5
```

Não copie uma pasta `.git` por cima de outra árvore de trabalho sem antes revisar diferenças. A pasta antiga `devarity-os-foundation` pode continuar guardando o fork compilado em `worktrees/`. Para migrar alterações locais, compare-as antes de copiar e criar novos commits.

## O que não publicar

Não versionar tokens, credenciais, logs pessoais, arquivos compilados, ISOs, máquinas virtuais e materiais visuais de terceiros sem autorização. Os caminhos `upstream/`, `worktrees/` e `build/` foram ignorados deliberadamente. O patch do Lilith é reproduzível via `scripts/aplicar-patch.py`.

A licença global do Devarity ainda será definida por componente; respeitar as licenças da base Arch, do Lilith e dos projetos de terceiros.

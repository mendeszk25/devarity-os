# Scripts de desenvolvimento

Todos são explícitos e separados por estágio, não alteram o host por padrão.

- 00: diagnóstico (somente leitura).
- 01: clone remoto do Lilith fixado em revisão auditada; apenas `upstream/`.
- 02: cria clone local e patch do Devarity; apenas `worktrees/`.
- 03: compila binário no clone; NÃO instala.
- 04: valida sintaxe/tokens, lê estado Git.
- 10: copia e personaliza perfil Archiso (sistema Live textual).
- 11: build manual, com guarda de espaço.
- 12: abre a ISO no QEMU.

Nunca rodar scripts de projetos desconhecidos como root sem revisar.

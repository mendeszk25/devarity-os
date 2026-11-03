# Roadmap por critérios de aceitação

| Fase | Entregável | Critério verificável | Estado |
|---|---|---|---|
| 00 | Auditoria e scaffold | Documentos e scripts revisados + checks estáticos | Concluído na v0.1 |
| 01 | Lilith fork dev | Compila no Arch, teste TTY, sem sobrescrever binário original | Teste local aprovado; regressões pendentes |
| 02 | Desktop mínimo | Login e compositor, launcher, terminal, Dolphin, rede, som | Pendente |
| 03 | Shell | Barra, dock, menu e indicadores via camada testada com Lilith | Pendente |
| 04 | Visual | Dois perfis de efeitos, tema CRT, tokens e acessibilidade | Pendente |
| 05 | ISO Live | ISO QEMU inicializável, depois sessão gráfica Devarity | Pendente |
| 06 | Installer | Instalação offline testada e UEFI boot com rollback | Pendente |
| 07 | Alpha pessoal | Logs, scripts de QA, documentação e pacotes assinados | Pendente |

## Metas mensuráveis

- Porta de compatibilidade: compilação contra wlroots 0.19 só se biblioteca estiver presente; caso contrário avaliar port para 0.20 ou build isolado.
- RAM em repouso objetivo 500 MiB, **não validado**; registrar RSS/PSI e condição do teste.
- Tempo de abertura de apps e FPS/frames comparados ao Lilith original no mesmo hardware.
- Monitor externo acima do interno, teclado ABNT2, captura PipeWire e suspend/resume.
- Testar regressões antes de transitar do fork local para uma ISO instalável.

## Não implementar no início

- Gerenciador próprio de armazenamento/particionamento, bootloader escrito do zero, IPC complexo, loja gráfica completa ou repositório próprio público sem assinaturas.

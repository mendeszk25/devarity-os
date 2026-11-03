# Checkpoint visual — Devarity Shell 0.1 → 0.2

Data: 2026-11-03. Base: captura de tela enviada pelo usuário após execução experimental no Lilith.

## Evidência

A captura exibe topbar no topo e dock inferior centralizado no compositor Lilith. O wallpaper não foi customizado pela Shell. O menu de aplicativos não está aberto na captura; não há confirmação visual do filtro, ícones ou execução dos aplicativos. Aparentemente a integração das duas PanelWindows foi bem-sucedida; a imagem não comprova múltiplos monitores, uso de CPU/GPU ou estabilidade.

## Oportunidades identificadas

- Topbar v0.1 era visualmente genérica e com hierarquia fraca.
- Dock v0.1 apresentava botões simples, sem estrutura visual editorial/industrial suficiente.
- Referências do usuário enfatizam interfaces de vigilância CRT, recortes, microtipografia, molduras técnicas e contraste. Não adicionar mensagens falsas nem glitches intrusivos.
- O screenshot mostra a barra/dock, **não** valida comportamento de menu.

## Alterações 0.2

- Topbar modular com identificação de sessão, relógio maior, linhas técnicas e marcador de versão.
- Dock com faixa informativa, quatro ações numeradas, realce CRT e hover suave.
- Sem wallpaper/histórico alterado, autostart, scripts privilegiados, novos pacotes ou alterações no fork C.

## Testes que faltam no computador

- [ ] Confirmar topbar e dock em ambos os monitores.
- [ ] Confirmar clique do logotipo abre menu, busca funciona e Enter inicia app.
- [ ] Confirmar TERM/FILES/SEARCH com foco e sem duplicar a barra nativa do Lilith.
- [ ] Recolher logs QML se houver warnings e testar a 1366×768.
- [ ] Comparar memória/CPU e comportamento de hover antes/depois.

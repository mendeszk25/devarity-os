# Checkpoint: logo invisível no Devarity Shell v0.5
Data: 2026-11-03

## Evidência
A captura enviada mostra a Shell v0.5 com topbar/dock, mas a marca branca falta: o texto deslocou-se, deixando área vazia para o ícone. Não há captura do menu nem log de erro.

## Diagnóstico
- PNGs publicados no GitHub tinham cabeçalho válido e transparência.
- O PNG claro estava no formato PNG grayscale+alpha (color type 4); a compatibilidade específica de renderização com Qt não foi confirmada.
- O componente QML usava `Qt.resolvedUrl("../../assets/branding/...")`; uma URL relativa pode falhar no ambiente de execução.
- Não é possível apontar uma causa única sem logs.

## Mitigação v0.5.1
- PNG claro substituído por RGBA 8-bit testado estaticamente.
- Caminho absoluto via `Quickshell.shellPath()`.
- Fallback textual `D/` se `Image.status !== Image.Ready`.
- Log específico em `Image.Error` para orientar a próxima correção.

Não foram tocados os componentes de teclado/menu já testados, nem código C do Lilith.

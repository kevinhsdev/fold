# Explicação para a apresentação

Cada linha do código já tem um comentário explicando o que faz. Este arquivo explica os **conceitos** por trás do código e responde às perguntas que o professor provavelmente vai fazer.

## Os 8 conceitos que aparecem no código

**1. Widget.** No Flutter, tudo que aparece na tela é um widget: `Text`, `Card`, `Scaffold`, e até a tela inteira. Widgets ficam um dentro do outro, como uma árvore. Ex.: `Scaffold` → `Column` → `Card` → `Text`.

**2. StatelessWidget × StatefulWidget.**
- *Stateless* (sem estado): depois de desenhado, não muda. Ex.: `MeuApp` em `main.dart`.
- *Stateful* (com estado): guarda dados que mudam e se redesenha. Ex.: `TelaInicial`, que guarda a lista `_transacoes`.

**3. `setState`.** É como avisamos o Flutter: "mudei os dados, desenhe a tela de novo". Sem `setState`, a lista mudaria na memória mas a tela continuaria mostrando a versão antiga.

**4. `build()`.** É a função que descreve a tela. O Flutter chama ela de novo a cada `setState`. É por isso que o saldo é recalculado dentro do `build`: sempre bate com a lista.

**5. Classe e modelo (`Transacao`).** A classe é o "molde" de um lançamento. Separar o modelo (`transacao.dart`) das telas deixa o código organizado e permite testar as contas sem abrir nenhuma tela.

**6. `async` / `await` / `Future`.** Ler e gravar no celular demora alguns milissegundos. `async` marca a função como "demorada", e `await` espera o resultado **sem travar o app**.

**7. JSON.** O `shared_preferences` só guarda tipos simples (texto, número). Então transformamos: `Transacao` → mapa (`paraMapa`) → texto JSON (`jsonEncode`) → salva. Na volta, fazemos o caminho inverso (`jsonDecode` → `Transacao.deMapa`).

**8. Navegação (`Navigator`).** As telas funcionam como uma pilha: `push` coloca a tela do formulário em cima, e `pop` tira ela e devolve um valor (a nova transação) para quem abriu.

## Detalhes de design que entraram no código

**Tema centralizado (`tema.dart`).** Todas as cores, a fonte e o formato dos botões/campos ficam num arquivo só. As telas só usam `Cores.tinta`, `Cores.entrada` etc. Se o designer mudar uma cor no Figma, mudamos **uma linha** e o app inteiro acompanha.

| Detalhe | Onde | Por quê |
|---|---|---|
| Fonte própria (Manrope) em vez da padrão | `pubspec.yaml` (fonts) + `fontFamily` em `tema.dart` | A fonte padrão deixa o app com cara de "genérico"; uma fonte escolhida dá identidade |
| Saldo grande sem caixa, "R$" menor e cinza | `_saldo` com `Text.rich` | O número é o protagonista; `Text.rich` permite estilos diferentes no mesmo texto |
| Ícone por categoria | `iconesDasCategorias` (um `Map`) em `tema.dart` | Reconhecer o lançamento de relance, sem ler |
| Gasto em preto, entrada em verde | `_itemDaLista` | Vermelho em todo almoço parece bronca; a cor fica para o que importa |
| Formulário abre de baixo para cima com "✕" | `fullscreenDialog: true` | Padrão do iPhone para "criar algo": deixa claro que é uma tarefa rápida |
| Valor gigante com teclado já aberto | `autofocus: true` no campo de valor | O valor é o que mais importa; menos um toque para o usuário |
| Chips de categoria | `ChoiceChip` dentro de `Wrap` | Todas as opções visíveis, escolha com um toque |
| Vibraçãozinha ao salvar/apagar | `HapticFeedback` | Confirmação física, como nos apps do iPhone (só no celular) |
| Milhar com ponto ("1.450,00") | `formatarDinheiro` em `transacao.dart` | Padrão brasileiro; o laço `for` põe um ponto a cada 3 dígitos |
| Saldo anima do valor antigo ao novo (250 ms) | `TweenAnimationBuilder` em `tela_inicial.dart` | O usuário percebe que o saldo mudou. Curto para não parecer lento |
| Curva `easeOutCubic` | mesmo lugar | Começa rápido e desacelera: a resposta parece imediata |
| Animação desligada se o celular pede | `MediaQuery.disableAnimationsOf` | Acessibilidade: algumas pessoas passam mal com movimento |
| Algarismos de largura fixa | `FontFeature.tabularFigures()` | O número não "treme" ao animar e os valores ficam alinhados |
| "Desfazer" ao apagar | `SnackBar` em `_remover` | É fácil arrastar sem querer; ninguém deve perder dados por isso |
| Seta ↑/↓ além da cor | `_itemDaLista` | Daltônicos podem não diferenciar verde de vermelho |

## Perguntas prováveis e respostas

**Por que Flutter?** Com um código só, o app roda em Android, iOS, Web e Desktop.

**Onde os dados ficam salvos?** No próprio celular, com a biblioteca `shared_preferences` (no Android ela usa o armazenamento interno do app). Se desinstalar o app, os dados somem.

**Por que o valor é sempre positivo e existe o campo `ehEntrada`?** Fica mais simples para o usuário (ele não precisa digitar sinal de menos) e para somar separado entradas e gastos.

**Por que o saldo não é guardado numa variável?** Porque ele é calculado a partir da lista. Se guardássemos, ele poderia ficar diferente da lista (ex.: apagou um item e esqueceu de atualizar o saldo). Calculando sempre, isso nunca acontece.

**O que acontece se o usuário digitar "abc" no valor?** O `_validarValor` usa `double.tryParse`, que devolve `null` quando o texto não é número. Aí o campo mostra "Digite um valor maior que zero" e não salva.

**E se digitar "12,50" com vírgula?** O código troca a vírgula por ponto (`replaceAll(',', '.')`) antes de converter, porque o Dart só entende ponto.

**Por que `_` no nome de algumas coisas?** No Dart, `_` deixa a variável, função ou classe privada: só pode ser usada dentro daquele arquivo.

**Como vocês testaram?** Com testes automáticos (`flutter test`): soma de entradas e gastos, salvar e carregar sem perder dados, formatação do dinheiro, e um teste que abre o app e confere se o saldo começa em R$ 0,00.

**O que vocês melhorariam?** Filtro por mês, editar lançamento, escolher a data, gráfico por categoria.

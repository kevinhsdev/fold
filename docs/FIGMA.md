# Figma do Fold (Pessoa 1)

Aqui fica o design do app. As telas prontas estão na pasta [`docs/figma/`](figma/) em arquivos `.svg`, que o Figma abre direto e deixa tudo editavel (textos, cores, ícones).

| Arquivo | O que é |
|---|---|
| `00-guia-de-estilo.svg` | cores, fonte e os componentes |
| `01-inicio.svg` | tela inicial com lançamentos |
| `02-inicio-vazio.svg` | tela inicial quando ainda não tem nada salvo |
| `03-novo-lancamento.svg` | formulário preenchido |
| `04-erro-no-formulario.svg` | formulário quando a pessoa tenta salvar vazio |

## Como colocar no Figma (5 minutos)

1. Entra no figma.com (conta gratis serve) e cria um **Design file** novo, chama de **Fold – Telas**.
2. Abre a pasta `docs/figma` no computador, seleciona os 5 arquivos `.svg` e **arrasta pra dentro do Figma**. Cada arquivo vira um frame.
3. Organiza os frames lado a lado na ordem (00, 01, 02, 03, 04). O guia de estilo pode ficar numa página separada chamada "Guia".
4. Se algum texto aparecer com a fonte errada: seleciona o frame inteiro e troca a fonte pra **Manrope** (ela já vem no Figma, é do Google Fonts).
5. Renomeia os frames: `Início`, `Início – vazio`, `Novo lançamento`, `Novo lançamento – erro`.

> Obs: os ícones são do Material Icons (versão Rounded), os mesmos que o Flutter usa. Então o que ta no Figma é igual ao app.

## Deixando com cara de "feito no Figma" (vale fazer)

Isso é o que o professor costuma olhar, então vale a pena gastar uns minutos:

- **Estilos de cor:** no guia de estilo, clica em cada quadrado de cor > no painel da direita, em Fill, clica nos 4 pontinhos > **+** e salva com o nome (`fundo`, `tinta`, `entrada`, `gasto`...). Os nomes são iguais aos do código no `lib/tema.dart`.
- **Componentes:** seleciona o botão "Salvar lançamento" e aperta **Ctrl + Alt + K**. Faz o mesmo com o campo de texto, o chip e o item da lista.
- **Protótipo navegavel:** aba **Prototype** (lado direito):
  - no frame `Início`, liga o botão **Novo lançamento** no frame `Novo lançamento` com a animação **Move in** de baixo pra cima (300ms, Ease out);
  - no `Novo lançamento`, liga o **X** e o **Salvar lançamento** de volta pro `Início` com **Move out** pra baixo.
  - Aperta o ▶ (Present) pra testar. Na apresentação da pra mostrar clicando.
- **Compartilhar:** botão Share > "Anyone with the link can view" e coloca o link aqui embaixo.

🔗 Link do Figma: _(colar aqui)_

## Cores

| Nome | Pra que usa | Cor |
|---|---|---|
| fundo | fundo das telas | `#F6F4EF` |
| superficie | cards, lista, campos e chips | `#FFFFFF` |
| tinta | texto principal e botões | `#17191C` |
| tintaSuave | textos de apoio ("Saldo atual", datas, "R$") | `#6B6F76` |
| linha | linha fina entre os itens da lista | `#E7E3DA` |
| entrada | dinheiro que entrou | `#1E7A52` |
| gasto | dinheiro que saiu, erros | `#B93A2B` |

## Fonte

**Manrope**, gratis no Google Fonts.

| Onde | Tamanho | Peso |
|---|---|---|
| Número do saldo | 48 | 800 (ExtraBold) |
| "R$" do saldo | 22 | 700 |
| Título "Lançamentos" | 20 | 800 |
| Título da barra de cima | 17 | 700 |
| Nome do item e valor | 15 | 700 |
| Categoria · data | 13 | 500 |
| Texto normal | 14 | 400 |

## Medidas

- Tamanho da tela: **390 x 844** (iPhone 14).
- Margem dos lados: **20**.
- Cantos arredondados: cards **20**, campos **16**, botão **18**, quadradinho do ícone **14**, chips **12**.

## Porque a gente escolheu assim (pra explicar na apresentação)

- **Saldo bem grande e sem caixa em volta:** é a primeira coisa que a pessoa quer ver quando abre o app.
- **Cor só quando significa alguma coisa:** verde = entrou dinheiro, vermelho = saiu. O resto é preto e cinza. Os gastos na lista ficam em preto e não em vermelho, senão o app parece que ta brigando com você toda vez que você almoça.
- **Setinha ↗ ↙ junto com a cor:** quem é daltônico pode não diferenciar verde de vermelho, então a seta ajuda.
- **Categorias em "chips" e não numa lista que abre:** da pra ver todas de uma vez e escolher com um toque só.
- **Fundo bege clarinho em vez de branco:** cansa menos a vista e os cards brancos aparecem sem precisar de sombra.

# Guia do Figma (Pessoa 1)

O objetivo é desenhar no Figma **as mesmas telas que o código faz**, para mostrar o planejamento visual. Frame: **iPhone 14 (390 × 844)**.

**Estilo:** calmo e editorial, como os apps de finanças premium da App Store. Fundo off-white quente, muito espaço em branco, um único destaque por tela (o saldo; no formulário, o valor), cor só onde ela tem significado (verde = entrou, vermelho = saiu).

## Cores (iguais às de `lib/tema.dart`)

| Nome no código | Uso | Hex |
|---|---|---|
| `fundo` | Fundo das telas | `#F6F4EF` |
| `superficie` | Blocos brancos (lista, resumos, campos, chips) | `#FFFFFF` |
| `tinta` | Texto principal, botão, chip/opção selecionada | `#17191C` |
| `tintaSuave` | Textos secundários ("Saldo atual", datas, "R$") | `#6B6F76` |
| `linha` | Divisória entre itens da lista | `#E7E3DA` |
| `entrada` | Valor de entrada, ícone de entrada | `#1E7A52` |
| `gasto` | Ícone de gasto, saldo negativo, fundo de apagar | `#B93A2B` |

Crie essas 7 cores como **Color Styles** no Figma com os mesmos nomes.

## Tipografia

Fonte **Manrope** (Google Fonts, gratuita; no Figma ela já aparece na lista de fontes).

| Elemento | Tamanho | Peso |
|---|---|---|
| Saldo (número) | 48 | ExtraBold (800), espaçamento entre letras −1.5 |
| "R$" do saldo | 22 | Bold (700), cor `tintaSuave` |
| Título de seção ("Lançamentos") | 20 | ExtraBold (800) |
| Título da barra ("Novo lançamento") | 17 | Bold (700) |
| Título do item da lista / valores | 15 | Bold (700) |
| "Saldo atual", "Categoria" | 15 | SemiBold (600) |
| Subtítulo do item (categoria · data) | 13 | Medium (500), `tintaSuave` |

## Espaçamentos e cantos

- Margem lateral das telas: **20**.
- Cantos arredondados: blocos e resumos **20**, campos **16**, ícone da categoria **14**, chips **12**, botão **18**.
- Espaço maior **antes** de uma seção (36) do que entre o título e o conteúdo dela (12).

## Tela 1: Início

```
┌──────────────────────────────┐
│ Saldo atual                  │  ← 15, cinza
│ R$ 1.245,70                  │  ← "R$" 22 cinza + número 48 extra negrito
│                              │
│ ┌────────────┐ ┌────────────┐│
│ │↙ Entradas  │ │↗ Gastos    ││  ← dois blocos brancos lado a lado
│ │R$ 1.450,00 │ │R$ 204,30   ││
│ └────────────┘ └────────────┘│
│                              │
│ Lançamentos                  │  ← 20 extra negrito
│ ┌──────────────────────────┐ │
│ │[🍴] Almoço no RU  −R$18,50│ │  ← quadradinho com ícone da categoria
│ │     Alimentação · 13/11   │ │     (fundo da cor com 10% de opacidade)
│ │──────────────────────────│ │  ← divisória que começa depois do ícone
│ │[💵] Estágio   +R$1.450,00│ │  ← entrada em verde; gasto em preto
│ │     Salário · 10/11       │ │
│ └──────────────────────────┘ │
│                              │
│      ( + Novo lançamento )   │  ← pílula escura centralizada
└──────────────────────────────┘
```

Variações:
- **Lista vazia:** bloco branco com ícone de recibo, "Nenhum lançamento ainda" e "Toque em "Novo lançamento" para registrar seu primeiro gasto ou entrada."
- **Apagando item:** item deslocado para a esquerda, fundo vermelho com lixeira branca, e aviso escuro arredondado no rodapé: `"Almoço" apagado   Desfazer`.

## Tela 2: Novo lançamento (abre de baixo para cima)

```
┌──────────────────────────────┐
│ ✕       Novo lançamento      │
│ [■ ↗ Gasto ][  ↙ Entrada  ]  │  ← opção marcada: fundo escuro, texto branco
│                              │
│ R$ 12,50                     │  ← valor gigante (44), verde se for Entrada
│                              │
│ ┌──────────────────────────┐ │
│ │ Descrição (ex.: Almoço)  │ │  ← campo branco sem borda
│ └──────────────────────────┘ │
│ Categoria                    │
│ (■Alimentação) (Transporte)  │  ← chips: marcado escuro, outros brancos
│ (Moradia) (Lazer) (Estudos)  │
│ (Salário) (Outros)           │
│                              │
│ [     Salvar lançamento     ]│  ← botão escuro, altura 56
└──────────────────────────────┘
```

Variação **com erro**: texto vermelho pequeno embaixo do campo: "Digite um valor maior que zero" / "Digite uma descrição".

Ícones (Material Symbols, versão Rounded): Alimentação `restaurant`, Transporte `directions_bus`, Moradia `home`, Lazer `sports_esports`, Estudos `school`, Salário `payments`, Outros `category`.

## Componentes (crie como Components no Figma)

1. **Item da lista**, com variantes `Entrada` e `Gasto`.
2. **Bloco de resumo** (Entradas / Gastos).
3. **Chip de categoria**, com variantes `Marcado` e `Normal`.
4. **Campo de texto**, com variantes `Normal` e `Erro`.
5. **Botão principal** e **Botão pílula**.

## Protótipo (impressiona na apresentação)

Botão **Novo lançamento** → Tela 2 com *Move In* de baixo (300 ms, Ease Out). **Salvar** e **✕** → voltam com *Move Out* para baixo.

## Por que essas escolhas (para explicar)

- **Saldo sem caixa em volta, em letra enorme:** é a única coisa que o usuário quer ver ao abrir o app, então ele domina a tela sozinho.
- **Cor só com significado:** verde = dinheiro entrando, vermelho = saindo. O resto é preto e cinza. Gastos ficam em **preto** na lista (não em vermelho) para o app não parecer uma bronca a cada almoço.
- **Seta ↗/↙ e ícone além da cor:** daltônicos podem não diferenciar verde de vermelho.
- **Chips em vez de lista suspensa:** todas as categorias visíveis, escolha com um toque.
- **Fundo off-white em vez de branco puro:** cansa menos a vista e faz os blocos brancos se destacarem sem precisar de sombra.

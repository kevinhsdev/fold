# Quadro do Trello (Pessoa 3)

Esse é o quadro que a gente usou pra organizar o trabalho. O print/protótipo dele ta em [`docs/trello/quadro.html`](trello/quadro.html) (abre no navegador e da pra clicar nos cartões).

## Como montar no Trello (uns 15 minutos)

1. Entra em trello.com, cria um quadro chamado **Fold – Flutter**.
2. Cria as 5 listas: `Backlog (ideias pra depois)`, `A Fazer`, `Fazendo`, `Revisão`, `Feito`.
3. Cria as etiquetas (clica em um cartão > Etiquetas):
   - Design
   - Código
   - Documentação
   - Bug
   - Melhoria
4. Convida os outros 2 do grupo (botão **Compartilhar**).
5. **Dica pra ir rapido:** copia o bloco de títulos de cada lista abaixo, clica em "Adicionar um cartão" e cola. O Trello pergunta se quer criar um cartão por linha, clica em **sim**. Depois é só abrir cada cartão e colar a descrição, o checklist, a etiqueta, quem ta responsavel e a data.

**Legenda:** P1 = Pessoa 1 (design) · P2 = Pessoa 2 (código) · P3 = Pessoa 3 (documentação)

## Lista: Backlog (ideias pra depois)

Títulos pra colar de uma vez:

```
Filtrar lançamentos por mês
Editar um lançamento
Gráfico de gastos por categoria
Escolher a data do lançamento
```

### Filtrar lançamentos por mês
*Etiqueta: Melhoria · Responsável: P2*

Hoje o app soma tudo desde o primeiro lançamento. Seria legal ter um seletor de mês em cima do saldo.

### Editar um lançamento
*Etiqueta: Melhoria · Responsável: P2*

Por enquanto só da pra apagar e criar de novo. A ideia é tocar no item e abrir o formulário já preenchido.

### Gráfico de gastos por categoria
*Etiqueta: Melhoria, Design · Responsável: P1, P2*

Um grafico de pizza ou barras mostrando onde o dinheiro mais vai (ex: alimentação 40%).

### Escolher a data do lançamento
*Etiqueta: Melhoria · Responsável: P2*

Hoje a data é sempre a do dia que salvou. Colocar um campo de data no formulario.

## Lista: A Fazer

Títulos pra colar de uma vez:

```
Gravar vídeo curto do app funcionando
```

### Gravar vídeo curto do app funcionando
*Etiqueta: Documentação · Responsável: P3 · Entrega: 18/11*

Gravar uns 40 segundos usando o app no celular, caso a internet ou o projetor falhe na hora da apresentação.

Checklist:
- [ ] Gravar a tela do celular
- [ ] Cortar o video
- [ ] Colocar no slide

## Lista: Fazendo

Títulos pra colar de uma vez:

```
Montar os slides da apresentação
```

### Montar os slides da apresentação
*Etiqueta: Documentação · Responsável: P3, P1 · Entrega: 18/11*

Slides simples: problema, telas do figma, demo, um pedaço do código e o trello. Usar as cores do app nos slides tbm.

Checklist:
- [ ] Slide do problema
- [ ] Prints do Figma
- [ ] Prints do app
- [ ] Print do Trello
- [ ] Slide final (melhorias futuras)

> 💬 Comentário: P1: ja coloquei as telas do figma nos slides 3 e 4

## Lista: Revisão

Títulos pra colar de uma vez:

```
Revisar o README
```

### Revisar o README
*Etiqueta: Documentação · Responsável: P3, P2 · Entrega: 17/11*

Conferir se o passo a passo de rodar o app funciona num pc que nunca teve flutter.

Checklist:
- [ ] Testar o passo a passo do zero
- [ ] Conferir os links
- [ ] Corrigir erros de portugues

> 💬 Comentário: P2: testei no pc da faculdade e funcionou, so faltou falar do modo desenvolvedor do windows. ja arrumei

## Lista: Feito

Títulos pra colar de uma vez:

```
Escolher a ideia do app
Escrever os requisitos (RF e RNF)
Escolher o nome do app
Definir cores e fonte
Desenhar tela inicial
Desenhar tela de novo lançamento
Fazer o protótipo navegavel no Figma
Instalar o Flutter e criar o projeto
Criar a classe Transacao (modelo)
Tela inicial com saldo e lista
Formulário com validação
Salvar os dados no celular
Apagar arrastando + botão desfazer
Bug: valor 1234,5 aparecia sem ponto de milhar
Testes automaticos
Publicar versão web (GitHub Pages)
Escrever o README
Explicação do codigo pra apresentação
```

### Escolher a ideia do app
*Etiqueta: Documentação · Responsável: P1, P2, P3 · Entrega: 21/10*

A gente pensou em lista de tarefas, controle de agua e controle de gastos. Escolhemos o de gastos porque é util pra todo mundo e da pra fazer em 2 telas.

> 💬 Comentário: P3: votação deu 3x0 pro controle de gastos

### Escrever os requisitos (RF e RNF)
*Etiqueta: Documentação · Responsável: P3 · Entrega: 23/10*

Lista do que o app precisa fazer. Ficou: RF01 cadastrar, RF02 validar, RF03 listar, RF04 mostrar saldo, RF05 apagar com desfazer, RNF01 salvar no celular, RNF02 interface simples em portugues.

Checklist:
- [x] RF01 a RF05
- [x] RNF01 e RNF02
- [x] Colocar no README

### Escolher o nome do app
*Etiqueta: Design, Documentação · Responsável: P1, P2, P3 · Entrega: 24/10*

Ideias: Meus Gastos, Cofrinho, Grana, Fold. Ficou **Fold** (de "dobrar" a nota de dinheiro na carteira). Curto e facil de lembrar.

> 💬 Comentário: P1: fiz o icone da carteira pra combinar com o nome

### Definir cores e fonte
*Etiqueta: Design · Responsável: P1 · Entrega: 25/10*

Fundo bege clarinho (#F6F4EF), texto quase preto (#17191C), verde pra entrada (#1E7A52) e vermelho pra gasto (#B93A2B). Fonte Manrope (é gratis, do Google Fonts).

Checklist:
- [x] Paleta de cores
- [x] Fonte
- [x] Guia de estilo no Figma

> 💬 Comentário: P1: comecei com a Roboto mas a Manrope deixou com cara de app mais caprichado

### Desenhar tela inicial
*Etiqueta: Design · Responsável: P1 · Entrega: 27/10*

Saldo grande em cima, dois cards (entradas e gastos), lista dos lançamentos e o botão "Novo lançamento" embaixo.

Checklist:
- [x] Versão com lançamentos
- [x] Versão vazia (sem nada salvo)

### Desenhar tela de novo lançamento
*Etiqueta: Design · Responsável: P1 · Entrega: 28/10*

Escolher gasto ou entrada, digitar o valor bem grande, descrição, categoria e botão salvar.

Checklist:
- [x] Versão preenchida
- [x] Versão com erro (campo vazio)

### Fazer o protótipo navegavel no Figma
*Etiqueta: Design · Responsável: P1 · Entrega: 30/10*

Ligar o botão "Novo lançamento" na tela do formulario e o "Salvar"/"X" de volta pra tela inicial.

Checklist:
- [x] Ligações entre as telas
- [x] Testar no modo apresentação

### Instalar o Flutter e criar o projeto
*Etiqueta: Código · Responsável: P2 · Entrega: 27/10*

flutter create, rodar no chrome pra ver se esta tudo certo.

Checklist:
- [x] Instalar Flutter
- [x] flutter doctor
- [x] Criar projeto
- [x] Rodar no Chrome

> 💬 Comentário: P2: no windows precisou ligar o Modo de Desenvolvedor senão o shared_preferences nao compilava

### Criar a classe Transacao (modelo)
*Etiqueta: Código · Responsável: P2 · Entrega: 29/10*

Arquivo lib/transacao.dart. Guarda descrição, valor, se é entrada, categoria e data. Tem as funções de somar e formatar dinheiro.

Checklist:
- [x] Classe com os campos
- [x] paraMapa e deMapa (pra salvar)
- [x] somar()
- [x] formatarDinheiro()

### Tela inicial com saldo e lista
*Etiqueta: Código · Responsável: P2 · Entrega: 01/11*

Arquivo lib/tela_inicial.dart. Mostra o saldo, os cards e a lista igual o Figma.

Checklist:
- [x] Saldo
- [x] Cards de entrada e gasto
- [x] Lista
- [x] Mensagem de lista vazia

### Formulário com validação
*Etiqueta: Código · Responsável: P2 · Entrega: 03/11*

Arquivo lib/tela_adicionar.dart. Não deixa salvar sem descrição ou com valor zero.

Checklist:
- [x] Campo valor
- [x] Campo descrição
- [x] Escolher categoria
- [x] Validação
- [x] Botão salvar

### Salvar os dados no celular
*Etiqueta: Código · Responsável: P2 · Entrega: 05/11*

Usando o shared_preferences. Os lançamentos viram texto JSON e ficam guardados mesmo fechando o app.

Checklist:
- [x] Salvar
- [x] Carregar ao abrir o app

### Apagar arrastando + botão desfazer
*Etiqueta: Código · Responsável: P2 · Entrega: 06/11*

Arrasta o item pro lado e ele some. Aparece um aviso embaixo com "Desfazer" caso tenha sido sem querer.

### Bug: valor 1234,5 aparecia sem ponto de milhar
*Etiqueta: Bug, Código · Responsável: P2 · Entrega: 07/11*

Aparecia "R$ 1234,50" em vez de "R$ 1.234,50". Arrumado na função formatarDinheiro e criado um teste pra isso nao voltar.

> 💬 Comentário: P3: achei testando com o salario, conferi de novo e agora ta certo

### Testes automaticos
*Etiqueta: Código · Responsável: P2 · Entrega: 08/11*

flutter test com 4 testes: soma, salvar/carregar, formatação e abrir o app.

Checklist:
- [x] Teste da soma
- [x] Teste de salvar e carregar
- [x] Teste de formatação
- [x] Teste da tela

### Publicar versão web (GitHub Pages)
*Etiqueta: Código · Responsável: P2 · Entrega: 12/11*

Toda vez que manda codigo pro GitHub ele roda os testes e publica sozinho em kevinhsdev.github.io/fold. Assim da pra abrir no celular de qualquer um.

Checklist:
- [x] Workflow do GitHub Actions
- [x] Icone e nome Fold
- [x] Testar no celular

### Escrever o README
*Etiqueta: Documentação · Responsável: P3 · Entrega: 10/11*

Problema, equipe, requisitos, estrutura das pastas, como rodar e limitações.

Checklist:
- [x] Problema
- [x] Requisitos
- [x] Como rodar
- [x] Limitações

### Explicação do codigo pra apresentação
*Etiqueta: Documentação · Responsável: P3, P2 · Entrega: 11/11*

Arquivo docs/EXPLICACAO.md com os conceitos (widget, setState, Navigator...) e perguntas que o professor pode fazer.

## Dicas que ajudam na nota

- Tirem print do quadro em **3 momentos** (começo, meio e fim). Mostra que o quadro foi usado de verdade e nao feito no ultimo dia.
- Sempre que alguem terminar uma coisa, arrasta o cartão pra direita e escreve um comentario curto do que fez.
- Bug achado vira cartão com a etiqueta vermelha. Professor gosta de ver que a gente testou.
- Na apresentação mostra a lista **Feito** cheia e o **Backlog** com as melhorias futuras.

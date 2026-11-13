# 💰 Meus Gastos

App em **Flutter** para controlar o próprio dinheiro: você lança o que **gastou** e o que **recebeu**, e o app mostra o **saldo**. Os dados ficam salvos no celular, então nada se perde ao fechar o app.

## Equipe

| Pessoa | Papel | Entrega |
|---|---|---|
| Pessoa 1 | Design | Telas no Figma, seguindo [docs/FIGMA.md](docs/FIGMA.md) |
| Pessoa 2 | Desenvolvimento | Código Flutter (pasta `lib/`) e testes (pasta `test/`) |
| Pessoa 3 | Documentação e gestão | Este README e o quadro Trello em [docs/TRELLO.md](docs/TRELLO.md) |

## Problema que o app resolve

Muita gente (principalmente estudante) não sabe para onde vai o dinheiro do mês. Anotar em papel ou em planilha dá trabalho. O app faz isso em poucos toques.

## Funcionalidades (requisitos)

| # | Requisito | Onde está no código |
|---|---|---|
| RF01 | Cadastrar um gasto ou uma entrada (descrição, valor, categoria) | `lib/tela_adicionar.dart` |
| RF02 | Validar o formulário (descrição obrigatória, valor maior que zero) | `_validarValor` e `validator` em `tela_adicionar.dart` |
| RF03 | Listar os lançamentos, do mais novo para o mais antigo | `ListView.builder` em `lib/tela_inicial.dart` |
| RF04 | Mostrar saldo, total de entradas e total de gastos | `_cartaoResumo` em `tela_inicial.dart` + `somar` em `transacao.dart` |
| RF05 | Apagar um lançamento arrastando para o lado, com opção de desfazer | `Dismissible` + `_remover` em `tela_inicial.dart` |
| RNF01 | Salvar os dados no celular | `_salvar` / `_carregar` com `shared_preferences` |
| RNF02 | Interface simples, em português, com cores (verde = entrada, vermelho = gasto) | `lib/tema.dart` + telas |

## Estrutura do projeto

```
lib/
  main.dart            → ponto de partida: liga o app e aplica o tema
  tema.dart            → identidade visual: cores, fonte, botões, campos, ícones das categorias
  transacao.dart       → MODELO: classe Transacao, soma e formatação (sem tela)
  tela_inicial.dart    → tela principal: saldo + lista + salvar/carregar
  tela_adicionar.dart  → formulário de novo lançamento
assets/fonts/          → fonte Manrope (licença livre OFL)
test/
  widget_test.dart     → testes automáticos
docs/
  FIGMA.md             → guia do design
  TRELLO.md            → quadro de tarefas
  EXPLICACAO.md        → conceitos e perguntas prováveis na apresentação
```

**Fluxo:** `main.dart` abre a `TelaInicial` → ela lê os dados salvos → o usuário toca em **+** → abre a `TelaAdicionar` → ao salvar, a tela devolve uma `Transacao` → a `TelaInicial` coloca na lista, recalcula o saldo e salva no celular.

## Como rodar

1. Instale o Flutter: https://docs.flutter.dev/get-started/install (no Windows, depois rode `flutter doctor` para conferir). No Windows, ligue também o **Modo de Desenvolvedor** (`start ms-settings:developers`), que o Flutter exige para compilar plugins como o `shared_preferences`.
2. Na pasta do projeto, gere as pastas de cada plataforma (Android, Web etc.). **Só precisa fazer uma vez**:
   ```
   flutter create --project-name controle_gastos .
   ```
   Esse comando não apaga os nossos arquivos, só cria o que está faltando.
3. Baixe as bibliotecas:
   ```
   flutter pub get
   ```
4. Rode o app (num emulador, num celular ligado no USB ou no navegador):
   ```
   flutter run
   ```
5. Rode os testes:
   ```
   flutter test
   ```

## Roteiro de apresentação (5 minutos)

1. **Problema** (Pessoa 3): por que controlar gastos, para quem é o app.
2. **Design** (Pessoa 1): mostrar as 2 telas no Figma e as escolhas de cor.
3. **Demonstração** (Pessoa 2): lançar um salário, lançar um almoço, ver o saldo mudar, apagar e desfazer, fechar e abrir o app (os dados continuam lá).
4. **Código** (Pessoa 2): abrir `transacao.dart` (modelo) e `tela_inicial.dart` (estado + `setState`).
5. **Organização** (Pessoa 3): mostrar o Trello e como as tarefas foram divididas.

## Limitações conhecidas (melhorias futuras)

- Não filtra por mês: soma tudo desde o primeiro lançamento.
- Não dá para editar um lançamento, só apagar e criar de novo.
- A data é sempre a do momento em que você salvou.
- Os dados ficam só naquele celular (sem conta ou nuvem).

// =====================================================================
// tela_inicial.dart — TELA PRINCIPAL: saldo + resumo + lista de lançamentos.
// =====================================================================

import 'dart:convert'; // jsonEncode / jsonDecode: converter lista <-> texto
import 'package:flutter/services.dart'; // HapticFeedback: vibraçãozinha do celular
import 'package:material_ui/material_ui.dart'; // widgets visuais (Material Design)
import 'package:shared_preferences/shared_preferences.dart'; // salvar no celular
import 'tela_adicionar.dart'; // tela do formulário
import 'tema.dart'; // cores e ícones das categorias
import 'transacao.dart'; // nosso modelo e funções de soma/formatação

// StatefulWidget = widget COM estado: a tela muda quando os dados mudam
// (ex.: ao adicionar um gasto, a lista e o saldo precisam ser redesenhados).
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key}); // construtor padrão

  // Cria o objeto que guarda o estado (os dados) desta tela.
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

// O "_" no começo do nome deixa a classe privada (só existe neste arquivo).
class _TelaInicialState extends State<TelaInicial> {
  // Lista com todas as transações. É o ESTADO da tela.
  final List<Transacao> _transacoes = [];

  // initState() roda UMA vez, quando a tela é criada.
  @override
  void initState() {
    super.initState(); // obrigatório: deixa o Flutter fazer a parte dele
    _carregar(); // busca os dados salvos no celular
  }

  // Lê do celular as transações salvas.
  // "async" + "Future" = função que demora (acessa o armazenamento),
  // então o app não trava enquanto espera.
  Future<void> _carregar() async {
    final prefs = await SharedPreferences.getInstance(); // "await" espera abrir o armazenamento
    final texto = prefs.getString('transacoes'); // lê o texto salvo na chave 'transacoes'
    if (texto == null) return; // primeira vez usando o app: nada salvo, sai da função
    final List lista = jsonDecode(texto); // texto JSON vira uma lista de mapas
    setState(() { // setState avisa o Flutter: "os dados mudaram, redesenhe a tela"
      _transacoes.addAll(lista.map((mapa) => Transacao.deMapa(mapa))); // cada mapa vira Transacao
    });
  }

  // Grava a lista atual no celular.
  Future<void> _salvar() async {
    final prefs = await SharedPreferences.getInstance(); // abre o armazenamento
    final lista = _transacoes.map((t) => t.paraMapa()).toList(); // cada Transacao vira mapa
    await prefs.setString('transacoes', jsonEncode(lista)); // lista vira texto JSON e é salva
  }

  // Abre a tela de adicionar e espera ela devolver uma transação.
  Future<void> _abrirTelaAdicionar() async {
    // Navigator.push empilha uma nova tela por cima desta.
    // O "await" espera até o usuário salvar ou fechar.
    final nova = await Navigator.push<Transacao>(
      context, // "onde" estamos na árvore de widgets
      MaterialPageRoute(
        fullscreenDialog: true, // abre de baixo para cima, com "X" para fechar (como no iPhone)
        builder: (context) => const TelaAdicionar(), // qual tela abrir
      ),
    );
    if (nova == null) return; // usuário fechou sem salvar: não faz nada
    setState(() => _transacoes.insert(0, nova)); // coloca no topo da lista e redesenha
    _salvar(); // grava no celular
  }

  // Remove uma transação (chamado ao arrastar o item para o lado).
  void _remover(Transacao t) {
    final posicao = _transacoes.indexOf(t); // guarda onde ela estava, para poder desfazer
    setState(() => _transacoes.remove(t)); // tira da lista e redesenha
    _salvar(); // grava no celular
    HapticFeedback.mediumImpact(); // vibraçãozinha confirmando que apagou

    // SnackBar = aviso temporário no rodapé. Damos a chance de desfazer,
    // porque é fácil arrastar um item sem querer.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${t.descricao}" apagado'), // mensagem do aviso
        action: SnackBarAction(
          label: 'Desfazer', // botão dentro do aviso
          textColor: Cores.superficie, // texto branco no aviso escuro
          onPressed: () { // ao tocar em "Desfazer":
            setState(() => _transacoes.insert(posicao, t)); // devolve para o mesmo lugar
            _salvar(); // grava de novo
          },
        ),
      ),
    );
  }

  // Desenha a tela. O Flutter chama build() de novo a cada setState().
  @override
  Widget build(BuildContext context) {
    final entradas = somar(_transacoes, entrada: true); // total que entrou
    final gastos = somar(_transacoes, entrada: false); // total que saiu
    final saldo = entradas - gastos; // quanto sobrou

    return Scaffold(
      // SafeArea evita que o conteúdo fique embaixo do relógio/câmera do celular.
      body: SafeArea(
        // ListView = coluna que rola. Tudo da tela está dentro dela.
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 120), // 120 embaixo: o botão não cobre o último item
          children: [
            _saldo(saldo), // número grande do saldo
            const SizedBox(height: 20), // espaço
            Row( // os dois resumos lado a lado
              children: [
                Expanded(child: _resumo('Entradas', entradas, Icons.south_west_rounded, Cores.entrada)), // metade da largura
                const SizedBox(width: 12), // espaço entre eles
                Expanded(child: _resumo('Gastos', gastos, Icons.north_east_rounded, Cores.gasto)), // outra metade
              ],
            ),
            const SizedBox(height: 36), // espaço maior antes da próxima seção
            const Text( // título da seção
              'Lançamentos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Cores.tinta),
            ),
            const SizedBox(height: 12),
            _transacoes.isEmpty ? _listaVazia() : _lista(), // mostra a lista ou o aviso de vazia
          ],
        ),
      ),
      // Botão "pílula" escuro, centralizado embaixo.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirTelaAdicionar, // o que fazer ao tocar
        backgroundColor: Cores.tinta, // fundo escuro
        foregroundColor: Cores.superficie, // texto e ícone brancos
        elevation: 2, // sombra leve
        icon: const Icon(Icons.add_rounded), // ícone de "+"
        label: const Text('Novo lançamento', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // centralizado
    );
  }

  // O saldo em destaque: "Saldo atual" pequeno e o valor bem grande.
  Widget _saldo(double saldo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // alinha tudo à esquerda
      children: [
        const Text('Saldo atual', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Cores.tintaSuave)),
        const SizedBox(height: 6),
        // TweenAnimationBuilder anima o número do valor antigo até o novo,
        // assim o usuário PERCEBE que o saldo mudou depois de lançar algo.
        TweenAnimationBuilder<double>(
          tween: Tween(end: saldo), // anima até o saldo atual
          // Se o usuário desligou animações no celular (acessibilidade), duração zero.
          duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic, // começa rápido e desacelera: parece mais responsivo
          builder: (context, valorAnimado, _) => Text.rich( // Text.rich = texto com partes de estilos diferentes
            TextSpan(
              children: [
                // Parte 1: "R$ " menor e cinza, para o número ser o protagonista.
                const TextSpan(text: 'R\$ ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Cores.tintaSuave)),
                // Parte 2: o número grande. replaceFirst tira o "R$ " que formatarDinheiro já coloca.
                TextSpan(text: formatarDinheiro(valorAnimado).replaceFirst('R\$ ', '')),
              ],
            ),
            style: TextStyle(
              fontSize: 48, // bem grande
              fontWeight: FontWeight.w800, // extra negrito
              letterSpacing: -1.5, // letras um pouco mais juntas: fica mais elegante em tamanho grande
              color: saldo < 0 ? Cores.gasto : Cores.tinta, // vermelho só se estiver negativo
              fontFeatures: const [FontFeature.tabularFigures()], // dígitos de mesma largura: o número não "treme" ao animar
            ),
          ),
        ),
      ],
    );
  }

  // Caixinha de resumo (usada para Entradas e para Gastos).
  Widget _resumo(String titulo, double valor, IconData icone, Color cor) {
    return Container(
      padding: const EdgeInsets.all(16), // espaço interno
      decoration: BoxDecoration(
        color: Cores.superficie, // fundo branco
        borderRadius: BorderRadius.circular(20), // cantos arredondados
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // alinha à esquerda
        children: [
          Row(
            children: [
              Icon(icone, size: 16, color: cor), // setinha colorida
              const SizedBox(width: 6),
              Text(titulo, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Cores.tintaSuave)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            formatarDinheiro(valor), // ex.: "R$ 1.000,00"
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Cores.tinta,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  // Lista de lançamentos dentro de um bloco branco arredondado (estilo iOS).
  Widget _lista() {
    return ClipRRect( // corta os itens nos cantos arredondados (inclusive ao arrastar)
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Cores.superficie, // fundo branco do bloco
        child: Column(
          children: [
            // "for" dentro de uma lista: cria um widget para cada transação.
            for (int i = 0; i < _transacoes.length; i++) ...[ // "..." espalha os itens do grupo na lista
              if (i > 0) const Divider(height: 1, indent: 76, color: Cores.linha), // linha fina entre itens (menos antes do primeiro)
              _itemDaLista(_transacoes[i]),
            ],
          ],
        ),
      ),
    );
  }

  // Desenha uma linha da lista para a transação "t".
  Widget _itemDaLista(Transacao t) {
    final cor = t.ehEntrada ? Cores.entrada : Cores.gasto; // verde = entrada, vermelho = gasto

    // Dismissible permite arrastar o item para o lado para apagar.
    return Dismissible(
      key: ObjectKey(t), // identificação única do item (o Flutter exige)
      direction: DismissDirection.endToStart, // só deixa arrastar da direita para a esquerda
      onDismissed: (_) => _remover(t), // quando terminar de arrastar, remove
      background: Container( // o que aparece "atrás" do item enquanto arrasta
        color: Cores.gasto, // fundo vermelho
        alignment: Alignment.centerRight, // ícone encostado à direita
        padding: const EdgeInsets.only(right: 24), // afasta o ícone da borda
        child: const Icon(Icons.delete_rounded, color: Cores.superficie), // lixeira branca
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // espaço interno da linha
        child: Row(
          children: [
            // Quadradinho arredondado com o ícone da categoria.
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cor.withValues(alpha: 0.10), // fundo da cor, bem clarinho (10%)
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(iconesDasCategorias[t.categoria] ?? Icons.category_rounded, color: cor, size: 22), // "??" = se não achar, usa o genérico
            ),
            const SizedBox(width: 16),
            // Expanded faz o texto ocupar o espaço do meio.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.descricao, // ex.: "Almoço"
                    maxLines: 1, // uma linha só...
                    overflow: TextOverflow.ellipsis, // ...e "..." se o texto for comprido
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Cores.tinta),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${t.categoria} · ${formatarData(t.data)}', // ex.: "Alimentação · 13/11/2026"
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Cores.tintaSuave),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Valor à direita: entrada em verde com "+", gasto em preto com "−".
            Text(
              '${t.ehEntrada ? '+' : '−'} ${formatarDinheiro(t.valor)}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: t.ehEntrada ? Cores.entrada : Cores.tinta, // gasto em preto: menos "alarmante"
                fontFeatures: const [FontFeature.tabularFigures()], // valores alinhados
              ),
            ),
          ],
        ),
      ),
    );
  }

  // O que aparece quando ainda não existe nenhum lançamento.
  Widget _listaVazia() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(color: Cores.superficie, borderRadius: BorderRadius.circular(20)),
      child: const Column(
        children: [
          Icon(Icons.receipt_long_rounded, size: 40, color: Cores.tintaSuave), // ícone de recibo
          SizedBox(height: 12),
          Text('Nenhum lançamento ainda', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Cores.tinta)),
          SizedBox(height: 4),
          Text(
            'Toque em "Novo lançamento" para registrar\nseu primeiro gasto ou entrada.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Cores.tintaSuave, height: 1.4), // height = espaço entre linhas
          ),
        ],
      ),
    );
  }
}

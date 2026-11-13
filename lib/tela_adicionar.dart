// =====================================================================
// tela_adicionar.dart — FORMULÁRIO para criar um novo lançamento.
// Quando o usuário toca em "Salvar", esta tela fecha e devolve a
// Transacao criada para a tela inicial.
// =====================================================================

import 'package:flutter/services.dart'; // HapticFeedback: vibraçãozinha do celular
import 'package:material_ui/material_ui.dart'; // widgets visuais (Material Design)
import 'tema.dart'; // cores e ícones das categorias
import 'transacao.dart'; // classe Transacao e lista de categorias

// Stateful porque o formulário muda enquanto o usuário mexe
// (ex.: troca entre "Gasto" e "Entrada", escolhe outra categoria).
class TelaAdicionar extends StatefulWidget {
  const TelaAdicionar({super.key}); // construtor padrão

  @override
  State<TelaAdicionar> createState() => _TelaAdicionarState(); // cria o estado
}

class _TelaAdicionarState extends State<TelaAdicionar> {
  // Chave que dá acesso ao formulário inteiro (para validar todos os campos de uma vez).
  final _formKey = GlobalKey<FormState>();
  // Controllers guardam o texto digitado em cada campo.
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  bool _ehEntrada = false; // começa marcado como "Gasto"
  String _categoria = categorias.first; // começa na primeira categoria ("Alimentação")

  // dispose() roda quando a tela é fechada: liberamos a memória dos controllers.
  @override
  void dispose() {
    _descricaoController.dispose(); // libera o controller da descrição
    _valorController.dispose(); // libera o controller do valor
    super.dispose(); // deixa o Flutter terminar a limpeza dele
  }

  // Confere se o texto do campo "Valor" é um número maior que zero.
  // Devolve uma mensagem de erro, ou null se estiver tudo certo.
  String? _validarValor(String? texto) {
    final valor = double.tryParse((texto ?? '').replaceAll(',', '.')); // aceita "12,50"; tryParse devolve null se não for número
    if (valor == null || valor <= 0) return 'Digite um valor maior que zero'; // inválido: mostra o erro
    return null; // válido
  }

  // Chamado ao tocar em "Salvar".
  void _salvar() {
    if (!_formKey.currentState!.validate()) return; // roda todos os validadores; se algum falhar, para aqui
    final nova = Transacao( // monta a transação com o que foi preenchido
      descricao: _descricaoController.text.trim(), // trim() tira espaços sobrando nas pontas
      valor: double.parse(_valorController.text.replaceAll(',', '.')), // texto -> número (já validado)
      ehEntrada: _ehEntrada, // gasto ou entrada
      categoria: _categoria, // categoria escolhida
      data: DateTime.now(), // data e hora de agora
    );
    HapticFeedback.lightImpact(); // vibraçãozinha confirmando que salvou
    Navigator.pop(context, nova); // fecha esta tela e devolve "nova" para quem abriu
  }

  @override
  Widget build(BuildContext context) {
    final cor = _ehEntrada ? Cores.entrada : Cores.tinta; // o valor fica verde quando é entrada

    return Scaffold(
      appBar: AppBar(title: const Text('Novo lançamento')), // como abrimos com fullscreenDialog, aparece um "X" para fechar
      body: Form( // Form agrupa os campos para validar juntos
        key: _formKey, // liga o formulário à chave criada lá em cima
        child: ListView( // ListView permite rolar se o teclado cobrir a tela
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32), // espaço em volta do conteúdo
          children: [
            // Botão de duas opções: Gasto | Entrada
            SegmentedButton<bool>(
              showSelectedIcon: false, // não mostra o "✓" na opção marcada (fica mais limpo)
              segments: const [
                ButtonSegment(value: false, label: Text('Gasto'), icon: Icon(Icons.north_east_rounded)), // opção "false"
                ButtonSegment(value: true, label: Text('Entrada'), icon: Icon(Icons.south_west_rounded)), // opção "true"
              ],
              selected: {_ehEntrada}, // qual está marcado agora ({ } = conjunto com 1 item)
              onSelectionChanged: (escolha) => setState(() => _ehEntrada = escolha.first), // atualiza ao tocar
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: Cores.tinta, // opção marcada: fundo escuro (igual aos chips)
                selectedForegroundColor: Cores.superficie, // texto branco na opção marcada
                backgroundColor: Cores.superficie, // opção não marcada: fundo branco
                foregroundColor: Cores.tinta, // texto escuro na não marcada
                side: const BorderSide(color: Cores.linha), // contorno fininho
              ),
            ),
            const SizedBox(height: 32),

            // Campo do VALOR, bem grande: é a informação mais importante.
            // Alinhado à esquerda, igual ao saldo da tela inicial.
            TextFormField(
              controller: _valorController, // onde o texto fica guardado
              autofocus: true, // o teclado já abre aqui, sem precisar tocar no campo
              keyboardType: const TextInputType.numberWithOptions(decimal: true), // teclado numérico
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.w800, letterSpacing: -1, color: cor),
              decoration: const InputDecoration(
                filled: false, // sem fundo branco (só este campo)
                border: InputBorder.none, // sem borda
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: '0,00', // aparece em cinza enquanto está vazio
                hintStyle: TextStyle(color: Cores.tintaSuave), // cinza (legível, mas claramente "vazio")
                contentPadding: EdgeInsets.zero, // sem recuo: alinha com a margem da tela
                // prefixIcon fica SEMPRE visível (o prefixText só aparece com o campo selecionado).
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 8), // espaço entre "R$" e o número
                  child: Text('R\$', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Cores.tintaSuave)),
                ),
                prefixIconConstraints: BoxConstraints(), // deixa o "R$" ocupar só o tamanho dele
              ),
              validator: _validarValor, // usa a função de validação lá de cima
            ),
            const SizedBox(height: 32),

            // Campo de texto da descrição (o estilo vem do tema).
            TextFormField(
              controller: _descricaoController,
              textCapitalization: TextCapitalization.sentences, // primeira letra maiúscula automática
              decoration: const InputDecoration(hintText: 'Descrição (ex.: Almoço)'),
              validator: (texto) => (texto == null || texto.trim().isEmpty) ? 'Digite uma descrição' : null, // não pode ficar vazio
            ),
            const SizedBox(height: 28),

            // Categorias como "chips" (botõezinhos) em vez de lista suspensa:
            // o usuário vê todas as opções de uma vez e escolhe com um toque.
            const Text('Categoria', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Cores.tinta)),
            const SizedBox(height: 12),
            Wrap( // Wrap = coloca lado a lado e quebra a linha quando não cabe mais
              spacing: 8, // espaço horizontal entre chips
              runSpacing: 8, // espaço vertical entre linhas de chips
              children: [
                for (final c in categorias) // um chip para cada categoria
                  ChoiceChip(
                    label: Text(c),
                    avatar: Icon(iconesDasCategorias[c], size: 18), // ícone da categoria
                    selected: _categoria == c, // marcado se for a categoria escolhida
                    onSelected: (_) => setState(() => _categoria = c), // ao tocar, escolhe esta
                    showCheckmark: false, // sem "✓": o fundo escuro já mostra que está marcado
                    selectedColor: Cores.tinta, // fundo do chip marcado
                    backgroundColor: Cores.superficie, // fundo do chip normal
                    side: BorderSide.none, // sem contorno
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _categoria == c ? Cores.superficie : Cores.tinta, // texto branco no marcado
                    ),
                    iconTheme: IconThemeData(color: _categoria == c ? Cores.superficie : Cores.tintaSuave),
                  ),
              ],
            ),
            const SizedBox(height: 40),

            // Botão principal (o estilo vem do tema).
            FilledButton(
              onPressed: _salvar, // ao tocar, chama _salvar()
              child: const Text('Salvar lançamento'),
            ),
          ],
        ),
      ),
    );
  }
}

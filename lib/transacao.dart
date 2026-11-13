// =====================================================================
// transacao.dart — O "MODELO" do app.
// Aqui fica só a REGRA DE NEGÓCIO: o que é uma transação, como somar
// e como formatar. Não tem nada de tela aqui (nenhum import do Flutter),
// por isso dá para testar este arquivo sozinho.
// =====================================================================

// Lista fixa de categorias que aparecem no formulário.
// "const" = valor que nunca muda, criado uma vez só na compilação.
const List<String> categorias = [
  'Alimentação', // comida, mercado, lanche
  'Transporte', // ônibus, gasolina, Uber
  'Moradia', // aluguel, luz, água, internet
  'Lazer', // cinema, jogos, passeios
  'Estudos', // faculdade, livros, cursos
  'Salário', // dinheiro que entra do trabalho
  'Outros', // qualquer coisa que não se encaixa acima
];

// Uma CLASSE é um "molde". Cada Transacao é um lançamento:
// ex.: "Almoço, R$ 25,00, gasto, Alimentação, 13/11/2026".
class Transacao {
  // "final" = depois de criado, o valor do campo não pode ser trocado.
  final String descricao; // texto digitado pelo usuário, ex.: "Almoço"
  final double valor; // sempre positivo, ex.: 25.0
  final bool ehEntrada; // true = dinheiro entrando, false = gasto
  final String categoria; // uma das opções da lista "categorias"
  final DateTime data; // dia e hora em que foi lançada

  // CONSTRUTOR: função especial que cria um objeto Transacao.
  // "required" obriga quem cria a passar todos os campos.
  Transacao({
    required this.descricao, // "this.descricao" já guarda no campo acima
    required this.valor,
    required this.ehEntrada,
    required this.categoria,
    required this.data,
  });

  // Converte o objeto em um MAPA (chave -> valor).
  // Precisamos disso para transformar em texto JSON e salvar no celular.
  Map<String, dynamic> paraMapa() {
    return {
      'descricao': descricao, // String já é salvável
      'valor': valor, // double já é salvável
      'ehEntrada': ehEntrada, // bool já é salvável
      'categoria': categoria, // String já é salvável
      'data': data.toIso8601String(), // DateTime vira texto "2026-11-13T10:30:00"
    };
  }

  // "factory" é um construtor que monta o objeto a partir de outra coisa.
  // Aqui: recebe o mapa lido do celular e devolve uma Transacao.
  factory Transacao.deMapa(Map<String, dynamic> mapa) {
    return Transacao(
      descricao: mapa['descricao'], // pega o texto salvo
      valor: (mapa['valor'] as num).toDouble(), // JSON pode devolver 25 (int); garantimos double
      ehEntrada: mapa['ehEntrada'], // pega o true/false salvo
      categoria: mapa['categoria'], // pega a categoria salva
      data: DateTime.parse(mapa['data']), // texto "2026-11-13T..." volta a ser DateTime
    );
  }
}

// Soma os valores da lista. Se entrada for true, soma só as entradas;
// se for false, soma só os gastos.
double somar(List<Transacao> lista, {required bool entrada}) {
  double total = 0; // começa em zero
  for (final t in lista) { // passa por cada transação da lista
    if (t.ehEntrada == entrada) { // é do tipo que queremos?
      total += t.valor; // então soma no total
    }
  }
  return total; // devolve o resultado
}

// Transforma 1234.5 em "R$ 1.234,50" (padrão brasileiro).
String formatarDinheiro(double valor) {
  final sinal = valor < 0 ? '-' : ''; // se for negativo, guarda o "-"
  final partes = valor.abs().toStringAsFixed(2).split('.'); // abs() tira o sinal; "1234.50" vira ["1234", "50"]
  final inteiro = partes[0]; // parte antes da vírgula: "1234"
  String comPontos = ''; // vamos montar "1.234" letra por letra
  for (int i = 0; i < inteiro.length; i++) { // passa por cada dígito
    final faltam = inteiro.length - i; // quantos dígitos faltam até o fim
    if (i > 0 && faltam % 3 == 0) comPontos += '.'; // a cada 3 dígitos (contando do fim), põe um ponto
    comPontos += inteiro[i]; // adiciona o dígito
  }
  return '${sinal}R\$ $comPontos,${partes[1]}'; // junta: sinal + "R$ " + "1.234" + "," + "50"
}

// Transforma uma data em "13/11/2026".
String formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0'); // 5 vira "05"
  final mes = data.month.toString().padLeft(2, '0'); // 3 vira "03"
  return '$dia/$mes/${data.year}'; // junta tudo com barras
}

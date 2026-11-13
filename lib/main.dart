// =====================================================================
// main.dart — PONTO DE PARTIDA do app. É o primeiro arquivo executado.
// =====================================================================

// Importa a biblioteca de componentes visuais do Google (Material Design).
import 'package:material_ui/material_ui.dart';
// Importa a nossa tela inicial, que fica em outro arquivo.
import 'tela_inicial.dart';
// Importa o nosso tema (cores, fonte, botões).
import 'tema.dart';

// main() é a função que o Dart chama quando o app abre.
void main() {
  // runApp() coloca o widget MeuApp na tela do celular.
  runApp(const MeuApp());
}

// No Flutter, TUDO na tela é um WIDGET (texto, botão, tela inteira...).
// StatelessWidget = widget SEM estado: ele não muda sozinho depois de desenhado.
class MeuApp extends StatelessWidget {
  // Construtor. "super.key" repassa uma chave de identificação ao Flutter.
  const MeuApp({super.key});

  // build() diz ao Flutter COMO desenhar este widget.
  @override // estamos substituindo o build() que veio da classe pai
  Widget build(BuildContext context) {
    // MaterialApp é a "casca" do app: tema, título e primeira tela.
    return MaterialApp(
      title: 'Fold', // nome do app (aparece na aba do navegador e na lista de apps abertos)
      debugShowCheckedModeBanner: false, // esconde a faixa "DEBUG" no canto
      theme: criarTema(), // aparência definida em tema.dart
      home: const TelaInicial(), // primeira tela que aparece
      // builder "embrulha" todas as telas. Num computador (tela larga), o app
      // fica com no máximo 480 de largura, centralizado, como um celular.
      builder: (context, tela) => ColoredBox(
        color: Cores.fundo, // pinta as laterais com a cor de fundo do app
        child: Center( // centraliza na tela
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480), // largura máxima
            child: tela, // a tela atual (inicial ou formulário)
          ),
        ),
      ),
    );
  }
}

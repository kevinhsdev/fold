// =====================================================================
// tema.dart — A "IDENTIDADE VISUAL" do app em um lugar só.
// Cores, fonte, formato dos botões e dos campos. Se quiser mudar a cara
// do app inteiro, é aqui. As telas só USAM o que está definido aqui.
// =====================================================================

import 'package:material_ui/material_ui.dart'; // widgets e classes visuais

// Paleta de cores. "abstract final class" = só serve para agrupar
// constantes; ninguém cria um objeto "Cores".
abstract final class Cores {
  static const fundo = Color(0xFFF6F4EF); // off-white quente (fundo das telas)
  static const superficie = Color(0xFFFFFFFF); // branco (lista e campos)
  static const tinta = Color(0xFF17191C); // quase preto (texto principal e botão)
  static const tintaSuave = Color(0xFF6B6F76); // cinza (textos secundários)
  static const linha = Color(0xFFE7E3DA); // divisória fininha entre itens
  static const entrada = Color(0xFF1E7A52); // verde (dinheiro entrando)
  static const gasto = Color(0xFFB93A2B); // vermelho (dinheiro saindo, apagar)
}

// Um ícone para cada categoria. Map = dicionário: chave -> valor.
const Map<String, IconData> iconesDasCategorias = {
  'Alimentação': Icons.restaurant_rounded, // garfo e faca
  'Transporte': Icons.directions_bus_rounded, // ônibus
  'Moradia': Icons.home_rounded, // casa
  'Lazer': Icons.sports_esports_rounded, // controle de videogame
  'Estudos': Icons.school_rounded, // chapéu de formatura
  'Salário': Icons.payments_rounded, // notas de dinheiro
  'Outros': Icons.category_rounded, // formas genéricas
};

// Monta o tema (aparência padrão) que o MaterialApp usa em todas as telas.
ThemeData criarTema() {
  // Bordas arredondadas usadas nos campos de texto.
  final bordaCampo = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16), // cantos arredondados de 16
    borderSide: BorderSide.none, // sem linha em volta (o fundo branco já destaca)
  );

  return ThemeData(
    useMaterial3: true, // visual mais novo do Material Design
    fontFamily: 'Manrope', // nossa fonte (arquivos em assets/fonts)
    scaffoldBackgroundColor: Cores.fundo, // fundo de todas as telas
    colorScheme: ColorScheme.fromSeed(seedColor: Cores.entrada).copyWith(
      primary: Cores.tinta, // cor principal = quase preto (botões, seleção)
      onPrimary: Cores.superficie, // texto em cima da cor principal = branco
      surface: Cores.fundo, // cor das superfícies padrão
      error: Cores.gasto, // cor das mensagens de erro
    ),
    // Barra do topo: mesma cor do fundo, sem sombra, título centralizado.
    appBarTheme: const AppBarThemeData(
      backgroundColor: Cores.fundo,
      foregroundColor: Cores.tinta, // cor do texto e dos ícones da barra
      elevation: 0, // sem sombra
      scrolledUnderElevation: 0, // continua sem sombra ao rolar
      centerTitle: true,
      titleTextStyle: TextStyle(fontFamily: 'Manrope', fontSize: 17, fontWeight: FontWeight.w700, color: Cores.tinta),
    ),
    // Campos de texto: fundo branco, sem borda, cantos arredondados.
    inputDecorationTheme: InputDecorationThemeData(
      filled: true, // pinta o fundo do campo
      fillColor: Cores.superficie, // de branco
      border: bordaCampo, // borda normal
      enabledBorder: bordaCampo, // borda quando não está selecionado
      focusedBorder: bordaCampo.copyWith(borderSide: const BorderSide(color: Cores.tinta, width: 1.5)), // selecionado: contorno escuro
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18), // espaço interno
    ),
    // Botão principal: alto (56), bem arredondado, texto em negrito.
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56), // altura 56 e largura total
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: const TextStyle(fontFamily: 'Manrope', fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    // Aviso do rodapé (SnackBar): flutuante, escuro e arredondado.
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating, // flutua acima do conteúdo
      backgroundColor: Cores.tinta,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}

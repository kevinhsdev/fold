// =====================================================================
// widget_test.dart — TESTES AUTOMÁTICOS. Rode com: flutter test
// Um teste executa o código e confere se o resultado é o esperado.
// =====================================================================

import 'package:controle_gastos/main.dart'; // para abrir o app inteiro no teste
import 'package:controle_gastos/transacao.dart'; // modelo e funções que vamos testar
import 'package:flutter_test/flutter_test.dart'; // ferramentas de teste (test, expect...)
import 'package:shared_preferences/shared_preferences.dart'; // para simular o armazenamento

void main() {
  // Função auxiliar para criar transações de exemplo rapidinho.
  Transacao criar(double valor, bool entrada) => Transacao(
        descricao: 'Teste',
        valor: valor,
        ehEntrada: entrada,
        categoria: 'Outros',
        data: DateTime(2026, 11, 13),
      );

  test('soma entradas e gastos separadamente', () {
    final lista = [criar(1000, true), criar(25, false), criar(75, false)]; // 1 entrada, 2 gastos
    expect(somar(lista, entrada: true), 1000); // só a entrada
    expect(somar(lista, entrada: false), 100); // 25 + 75
  });

  test('salvar e carregar (mapa) não perde nenhum dado', () {
    final original = criar(12.5, false); // transação de exemplo
    final copia = Transacao.deMapa(original.paraMapa()); // vai para mapa e volta
    expect(copia.valor, 12.5); // valor igual
    expect(copia.ehEntrada, false); // tipo igual
    expect(copia.data, original.data); // data igual
  });

  test('formata dinheiro e data no padrão brasileiro', () {
    expect(formatarDinheiro(1234.5), 'R\$ 1.234,50'); // ponto no milhar, vírgula e 2 casas
    expect(formatarDinheiro(1234567), 'R\$ 1.234.567,00'); // milhão
    expect(formatarDinheiro(999), 'R\$ 999,00'); // menos de mil: sem ponto
    expect(formatarDinheiro(-50), '-R\$ 50,00'); // negativo
    expect(formatarData(DateTime(2026, 3, 5)), '05/03/2026'); // zeros à esquerda
  });

  testWidgets('app abre mostrando saldo zerado e lista vazia', (tester) async {
    SharedPreferences.setMockInitialValues({}); // finge um celular sem nada salvo
    await tester.pumpWidget(const MeuApp()); // desenha o app
    await tester.pumpAndSettle(); // espera terminar de carregar
    expect(find.text('Saldo atual'), findsOneWidget); // o saldo aparece
    expect(find.text('R\$ 0,00'), findsWidgets); // saldo, entradas e gastos começam em zero
    expect(find.textContaining('Nenhum lançamento'), findsOneWidget); // mensagem de lista vazia
  });
}

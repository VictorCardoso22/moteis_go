import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moteis_go/ir_agora/ir_agora_viewmodel.dart';
import 'package:moteis_go/model/data_model.dart';

@GenerateMocks([http.Client])
void main() {
  group('Testes para IrAgoraViewmodel', () {
    late IrAgoraViewmodel viewModel;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((http.Request request) async {
        // Mock da resposta da API
        return http.Response('''
        ''', 200);
      });

      viewModel = IrAgoraViewmodel();
    });

    test('Teste de carregamento de dados com sucesso', () async {
      // Substitui o client HTTP pelo mock
      viewModel = IrAgoraViewmodel();

      // Simula a resposta da API
      await viewModel.fetchData();

      // Verifica se o carregamento foi bem sucedido
      expect(viewModel.moteis.length, 1);
      expect(viewModel.moteis[0].fantasia, "Motel Le Nid");
      expect(viewModel.isLoading, false);
    });

    test('Teste da função getIcons', () {
      // Criando uma lista de categoriaItens para testar
      final categoriaItens = [
        CategoriaIten(icone: "https://exemplo.com/icone1.png", nome: ''),
        CategoriaIten(icone: "https://exemplo.com/icone2.png", nome: ''),
      ];

      // Chamando o método getIcons
      final result = viewModel.getIcons(categoriaItens);

      // Verificando se o retorno é um Card
      expect(result, isA<Card>());
    });

    test('Teste da função getPeriodos', () {
      final periodos = [
        Periodo(
            tempoFormatado: "2 horas",
            valorTotal: 100.00,
            tempo: '2',
            temCortesia: false,
            valor: 100.00,
            desconto: null),
        Periodo(
            tempoFormatado: "4 horas",
            valorTotal: 200.00,
            tempo: '4',
            temCortesia: false,
            valor: 200.00,
            desconto: null),
      ];

      final result = viewModel.getPeriodos(periodos);

      // Verificando se cada item da lista é um Card
      for (var item in result) {
        expect(item, isA<Card>());
      }
      expect(result.length, 2);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moteis_go/ir_agora/ir_agora_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'package:moteis_go/model/data_model.dart';
import 'dart:convert';

import 'ir_agora_viewmodel_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("IrAgoraViewmodel Tests", () {
    late IrAgoraViewmodel viewModel;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      viewModel = IrAgoraViewmodel(client: mockClient); // Passamos o mock aqui
    });

    test("Deve inicializar com isLoading como true", () {
      expect(viewModel.isLoading, true);
    });

    test("Deve carregar dados corretamente", () async {
      final mockResponse = {
        "data": {
          "moteis": [
            {"fantasia": "Motel Teste", "endereco": "Rua X, 123"}
          ]
        }
      };

      when(mockClient.get(
        any,
        headers: {
          "Accept": "application/json",
          "User-Agent": "Flutter-App",
          "Content-Type": "application/json; charset=UTF-8",
        },
      )).thenAnswer((_) async => http.Response(json.encode(mockResponse), 200));

      await viewModel.fetchData();

      expect(viewModel.isLoading, false);
      expect(viewModel.moteis.isNotEmpty, true);
      expect(viewModel.moteis.first.fantasia, "Motel Teste");
    });

    test("Deve lidar com erro na requisição", () async {
      when(mockClient.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response("Erro", 500));

      await viewModel.fetchData();

      expect(viewModel.isLoading, true);
      expect(viewModel.moteis.isEmpty, true);
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

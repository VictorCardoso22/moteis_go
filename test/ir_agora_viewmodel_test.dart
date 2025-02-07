import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moteis_go/ir_agora/ir_agora_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'package:moteis_go/model/data_model.dart';
import 'package:moteis_go/services/motel_service.dart';
import 'dart:convert';

import 'ir_agora_viewmodel_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("IrAgoraViewmodel Tests", () {
    late IrAgoraViewmodel viewModel;
    late MockClient mockClient;
    late MotelService motelService;

    setUp(() {
      mockClient = MockClient();
      motelService = MotelService(client: mockClient);
      viewModel = IrAgoraViewmodel(motelService);
    });
    test("Deve inicializar com isLoading como true", () {
      final vm = IrAgoraViewmodel(MotelService(client: mockClient));
      expect(vm.isLoading, true);
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
        headers: anyNamed("headers"),
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

      expect(viewModel.isLoading, false);
      expect(viewModel.moteis.isEmpty, true);
    });

    test('Teste da função getIcons', () {
      final categoriaItens = [
        CategoriaIten(icone: "https://exemplo.com/icone1.png", nome: ''),
        CategoriaIten(icone: "https://exemplo.com/icone2.png", nome: ''),
      ];

      final result = viewModel.getIcons(categoriaItens);

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

      for (var item in result) {
        expect(item, isA<Card>());
      }
      expect(result.length, 2);
    });
  });
}

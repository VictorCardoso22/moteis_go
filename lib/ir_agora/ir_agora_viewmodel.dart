import 'package:moteis_go/model/data_model.dart';
import 'package:stacked/stacked.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IrAgoraViewmodel extends BaseViewModel {
  List<Moteis> moteis = [];
  bool isLoading = true;

  IrAgoraViewmodel() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    const url = "https://www.jsonkeeper.com/b/1IXK";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "User-Agent": "Flutter-App",
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        var correctedBody = utf8.decode(latin1.encode(response.body));

        var jsonBody = json.decode(correctedBody);

        DataModel dataModel = DataModel.fromJson(jsonBody);

        moteis = dataModel.data?.moteis ?? [];

        isLoading = false;
      } else {
        throw Exception("Erro ao carregar dados: ${response.statusCode}");
      }
    } catch (e) {
      isLoading = false;
      print("Erro: $e");
    }

    notifyListeners();
  }

  getIcons(List<CategoriaIten> categoriaItens) {
    List icones = [];
    categoriaItens.forEach((element) {
      icones.add(element.icone.isNotEmpty
          ? Image.network(element.icone,
              width: 46, height: 46, fit: BoxFit.cover)
          : const Icon(Icons.image_not_supported));
    });
    return icones;
  }

  getPeriodos(List<Periodo> periodoList) {
    List periodos = [];
    for (var element in periodoList) {
      periodos.add(Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(element.tempoFormatado),
                  Text("R\$ ${element.valorTotal}"),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ],
          ),
        ),
      ));
    }

    return periodos;
  }
}

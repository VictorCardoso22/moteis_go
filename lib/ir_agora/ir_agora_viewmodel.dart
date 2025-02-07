import 'package:moteis_go/model/data_model.dart';
import 'package:stacked/stacked.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class IrAgoraViewmodel extends BaseViewModel {
  List<Moteis> moteis = [];
  bool isLoading = true;
  final http.Client? client;

  IrAgoraViewmodel({http.Client? client}) : client = client ?? http.Client() {
    fetchData();
  }

  Future<void> fetchData() async {
    const url = "https://www.jsonkeeper.com/b/1IXK";
    try {
      final response = await client!.get(
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
      isLoading = true;
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icones.length >= 4) ...icones.take(4) else ...icones,
            TextButton.icon(
                iconAlignment: IconAlignment.end,
                label: Text(
                  "ver todos",
                  style: TextStyle(
                    color: Color(0xFFA1A1A2),
                  ),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Color(0xFFA1A1A2),
                ))
          ],
        ),
      ),
    );
  }

  getPeriodos(List<Periodo> periodoList) {
    List periodos = [];
    for (var element in periodoList) {
      periodos.add(Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Color(0xFF838383),
                  )),
            ],
          ),
        ),
      ));
    }

    return periodos;
  }
}

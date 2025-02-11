import 'package:moteis_go/model/data_model.dart';
import 'package:moteis_go/services/motel_service.dart';
import 'package:stacked/stacked.dart';


import 'package:flutter/material.dart';

class IrAgoraViewmodel extends BaseViewModel {
  final MotelService _motelService;
  List<Moteis> moteis = [];
  bool isLoading = true;

  IrAgoraViewmodel(this._motelService) {
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    try {
      moteis = await _motelService.fetchMoteis();
      isLoading = false;
    } catch (e) {
      print("Erro ao buscar dados: $e");
      isLoading = false;
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  getIcons(List<CategoriaIten> categoriaItens) {
    List icones = [];
    for (var element in categoriaItens) {
      icones.add(element.icone.isNotEmpty
          ? Image.network(element.icone,
              width: 46, height: 46, fit: BoxFit.cover)
          : const Icon(Icons.image_not_supported));
    }
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

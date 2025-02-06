import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:moteis_go/ir_agora/ir_agora_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../model/data_model.dart';

class IrAgora extends StatefulWidget {
  const IrAgora({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<IrAgora> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IrAgoraViewmodel>.reactive(
      viewModelBuilder: () => IrAgoraViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Lista de Motéis")),
          body: model.isLoading
              ? const Center(child: CircularProgressIndicator())
              : model.moteis.isEmpty
                  ? const Center(child: Text("Nenhum motel encontrado"))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height,
                            child: ListView.builder(
                              itemCount: model.moteis.length,
                              itemBuilder: (context, index) {
                                final motel = model.moteis[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          motel.logo.isNotEmpty
                                              ? Image.network(motel.logo,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover)
                                              : const Icon(
                                                  Icons.image_not_supported),
                                          Column(
                                            children: [
                                              Text(motel.fantasia),
                                              Text("${motel.bairro}"),
                                              Text(
                                                  "⭐ ${motel.media.toStringAsFixed(1)}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 800,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        // physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: motel.suites.length,
                                        itemBuilder: (context, index) {
                                          final suite = motel.suites[index];
                                          return Container(
                                            margin: const EdgeInsets.all(8),
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              spacing: 8,
                                              children: [
                                                Card(
                                                  color: Colors.white,
                                                  child: Column(
                                                    children: [
                                                      suite.fotos.isNotEmpty
                                                          ? Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(12),
                                                              height: 260,
                                                              child: Image.network(
                                                                  suite
                                                                      .fotos[0],
                                                                  fit: BoxFit
                                                                      .fitWidth),
                                                            )
                                                          : const Icon(Icons
                                                              .image_not_supported),
                                                      Text(suite.nome),
                                                    ],
                                                  ),
                                                ),
                                                // Card(
                                                //   color: Colors.white,
                                                //   child: Padding(
                                                //     padding: EdgeInsets.all(12),
                                                //     child: Row(
                                                //       mainAxisAlignment:
                                                //           MainAxisAlignment
                                                //               .center,
                                                //       mainAxisSize:
                                                //           MainAxisSize.max,
                                                //       children: [
                                                model.getIcons(
                                                    suite.categoriaItens),
                                                //       ],
                                                //     ),
                                                //   ),
                                                // ),
                                                ...model.getPeriodos(
                                                    suite.periodos),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moteis_go/components/appbar/custom_appbar.dart';
import 'package:moteis_go/components/drawer/custom_drawer.dart';
import 'package:moteis_go/ir_agora/ir_agora_viewmodel.dart';
import 'package:moteis_go/services/motel_service.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class IrAgora extends StatefulWidget {
  const IrAgora({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<IrAgora> {
  String activeButton = 'ir agora';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isSelected = true;

  void handleToggle(String button) {
    setState(() {
      activeButton = button;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IrAgoraViewmodel>.reactive(
      viewModelBuilder: () =>
          IrAgoraViewmodel(MotelService(client: http.Client())),
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xFFD11621),
          appBar: CustomAppBar(
            location: 'zona norte',
            activeButton: activeButton,
            onToggle: handleToggle,
            scaffoldKey: _scaffoldKey,
          ),
          drawer: CustomDrawer(buildContext: context),
          body: model.isLoading
              ? const Center(child: CircularProgressIndicator())
              : model.moteis.isEmpty
                  ? const Center(child: Text("Nenhum motel encontrado"))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                            ),
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
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Row(
                                              spacing: 12,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                motel.logo.isNotEmpty
                                                    ? ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        child: Image.network(
                                                          motel.logo,
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                    : const Icon(Icons
                                                        .image_not_supported),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      motel.fantasia,
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xFF5A5B5D)),
                                                    ),
                                                    Text(
                                                      motel.bairro,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFF5A5B5D),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 8),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: Color(
                                                                0xFFFFB909),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFFFFB909),
                                                          ),
                                                          Text(motel.media
                                                              .toStringAsFixed(
                                                                  1)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isSelected == false
                                                          ? isSelected = true
                                                          : isSelected = false;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    size: 34,
                                                  ),
                                                  color: isSelected
                                                      ? Color(0xFFC2C2C2)
                                                      : Color(0xFFB8000C),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 800,
                                            padding: EdgeInsets.only(left: 12),
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: motel.suites.length,
                                              itemBuilder: (context, index) {
                                                final suite =
                                                    motel.suites[index];
                                                return Container(
                                                  padding:
                                                      EdgeInsets.only(right: 4),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Card(
                                                        color: Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                        ),
                                                        elevation: 0,
                                                        child: Column(
                                                          children: [
                                                            suite.fotos
                                                                    .isNotEmpty
                                                                ? Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            12),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      child: Image.network(
                                                                          suite.fotos[
                                                                              0],
                                                                          fit: BoxFit
                                                                              .fitWidth),
                                                                    ),
                                                                  )
                                                                : const Icon(Icons
                                                                    .image_not_supported),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 8,
                                                                      bottom:
                                                                          20.0),
                                                              child: Text(
                                                                suite.nome,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                      0xFF494949),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      model.getIcons(
                                                          suite.categoriaItens),
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
                        ],
                      ),
                    ),
        );
      },
    );
  }
}

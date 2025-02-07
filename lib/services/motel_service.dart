import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moteis_go/model/data_model.dart';

class MotelService {
  final String url = "https://www.jsonkeeper.com/b/1IXK";
  final http.Client client;

  MotelService({required this.client});

  Future<List<Moteis>> fetchMoteis() async {
    try {
      final response = await client.get(
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
        return dataModel.data?.moteis ?? [];
      } else {
        throw Exception("Erro ao carregar dados: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro: $e");
      throw Exception("Erro ao buscar motéis");
    }
  }
}

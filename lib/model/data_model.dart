class DataModel {
  DataModel({
    required this.sucesso,
    required this.data,
    required this.mensagem,
  });

  final bool sucesso;
  final Data? data;
  final List<dynamic> mensagem;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      sucesso: json["sucesso"] ?? false,
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      mensagem: json["mensagem"] == null
          ? []
          : List<dynamic>.from(json["mensagem"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "sucesso": sucesso,
        "data": data?.toJson(),
        "mensagem": mensagem.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$sucesso, $data, $mensagem, ";
  }
}

class Data {
  Data({
    required this.pagina,
    required this.qtdPorPagina,
    required this.totalSuites,
    required this.totalMoteis,
    required this.raio,
    required this.maxPaginas,
    required this.moteis,
  });

  final int pagina;
  final int qtdPorPagina;
  final int totalSuites;
  final int totalMoteis;
  final int raio;
  final double maxPaginas;
  final List<Moteis> moteis;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      pagina: json["pagina"] ?? 0,
      qtdPorPagina: json["qtdPorPagina"] ?? 0,
      totalSuites: json["totalSuites"] ?? 0,
      totalMoteis: json["totalMoteis"] ?? 0,
      raio: json["raio"] ?? 0,
      maxPaginas: json["maxPaginas"] ?? 0,
      moteis: json["moteis"] == null
          ? []
          : List<Moteis>.from(json["moteis"]!.map((x) => Moteis.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "pagina": pagina,
        "qtdPorPagina": qtdPorPagina,
        "totalSuites": totalSuites,
        "totalMoteis": totalMoteis,
        "raio": raio,
        "maxPaginas": maxPaginas,
        "moteis": moteis.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$pagina, $qtdPorPagina, $totalSuites, $totalMoteis, $raio, $maxPaginas, $moteis, ";
  }
}

class Moteis {
  Moteis({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.suites,
    required this.qtdAvaliacoes,
    required this.media,
  });

  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int qtdFavoritos;
  final List<Suite> suites;
  final int qtdAvaliacoes;
  final double media;

  factory Moteis.fromJson(Map<String, dynamic> json) {
    return Moteis(
      fantasia: json["fantasia"] ?? "",
      logo: json["logo"] ?? "",
      bairro: json["bairro"] ?? "",
      distancia: json["distancia"] ?? 0.0,
      qtdFavoritos: json["qtdFavoritos"] ?? 0,
      suites: json["suites"] == null
          ? []
          : List<Suite>.from(json["suites"]!.map((x) => Suite.fromJson(x))),
      qtdAvaliacoes: json["qtdAvaliacoes"] ?? 0,
      media: json["media"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "fantasia": fantasia,
        "logo": logo,
        "bairro": bairro,
        "distancia": distancia,
        "qtdFavoritos": qtdFavoritos,
        "suites": suites.map((x) => x.toJson()).toList(),
        "qtdAvaliacoes": qtdAvaliacoes,
        "media": media,
      };

  @override
  String toString() {
    return "$fantasia, $logo, $bairro, $distancia, $qtdFavoritos, $suites, $qtdAvaliacoes, $media, ";
  }
}

class Suite {
  Suite({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<Iten> itens;
  final List<CategoriaIten> categoriaItens;
  final List<Periodo> periodos;

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      nome: json["nome"] ?? "",
      qtd: json["qtd"] ?? 0,
      exibirQtdDisponiveis: json["exibirQtdDisponiveis"] ?? false,
      fotos: json["fotos"] == null
          ? []
          : List<String>.from(json["fotos"]!.map((x) => x)),
      itens: json["itens"] == null
          ? []
          : List<Iten>.from(json["itens"]!.map((x) => Iten.fromJson(x))),
      categoriaItens: json["categoriaItens"] == null
          ? []
          : List<CategoriaIten>.from(
              json["categoriaItens"]!.map((x) => CategoriaIten.fromJson(x))),
      periodos: json["periodos"] == null
          ? []
          : List<Periodo>.from(
              json["periodos"]!.map((x) => Periodo.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "qtd": qtd,
        "exibirQtdDisponiveis": exibirQtdDisponiveis,
        "fotos": fotos.map((x) => x).toList(),
        "itens": itens.map((x) => x.toJson()).toList(),
        "categoriaItens": categoriaItens.map((x) => x.toJson()).toList(),
        "periodos": periodos.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$nome, $qtd, $exibirQtdDisponiveis, $fotos, $itens, $categoriaItens, $periodos, ";
  }
}

class CategoriaIten {
  CategoriaIten({
    required this.nome,
    required this.icone,
  });

  final String nome;
  final String icone;

  factory CategoriaIten.fromJson(Map<String, dynamic> json) {
    return CategoriaIten(
      nome: json["nome"] ?? "",
      icone: json["icone"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "icone": icone,
      };

  @override
  String toString() {
    return "$nome, $icone, ";
  }
}

class Iten {
  Iten({
    required this.nome,
  });

  final String nome;

  factory Iten.fromJson(Map<String, dynamic> json) {
    return Iten(
      nome: json["nome"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "nome": nome,
      };

  @override
  String toString() {
    return "$nome, ";
  }
}

class Periodo {
  Periodo({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    required this.desconto,
  });

  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final Desconto? desconto;

  factory Periodo.fromJson(Map<String, dynamic> json) {
    return Periodo(
      tempoFormatado: json["tempoFormatado"] ?? "",
      tempo: json["tempo"] ?? "",
      valor: json["valor"] ?? 0.0,
      valorTotal: json["valorTotal"] ?? 0.0,
      temCortesia: json["temCortesia"] ?? false,
      desconto:
          json["desconto"] == null ? null : Desconto.fromJson(json["desconto"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "tempoFormatado": tempoFormatado,
        "tempo": tempo,
        "valor": valor,
        "valorTotal": valorTotal,
        "temCortesia": temCortesia,
        "desconto": desconto?.toJson(),
      };

  @override
  String toString() {
    return "$tempoFormatado, $tempo, $valor, $valorTotal, $temCortesia, $desconto, ";
  }
}

class Desconto {
  Desconto({
    required this.desconto,
  });

  final double desconto;

  factory Desconto.fromJson(Map<String, dynamic> json) {
    return Desconto(
      desconto: json["desconto"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "desconto": desconto,
      };

  @override
  String toString() {
    return "$desconto, ";
  }
}

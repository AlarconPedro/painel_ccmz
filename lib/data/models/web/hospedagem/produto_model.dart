class ProdutoModel {
  int proCodigo;
  String proNome;
  String proCodBarras;
  double proValor;
  String proMedida;
  String proUniMedida;
  int proQuantidade;
  int catCodigo;
  String proDescricao;

  ProdutoModel({
    required this.proCodigo,
    required this.proNome,
    required this.proCodBarras,
    required this.proValor,
    required this.proMedida,
    required this.proUniMedida,
    required this.proQuantidade,
    required this.catCodigo,
    required this.proDescricao,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      proCodigo: json['proCodigo'] ?? 0,
      proNome: json['proNome'] ?? '',
      proCodBarras: json['proCodBarras'] ?? '',
      proValor: json['proValor'] ?? 0.0,
      proMedida: json['proMedida'] ?? '',
      proUniMedida: json['proUniMedida'] ?? '',
      proQuantidade: json['proQuantidade'] ?? 0,
      catCodigo: json['catCodigo'] ?? 0,
      proDescricao: json['proDescricao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'proCodigo': proCodigo ?? 0,
      'proNome': proNome ?? '',
      'proCodBarras': proCodBarras ?? '',
      'proValor': proValor ?? 0.0,
      'proMedida': proMedida ?? '',
      'proUniMedida': proUniMedida ?? '',
      'proQuantidade': proQuantidade ?? 0,
      'catCodigo': catCodigo ?? 0,
      'proDescricao': proDescricao ?? '',
    };
  }
}

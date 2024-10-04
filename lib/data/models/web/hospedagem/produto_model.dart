class ProdutoModel {
  int proCodigo;
  String proNome;
  String proCodBarras;
  String proImagem;
  double proValor;
  String proMedida;
  String proUniMedida;
  int proQuantidade;
  int proQuantidadeMinima;
  int catCodigo;
  String proDescricao;

  ProdutoModel({
    required this.proCodigo,
    required this.proNome,
    required this.proCodBarras,
    required this.proImagem,
    required this.proValor,
    required this.proMedida,
    required this.proUniMedida,
    required this.proQuantidade,
    required this.proQuantidadeMinima,
    required this.catCodigo,
    required this.proDescricao,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      proCodigo: json['proCodigo'] ?? 0,
      proNome: json['proNome'] ?? '',
      proCodBarras: json['proCodBarras'] ?? '',
      proImagem: json['proImagem'] ?? '',
      proValor: json['proValor'] ?? 0.0,
      proMedida: json['proMedida'] ?? '',
      proUniMedida: json['proUniMedida'] ?? '',
      proQuantidade: json['proQuantidade'] ?? 0,
      proQuantidadeMinima: json['proQuantidadeMin'] ?? 0,
      catCodigo: json['catCodigo'] ?? 0,
      proDescricao: json['proDescricao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'proCodigo': proCodigo ?? 0,
      'proNome': proNome ?? '',
      'proCodBarras': proCodBarras ?? '',
      'proImagem': proImagem ?? '',
      'proValor': proValor ?? 0.0,
      'proMedida': proMedida ?? '',
      'proUniMedida': proUniMedida ?? '',
      'proQuantidade': proQuantidade ?? 0,
      'proQuantidadeMin': proQuantidadeMinima ?? 0,
      'catCodigo': catCodigo ?? 0,
      'proDescricao': proDescricao ?? '',
    };
  }
}

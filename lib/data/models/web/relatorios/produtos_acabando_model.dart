class ProdutosAcabandoModel {
  int proCodigo;
  String proNome;
  String proImagem;
  double proValor;
  String proMedida;
  String proUniMedida;
  int proQuantidade;
  String proDescricao;

  ProdutosAcabandoModel({
    required this.proCodigo,
    required this.proNome,
    required this.proImagem,
    required this.proValor,
    required this.proMedida,
    required this.proUniMedida,
    required this.proQuantidade,
    required this.proDescricao,
  });

  factory ProdutosAcabandoModel.fromJson(Map<String, dynamic> json) {
    return ProdutosAcabandoModel(
      proCodigo: json['proCodigo'] ?? 0,
      proNome: json['proNome'] ?? '',
      proImagem: json['proImagem'] ?? '',
      proValor: json['proValor'] ?? 0.0,
      proMedida: json['proMedida'] ?? '',
      proUniMedida: json['proUniMedida'] ?? '',
      proQuantidade: json['proQuantidade'] ?? 0,
      proDescricao: json['proDescricao'] ?? '',
    );
  }
}

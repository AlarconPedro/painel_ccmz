class PromocoesModel {
  int proCodigo;
  String proNome;
  String proDataInicio;
  String proDataFim;
  String proDescricao;

  PromocoesModel({
    required this.proCodigo,
    required this.proNome,
    required this.proDataInicio,
    required this.proDataFim,
    required this.proDescricao,
  });

  factory PromocoesModel.fromJson(Map<String, dynamic> json) {
    return PromocoesModel(
      proCodigo: json['proCodigo'],
      proNome: json['proNome'],
      proDataInicio: json['proDataInicio'],
      proDataFim: json['proDataFim'],
      proDescricao: json['proDescricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'proCodigo': proCodigo,
      'proNome': proNome,
      'proDataInicio': proDataInicio,
      'proDataFim': proDataFim,
      'proDescricao': proDescricao,
    };
  }
}

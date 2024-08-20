class PromocaoModel {
  int proCodigo;
  String proNome;
  String proDataInicio;
  String proDataFim;
  String proDescricao;

  PromocaoModel({
    required this.proCodigo,
    required this.proNome,
    required this.proDataInicio,
    required this.proDataFim,
    required this.proDescricao,
  });

  factory PromocaoModel.fromMap(Map<String, dynamic> map) {
    return PromocaoModel(
      proCodigo: map['proCodigo'],
      proNome: map['proNome'],
      proDataInicio: map['proDataInicio'],
      proDataFim: map['proDataFim'],
      proDescricao: map['proDescricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proCodigo': proCodigo,
      'proNome': proNome,
      'proDataInicio': proDataInicio,
      'proDataFim': proDataFim,
      'proDescricao': proDescricao,
    };
  }
}

class PremiosModel {
  int preCodigo;
  String preNome;
  String preDescricao;
  String proNome;
  int proCodigo;

  PremiosModel({
    required this.preCodigo,
    required this.preNome,
    required this.preDescricao,
    required this.proNome,
    required this.proCodigo,
  });

  factory PremiosModel.fromJson(Map<String, dynamic> json) {
    return PremiosModel(
      preCodigo: json['preCodigo'],
      preNome: json['preNome'],
      preDescricao: json['preDescricao'],
      proNome: json['proNome'],
      proCodigo: json['proCodigo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'preCodigo': preCodigo,
      'preNome': preNome,
      'preDescricao': preDescricao,
      'proNome': proNome,
      'proCodigo': proCodigo,
    };
  }
}

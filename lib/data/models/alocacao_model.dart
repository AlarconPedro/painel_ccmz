class AlocacaoModel {
  int qupCodigo;
  int pesCodigo;
  int quaCodigo;

  AlocacaoModel({
    required this.qupCodigo,
    required this.pesCodigo,
    required this.quaCodigo,
  });

  factory AlocacaoModel.fromJson(Map<String, dynamic> json) => AlocacaoModel(
        qupCodigo: json["qupCodigo"],
        pesCodigo: json["pesCodigo"],
        quaCodigo: json["quaCodigo"],
      );

  Map<String, dynamic> toJson() => {
        "qupCodigo": qupCodigo,
        "pesCodigo": pesCodigo,
        "quaCodigo": quaCodigo,
      };
}

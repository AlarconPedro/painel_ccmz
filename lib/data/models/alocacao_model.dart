class AlocacaoModel {
  int qupCodigo;
  int pesCodigo;
  int quaCodigo;
  bool pesChave;
  bool pesCheckin;

  AlocacaoModel({
    required this.qupCodigo,
    required this.pesCodigo,
    required this.quaCodigo,
    required this.pesChave,
    required this.pesCheckin,
  });

  factory AlocacaoModel.fromJson(Map<String, dynamic> json) => AlocacaoModel(
        qupCodigo: json["qupCodigo"],
        pesCodigo: json["pesCodigo"],
        quaCodigo: json["quaCodigo"],
        pesChave: json["pesChave"],
        pesCheckin: json["pesCheckin"],
      );

  Map<String, dynamic> toJson() => {
        "qupCodigo": qupCodigo,
        "pesCodigo": pesCodigo,
        "quaCodigo": quaCodigo,
        "pesChave": pesChave,
        "pesCheckin": pesCheckin,
      };
}

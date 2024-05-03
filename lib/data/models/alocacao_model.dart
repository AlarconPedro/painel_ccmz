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
        qupCodigo: json["qupCodigo"] ?? 0,
        pesCodigo: json["pesCodigo"] ?? 0,
        quaCodigo: json["quaCodigo"] ?? 0,
        pesChave: json["pesChave"] ?? false,
        pesCheckin: json["pesCheckin"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "qupCodigo": qupCodigo ?? 0,
        "pesCodigo": pesCodigo ?? 0,
        "quaCodigo": quaCodigo ?? 0,
        "pesChave": pesChave ?? false,
        "pesCheckin": pesCheckin ?? false,
      };
}

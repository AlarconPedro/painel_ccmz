class CheckinModel {
  int qupCodigo;
  int pesCodigo;
  int quaCodigo;
  int eveCodigo;
  bool pesChave;
  bool pesCheckin;
  bool pesNaovem;
  String pesNome;

  CheckinModel({
    required this.qupCodigo,
    required this.pesCodigo,
    required this.quaCodigo,
    required this.eveCodigo,
    required this.pesChave,
    required this.pesCheckin,
    required this.pesNaovem,
    required this.pesNome,
  });

  factory CheckinModel.fromJson(Map<String, dynamic> json) => CheckinModel(
        qupCodigo: json["qupCodigo"] ?? 0,
        pesCodigo: json["pesCodigo"] ?? 0,
        quaCodigo: json["quaCodigo"] ?? 0,
        eveCodigo: json["eveCodigo"] ?? 0,
        pesChave: json["pesChave"] ?? false,
        pesCheckin: json["pesCheckin"] ?? false,
        pesNaovem: json["pesNaovem"] ?? false,
        pesNome: json["pesNome"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "qupCodigo": qupCodigo,
        "pesCodigo": pesCodigo,
        "quaCodigo": quaCodigo,
        "eveCodigo": eveCodigo,
        "pesChave": pesChave,
        "pesCheckin": pesCheckin,
        "pesNaovem": pesNaovem,
      };
}

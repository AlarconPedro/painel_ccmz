class CheckinModel {
  int qupCodigo;
  int pesCodigo;
  bool pesChave;
  bool pesCheckin;
  String pesNome;

  CheckinModel({
    required this.qupCodigo,
    required this.pesCodigo,
    required this.pesChave,
    required this.pesCheckin,
    required this.pesNome,
  });

  factory CheckinModel.fromJson(Map<String, dynamic> json) => CheckinModel(
        qupCodigo: json["qupCodigo"] ?? 0,
        pesCodigo: json["pesCodigo"] ?? 0,
        pesChave: json["pesChave"] ?? false,
        pesCheckin: json["pesCheckin"] ?? false,
        pesNome: json["pesNome"] ?? "",
      );
}

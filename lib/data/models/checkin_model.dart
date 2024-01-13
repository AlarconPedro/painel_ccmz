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
        qupCodigo: json["qupCodigo"],
        pesCodigo: json["pesCodigo"],
        pesChave: json["pesChave"],
        pesCheckin: json["pesCheckin"],
        pesNome: json["pesNome"],
      );
}

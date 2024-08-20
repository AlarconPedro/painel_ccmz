class BlocoModel {
  int bloCodigo;
  String bloNome;
  int qtdQuartos;
  int qtdLivres;
  int qtdOcupados;

  BlocoModel({
    required this.bloCodigo,
    required this.bloNome,
    required this.qtdQuartos,
    required this.qtdLivres,
    required this.qtdOcupados,
  });

  factory BlocoModel.fromJson(Map<String, dynamic> json) => BlocoModel(
        bloCodigo: json["bloCodigo"] ?? 0,
        bloNome: json["bloNome"] ?? "",
        qtdQuartos: json["qtdQuartos"] ?? 0,
        qtdLivres: json["qtdLivres"] ?? 0,
        qtdOcupados: json["qtdOcupados"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "bloCodigo": bloCodigo,
        "bloNome": bloNome,
      };
}

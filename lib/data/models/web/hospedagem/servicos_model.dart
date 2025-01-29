class ServicosModel {
  int serCodigo;
  String serNome;

  ServicosModel({
    required this.serCodigo,
    required this.serNome,
  });

  factory ServicosModel.fromJson(Map<String, dynamic> json) => ServicosModel(
        serCodigo: json['serCodigo'],
        serNome: json['serNome'],
      );

  Map<String, dynamic> toJson() => {
        'serCodigo': serCodigo,
        'serNome': serNome,
      };
}

class ServicosModel {
  int serCodigo;
  String serNome;

  ServicosModel({
    required this.serCodigo,
    required this.serNome,
  });

  factory ServicosModel.fromJson(Map<String, dynamic> json) {
    return ServicosModel(
      serCodigo: json['serCodigo'],
      serNome: json['serNome'],
    );
  }
}

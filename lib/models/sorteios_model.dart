class SorteiosModel {
  int sorCodigo;
  String sorNome;
  String sorData;
  String sorNomeGanhador;

  SorteiosModel({
    required this.sorCodigo,
    required this.sorNome,
    required this.sorData,
    required this.sorNomeGanhador,
  });

  factory SorteiosModel.fromJson(Map<String, dynamic> json) {
    return SorteiosModel(
      sorCodigo: json['sor_codigo'],
      sorNome: json['sor_nome'],
      sorData: json['sor_data'],
      sorNomeGanhador: json['sor_nome_ganhador'],
    );
  }
}

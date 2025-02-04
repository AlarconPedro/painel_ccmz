class ServicoEventoModel {
  int serCodigo;
  String serNome;
  double serValor;
  int serQuantidade;

  ServicoEventoModel({
    required this.serCodigo,
    required this.serNome,
    required this.serValor,
    required this.serQuantidade,
  });

  factory ServicoEventoModel.fromJson(Map<String, dynamic> json) {
    return ServicoEventoModel(
      serCodigo: json['serCodigo'],
      serNome: json['serNome'],
      serValor: json['serValor'],
      serQuantidade: json['serQuantidade'],
    );
  }
}

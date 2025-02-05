class ServicoEventoModel {
  int serCodigo;
  String serNome;
  double serValor;
  int serQuantidade;
  bool tipoServico;

  ServicoEventoModel({
    required this.serCodigo,
    required this.serNome,
    required this.serValor,
    required this.serQuantidade,
    required this.tipoServico,
  });

  factory ServicoEventoModel.fromJson(Map<String, dynamic> json) {
    return ServicoEventoModel(
      serCodigo: json['serCodigo'] ?? 0,
      serNome: json['serNome'] ?? '',
      serValor: json['serValor'] ?? 0,
      serQuantidade: json['serQuantidade'] ?? 0,
      tipoServico: json['tipoServico'] ?? false,
    );
  }
}

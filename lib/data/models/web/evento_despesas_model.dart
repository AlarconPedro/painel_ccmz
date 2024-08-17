class EventoDespesasModel {
  int dseCodigo;
  int eveCodigo;
  String dseNome;
  int dseQuantidade;
  double dseValor;

  EventoDespesasModel({
    required this.dseCodigo,
    required this.eveCodigo,
    required this.dseNome,
    required this.dseQuantidade,
    required this.dseValor,
  });

  factory EventoDespesasModel.fromJson(Map<String, dynamic> json) {
    return EventoDespesasModel(
      dseCodigo: json['dseCodigo'] ?? 0,
      eveCodigo: json['eveCodigo'] ?? 0,
      dseNome: json['dseNome'] ?? '',
      dseQuantidade: json['dseQuantidade'] ?? 0,
      dseValor: json['dseValor'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dseCodigo': dseCodigo,
      'eveCodigo': eveCodigo,
      'dseNome': dseNome,
      'dseQuantidade': dseQuantidade,
      'dseValor': dseValor,
    };
  }
}

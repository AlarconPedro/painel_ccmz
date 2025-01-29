class EventoDespesasModel {
  int edpCodigo;
  int eveCodigo;
  int edpCodigoDespesa;
  int edpQuantidade;
  bool edpTipoDespesa;

  EventoDespesasModel({
    required this.edpCodigo,
    required this.eveCodigo,
    required this.edpCodigoDespesa,
    required this.edpQuantidade,
    required this.edpTipoDespesa,
  });

  factory EventoDespesasModel.fromJson(Map<String, dynamic> json) {
    return EventoDespesasModel(
      edpCodigo: json['edpCodigo'],
      eveCodigo: json['eveCodigo'],
      edpCodigoDespesa: json['edpCodigoDespesa'],
      edpQuantidade: json['edpQuantidade'],
      edpTipoDespesa: json['edpTipoDespesa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'edpCodigo': edpCodigo,
      'eveCodigo': eveCodigo,
      'edpCodigoDespesa': edpCodigoDespesa,
      'edpQuantidade': edpQuantidade,
      'edpTipoDespesa': edpTipoDespesa,
    };
  }
}

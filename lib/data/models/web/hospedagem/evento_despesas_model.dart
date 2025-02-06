class EventoDespesasModel {
  int edpCodigo;
  int eveCodigo;
  int edpCodigoDespesa;
  int edpQuantidade;
  int edpComunidade;
  bool edpTipoDespesa;
  double edpValor;

  EventoDespesasModel({
    required this.edpCodigo,
    required this.eveCodigo,
    required this.edpCodigoDespesa,
    required this.edpQuantidade,
    required this.edpComunidade,
    required this.edpTipoDespesa,
    required this.edpValor,
  });

  factory EventoDespesasModel.fromJson(Map<String, dynamic> json) {
    return EventoDespesasModel(
      edpCodigo: json['edpCodigo'],
      eveCodigo: json['eveCodigo'],
      edpCodigoDespesa: json['edpCodigoDespesa'],
      edpQuantidade: json['edpQuantidade'],
      edpComunidade: json['edpComunidade'],
      edpTipoDespesa: json['edpTipoDespesa'],
      edpValor: json['edpValor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'edpCodigo': edpCodigo,
      'eveCodigo': eveCodigo,
      'edpCodigoDespesa': edpCodigoDespesa,
      'edpQuantidade': edpQuantidade,
      'edpComunidade': edpComunidade,
      'edpTipoDespesa': edpTipoDespesa,
      'edpValor': edpValor,
    };
  }
}

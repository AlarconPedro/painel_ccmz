class ComunidadeDespesaModel {
  int dceCodigo;
  int eveCodigo;
  int comCodigo;
  String dceNome;
  int dceQuantidade;
  double dceValor;

  ComunidadeDespesaModel({
    required this.dceCodigo,
    required this.eveCodigo,
    required this.comCodigo,
    required this.dceNome,
    required this.dceQuantidade,
    required this.dceValor,
  });

  factory ComunidadeDespesaModel.fromJson(Map<String, dynamic> json) {
    return ComunidadeDespesaModel(
      dceCodigo: json['dceCodigo'],
      eveCodigo: json['eveCodigo'],
      comCodigo: json['comCodigo'],
      dceNome: json['dceNome'],
      dceQuantidade: json['dceQuantidade'],
      dceValor: json['dceValor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dceCodigo': dceCodigo,
      'eveCodigo': eveCodigo,
      'comCodigo': comCodigo,
      'dceNome': dceNome,
      'dceQuantidade': dceQuantidade,
      'dceValor': dceValor,
    };
  }
}

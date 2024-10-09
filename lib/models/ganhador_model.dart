class GanhadorModel {
  int parCodigo;
  String parNome;
  String parFone;
  String parCidade;
  String parUf;
  int cupCodigo;
  String cupNumero;
  bool cupSorteado;
  bool cupVendido;

  GanhadorModel({
    required this.parCodigo,
    required this.parNome,
    required this.parFone,
    required this.parCidade,
    required this.parUf,
    required this.cupCodigo,
    required this.cupNumero,
    required this.cupSorteado,
    required this.cupVendido,
  });

  factory GanhadorModel.fromJson(Map<String, dynamic> json) {
    return GanhadorModel(
      parCodigo: json['parCodigo'] ?? 0,
      parNome: json['parNome'] ?? '',
      parFone: json['parFone'] ?? '',
      parCidade: json['parCidade'] ?? '',
      parUf: json['parUf'] ?? '',
      cupCodigo: json['cupCodigo'] ?? 0,
      cupNumero: json['cupNumero'] ?? '',
      cupSorteado: json['cupSorteado'] ?? false,
      cupVendido: json['cupVendido'] ?? false,
    );
  }
}

class GanhadorCupomModel {
  int parCodigo;
  String parNome;
  String parFone;
  String parCidade;
  String parUf;
  int cupCodigo;
  bool cupSorteado;
  bool cupVendido;
  String cupNumero;
  int qtdCupons;

  GanhadorCupomModel({
    required this.parCodigo,
    required this.parNome,
    required this.parFone,
    required this.parCidade,
    required this.parUf,
    required this.cupCodigo,
    required this.cupSorteado,
    required this.cupVendido,
    required this.cupNumero,
    required this.qtdCupons,
  });

  factory GanhadorCupomModel.fromJson(Map<String, dynamic> json) {
    return GanhadorCupomModel(
      parCodigo: json['parCodigo'],
      parNome: json['parNome'],
      parFone: json['parFone'],
      parCidade: json['parCidade'],
      parUf: json['parUf'],
      cupCodigo: json['cupCodigo'],
      cupSorteado: json['cupSorteado'],
      cupVendido: json['cupVendido'],
      cupNumero: json['cupNumero'],
      qtdCupons: json['qtdCupons'],
    );
  }
}

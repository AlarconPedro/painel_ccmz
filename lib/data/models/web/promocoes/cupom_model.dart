class CupomModel {
  int cupCodigo;
  String cupNumero;
  int proCodigo;
  bool cupSorteado;
  bool cupVendido;
  int parCodigo;

  CupomModel({
    required this.cupCodigo,
    required this.cupNumero,
    required this.proCodigo,
    required this.cupSorteado,
    required this.cupVendido,
    required this.parCodigo,
  });

  factory CupomModel.fromMap(Map<String, dynamic> map) {
    return CupomModel(
      cupCodigo: map['cupCodigo'],
      cupNumero: map['cupNumero'],
      proCodigo: map['proCodigo'],
      cupSorteado: map['cupSorteado'],
      cupVendido: map['cupVendido'],
      parCodigo: map['parCodigo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cupCodigo': cupCodigo,
      'cupNumero': cupNumero,
      'proCodigo': proCodigo,
      'cupSorteado': cupSorteado,
      'cupVendido': cupVendido,
      'parCodigo': parCodigo,
    };
  }
}

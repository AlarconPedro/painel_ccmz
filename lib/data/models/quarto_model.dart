class QuartoModel {
  int quaCodigo;
  String quaNome;
  int bloCodigo;
  int quaQtdCamas;

  QuartoModel({
    required this.quaCodigo,
    required this.quaNome,
    required this.bloCodigo,
    required this.quaQtdCamas,
  });

  factory QuartoModel.fromJson(Map<String, dynamic> json) {
    return QuartoModel(
      quaCodigo: json['quaCodigo'],
      quaNome: json['quaNome'],
      bloCodigo: json['bloCodigo'],
      quaQtdCamas: json['quaQtdCamas'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quaCodigo': quaCodigo,
      'quaNome': quaNome,
      'bloCodigo': bloCodigo,
      'quaQtdCamas': quaQtdCamas,
    };
  }
}

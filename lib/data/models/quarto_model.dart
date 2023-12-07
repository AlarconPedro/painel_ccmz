class QuartoModel {
  int quaCodigo;
  String quaNome;
  String bloco;
  int bloCodigo;
  int quaQtdCamas;

  QuartoModel({
    required this.quaCodigo,
    required this.quaNome,
    required this.bloco,
    required this.bloCodigo,
    required this.quaQtdCamas,
  });

  factory QuartoModel.fromJson(Map<String, dynamic> json) {
    return QuartoModel(
      quaCodigo: json['quaCodigo'] ?? 0,
      quaNome: json['quaNome'] ?? '',
      bloco: json['bloco'] ?? '',
      bloCodigo: json['bloCodigo'] ?? 0,
      quaQtdCamas: json['quaQtdCamas'] ?? 0,
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

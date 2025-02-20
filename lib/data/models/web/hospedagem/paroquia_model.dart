class ParoquiaModel {
  int prqCodigo;
  String prqNome;
  String prqCidade;
  String prqUF;

  ParoquiaModel({
    required this.prqCodigo,
    required this.prqNome,
    required this.prqCidade,
    required this.prqUF,
  });

  factory ParoquiaModel.fromJson(Map<String, dynamic> json) {
    return ParoquiaModel(
      prqCodigo: json['prqCodigo'] ?? 0,
      prqNome: json['prqNome'] ?? '',
      prqCidade: json['prqCidade'] ?? '',
      prqUF: json['prqUF'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prqCodigo': prqCodigo,
      'prqNome': prqNome,
      'prqCidade': prqCidade,
      'prqUF': prqUF,
    };
  }
}

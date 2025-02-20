class ParoquiaModel {
  int prqCodigo;
  String prqNome;
  String prqCidade;

  ParoquiaModel({
    required this.prqCodigo,
    required this.prqNome,
    required this.prqCidade,
  });

  factory ParoquiaModel.fromJson(Map<String, dynamic> json) {
    return ParoquiaModel(
      prqCodigo: json['prqCodigo'],
      prqNome: json['prqNome'],
      prqCidade: json['prqCidade'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prqCodigo': prqCodigo,
      'prqNome': prqNome,
      'prqCidade': prqCidade,
    };
  }
}

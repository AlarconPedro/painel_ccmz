class ComunidadeModel {
  int comCodigo;
  String comNome;
  String comCidade;
  String comUF;
  int prqCodigo;
  int qtdPessoas;

  ComunidadeModel({
    required this.comCodigo,
    required this.comNome,
    required this.comCidade,
    required this.comUF,
    required this.prqCodigo,
    required this.qtdPessoas,
  });

  factory ComunidadeModel.fromJson(Map<String, dynamic> json) {
    return ComunidadeModel(
      comCodigo: json['comCodigo'] ?? 0,
      comNome: json['comNome'] ?? "",
      comCidade: json['comCidade'] ?? "",
      comUF: json['comUf'] ?? "",
      prqCodigo: json['prqCodigo'] ?? 0,
      qtdPessoas: json['qtdPessoas'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comCodigo': comCodigo,
      'comNome': comNome,
      'prqCodigo': prqCodigo,
      'comCidade': comCidade,
      // 'comUF': comUF,
    };
  }
}

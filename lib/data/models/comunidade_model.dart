class ComunidadeModel {
  int comCodigo;
  String comNome;
  String comCidade;
  String comUF;
  int qtdPessoas;

  ComunidadeModel({
    required this.comCodigo,
    required this.comNome,
    required this.comCidade,
    required this.comUF,
    required this.qtdPessoas,
  });

  factory ComunidadeModel.fromJson(Map<String, dynamic> json) {
    return ComunidadeModel(
      comCodigo: json['comCodigo'] ?? 0,
      comNome: json['comNome'] ?? "",
      comCidade: json['comCidade'] ?? "",
      comUF: json['comUF'] ?? "",
      qtdPessoas: json['qtdPessoas'] ?? 0,
    );
  }
}

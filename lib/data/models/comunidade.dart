class Comunidade {
  int comCodigo;
  String comNome;
  String comCidade;
  String comUF;
  int qtdPessoas;

  Comunidade({
    required this.comCodigo,
    required this.comNome,
    required this.comCidade,
    required this.comUF,
    required this.qtdPessoas,
  });

  factory Comunidade.fromJson(Map<String, dynamic> json) {
    return Comunidade(
      comCodigo: json['comCodigo'] ?? 0,
      comNome: json['comNome'] ?? "",
      comCidade: json['comCidade'] ?? "",
      comUF: json['comUF'] ?? "",
      qtdPessoas: json['qtdPessoas'] ?? 0,
    );
  }
}

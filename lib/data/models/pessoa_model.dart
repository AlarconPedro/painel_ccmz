class PessoaModel {
  int pesCodigo;
  int evpCodigo;
  String pesNome;
  String pesGenero;
  String comunidade;
  int comCodigo;
  String pesResponsavel;
  String pesCatequista;
  String pesSalmista;
  String pesObservacao;
  bool pesPagante;
  bool pesCobrante;

  PessoaModel({
    required this.pesCodigo,
    required this.evpCodigo,
    required this.pesNome,
    required this.pesGenero,
    required this.comunidade,
    required this.comCodigo,
    required this.pesResponsavel,
    required this.pesCatequista,
    required this.pesSalmista,
    required this.pesObservacao,
    required this.pesPagante,
    required this.pesCobrante,
  });

  factory PessoaModel.fromJson(Map<String, dynamic> json) {
    return PessoaModel(
      pesCodigo: json['pesCodigo'] ?? 0,
      evpCodigo: json['evpCodigo'] ?? 0,
      pesNome: json['pesNome'] ?? "",
      pesGenero: json['pesGenero'] ?? "",
      comunidade: json['comunidade'] ?? "",
      comCodigo: json['comCodigo'] ?? 0,
      pesResponsavel: json['pesResponsavel'] ?? "",
      pesCatequista: json['pesCatequista'] ?? "",
      pesSalmista: json['pesSalmista'] ?? "",
      pesObservacao: json['pesObservacao'] ?? "",
      pesPagante: json['evpPagante'] ?? false,
      pesCobrante: json['evpCobrante'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pesCodigo': pesCodigo,
      'pesNome': pesNome,
      'pesGenero': pesGenero,
      'comCodigo': comCodigo,
      'pesResponsavel': pesResponsavel,
      'pesCatequista': pesCatequista,
      'pesSalmista': pesSalmista,
      'pesObservacao': pesObservacao,
    };
  }
}

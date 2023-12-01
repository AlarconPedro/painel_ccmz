class Pessoa {
  int pesCodigo;
  String pesNome;
  String pesGenero;
  String comunidade;
  int comCodigo;
  String pesResponsavel;
  String pesCatequista;
  String pesSalmista;
  String pesObservacao;

  Pessoa({
    required this.pesCodigo,
    required this.pesNome,
    required this.pesGenero,
    required this.comunidade,
    required this.comCodigo,
    required this.pesResponsavel,
    required this.pesCatequista,
    required this.pesSalmista,
    required this.pesObservacao,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      pesCodigo: json['pesCodigo'] ?? 0,
      pesNome: json['pesNome'] ?? "",
      pesGenero: json['pesGenero'] ?? "",
      comunidade: json['comunidade'] ?? "",
      comCodigo: json['comCodigo'] ?? 0,
      pesResponsavel: json['pesResponsavel'] ?? "",
      pesCatequista: json['pesCatequista'] ?? "",
      pesSalmista: json['pesSalmista'] ?? "",
      pesObservacao: json['pesObservacao'] ?? "",
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

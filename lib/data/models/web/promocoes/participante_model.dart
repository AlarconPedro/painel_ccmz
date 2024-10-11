class ParticipanteModel {
  int parCodigo;
  String parNome;
  String parCpf;
  String parFone;
  String parEndereco;
  String parCidade;
  String parUF;
  String parDataNasc;
  String parEmail;
  int codigo;
  String nome;
  String telefone;
  String cpf;
  int proCodigo;

  ParticipanteModel({
    required this.parCodigo,
    required this.parNome,
    required this.parCpf,
    required this.parFone,
    required this.parEndereco,
    required this.parCidade,
    required this.parUF,
    required this.parDataNasc,
    required this.parEmail,
    required this.proCodigo,
    required this.codigo,
    required this.nome,
    required this.telefone,
    required this.cpf,
  });

  factory ParticipanteModel.fromJson(Map<String, dynamic> map) {
    return ParticipanteModel(
      parCodigo: map['parCodigo'] ?? 0,
      parNome: map['parNome'] ?? '',
      parCpf: map['parCpf'] ?? '',
      parFone: map['parFone'] ?? '',
      parEndereco: map['parEndereco'] ?? '',
      parCidade: map['parCidade'] ?? '',
      parUF: map['parUF'] ?? '',
      parDataNasc: map['parDataNasc'] ?? '',
      parEmail: map['parEmail'] ?? '',
      proCodigo: map['proCodigo'] ?? 0,
      codigo: map['codigo'] ?? 0,
      nome: map['nome'] ?? '',
      telefone: map['telefone'] ?? '',
      cpf: map['cpf'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'parCodigo': parCodigo,
      'parNome': parNome,
      'parCpf': parCpf,
      'parFone': parFone,
      'parEndereco': parEndereco,
      'parCidade': parCidade,
      'parUF': parUF,
      'parDataNasc': parDataNasc,
      'parEmail': parEmail,
      'proCodigo': proCodigo,
    };
  }
}

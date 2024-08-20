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
  });

  factory ParticipanteModel.fromMap(Map<String, dynamic> map) {
    return ParticipanteModel(
      parCodigo: map['parCodigo'],
      parNome: map['parNome'],
      parCpf: map['parCpf'],
      parFone: map['parFone'],
      parEndereco: map['parEndereco'],
      parCidade: map['parCidade'],
      parUF: map['parUF'],
      parDataNasc: map['parDataNasc'],
      parEmail: map['parEmail'],
      proCodigo: map['proCodigo'],
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

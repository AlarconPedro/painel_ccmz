class UsuarioModel {
  int usuCodigo;
  String usuNome;
  String usuEmail;
  String usuSenha;
  String usuCodigoFirebase;
  bool usuAcessoHospede;
  bool usuAcessoFinanceiro;
  bool usuAcessoEstoque;

  UsuarioModel({
    required this.usuCodigo,
    required this.usuNome,
    required this.usuEmail,
    required this.usuSenha,
    required this.usuCodigoFirebase,
    required this.usuAcessoHospede,
    required this.usuAcessoFinanceiro,
    required this.usuAcessoEstoque,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      usuCodigo: json['usuCodigo'] ?? 0,
      usuNome: json['usuNome'] ?? '',
      usuEmail: json['usuEmail'] ?? '',
      usuSenha: json['usuSenha'] ?? '',
      usuCodigoFirebase: json['usuCodigoFirebase'] ?? '',
      usuAcessoHospede: json['usuAcessoHospedagem'] ?? false,
      usuAcessoFinanceiro: json['usuAcessoFinanceiro'] ?? false,
      usuAcessoEstoque: json['usuAcessoEstoque'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuCodigo': usuCodigo,
      'usuNome': usuNome,
      'usuEmail': usuEmail,
      'usuSenha': usuSenha,
      'usuCodigoFirebase': usuCodigoFirebase,
      'usuAcessoHospedagem': usuAcessoHospede,
      'usuAcessoFinanceiro': usuAcessoFinanceiro,
      'usuAcessoEstoque': usuAcessoEstoque,
    };
  }
}

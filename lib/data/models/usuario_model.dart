class UsuarioModel {
  int usuCodigo;
  String usuNome;
  String usuEmail;
  String usuSenha;
  String usuCodigoFirebase;
  bool usuAcessoHospede;
  bool usuACessoFinanceiro;
  bool usuAcessoEstoque;

  UsuarioModel({
    required this.usuCodigo,
    required this.usuNome,
    required this.usuEmail,
    required this.usuSenha,
    required this.usuCodigoFirebase,
    required this.usuAcessoHospede,
    required this.usuACessoFinanceiro,
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
      usuACessoFinanceiro: json['usuAcessoFinanceiro'] ?? false,
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
      'usuAcessoFinanceiro': usuACessoFinanceiro,
      'usuAcessoEstoque': usuAcessoEstoque,
    };
  }
}
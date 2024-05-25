class UsuarioModel {
  int usuCodigo;
  String usuEmail;
  String usuSenha;
  String usuCodigoFirebase;
  bool usuAcessoHospede;
  bool usuACessoFinanceiro;
  bool usuAcessoEstoque;

  UsuarioModel({
    required this.usuCodigo,
    required this.usuEmail,
    required this.usuSenha,
    required this.usuCodigoFirebase,
    required this.usuAcessoHospede,
    required this.usuACessoFinanceiro,
    required this.usuAcessoEstoque,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      usuCodigo: json['usuCodigo'],
      usuEmail: json['usuEmail'],
      usuSenha: json['usuSenha'],
      usuCodigoFirebase: json['usuCodigoFirebase'],
      usuAcessoHospede: json['usuAcessoHospede'],
      usuACessoFinanceiro: json['usuACessoFinanceiro'],
      usuAcessoEstoque: json['usuAcessoEstoque'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'usuCodigo': usuCodigo,
      'usuEmail': usuEmail,
      'usuSenha': usuSenha,
      'usuCodigoFirebase': usuCodigoFirebase,
      'usuAcessoHospede': usuAcessoHospede,
      'usuACessoFinanceiro': usuACessoFinanceiro,
      'usuAcessoEstoque': usuAcessoEstoque,
    };
  }
}

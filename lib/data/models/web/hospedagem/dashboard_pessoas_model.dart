class DashboardPessoasModel {
  int pesCodigo;
  int quaCodigo;
  String pesNome;
  String pesGenero;
  String comNome;

  DashboardPessoasModel({
    required this.pesCodigo,
    required this.quaCodigo,
    required this.pesNome,
    required this.pesGenero,
    required this.comNome,
  });

  factory DashboardPessoasModel.fromJson(Map<String, dynamic> json) {
    return DashboardPessoasModel(
      pesCodigo: json['pesCodigo'] ?? 0,
      quaCodigo: json['quaCodigo'] ?? 0,
      pesNome: json['pesNome'] ?? "",
      pesGenero: json['pesGenero'] ?? "",
      comNome: json['comNome'] ?? "",
    );
  }
}

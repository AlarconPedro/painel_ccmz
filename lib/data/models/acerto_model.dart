class AcertoModel {
  int comCodigo;
  String comNome;
  List<Map<String, dynamic>> pagantesCobrantes;

  AcertoModel({
    required this.comCodigo,
    required this.comNome,
    required this.pagantesCobrantes,
  });

  factory AcertoModel.fromJson(Map<String, dynamic> json) {
    return AcertoModel(
      comCodigo: json['comCodigo'] ?? 0,
      comNome: json['comNome'] ?? '',
      pagantesCobrantes: json['pagantesCobrantes'] == null
          ? []
          : (json['pagantesCobrantes'] as List)
              .map((e) => e as Map<String, dynamic>)
              .toList(),
    );
  }
}

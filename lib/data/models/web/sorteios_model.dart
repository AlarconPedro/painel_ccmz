class SorteiosModel {
  int sorCodigo;
  String sorData;
  String preNome;
  int preCodigo;
  int proCodigo;
  String parNome;
  String cupNumero;
  String proVideo;

  SorteiosModel({
    required this.sorCodigo,
    required this.sorData,
    required this.preNome,
    required this.preCodigo,
    required this.proCodigo,
    required this.parNome,
    required this.cupNumero,
    required this.proVideo,
  });

  factory SorteiosModel.fromJson(Map<String, dynamic> json) {
    return SorteiosModel(
      sorCodigo: json['sorCodigo'] ?? 0,
      sorData: json['sorData'] ?? '',
      preNome: json['preNome'] ?? '',
      preCodigo: json['preCodigo'] ?? 0,
      proCodigo: json['proCodigo'] ?? 0,
      parNome: json['parNome'] ?? '',
      cupNumero: json['cupNumero'] ?? '',
      proVideo: json['proVideo'] ?? '',
    );
  }
}

class SorteioModel {
  int sorCodigo;
  String sorData;
  int parCodigo;
  int preCodigo;
  int cupCodigo;
  int proCodigo;
  String proVideo;

  SorteioModel({
    required this.sorCodigo,
    required this.sorData,
    required this.parCodigo,
    required this.preCodigo,
    required this.cupCodigo,
    required this.proCodigo,
    required this.proVideo,
  });

  factory SorteioModel.fromMap(Map<String, dynamic> map) {
    return SorteioModel(
      sorCodigo: map['sorCodigo'],
      sorData: map['sorData'],
      parCodigo: map['parCodigo'],
      preCodigo: map['preCodigo'],
      cupCodigo: map['cupCodigo'],
      proCodigo: map['proCodigo'],
      proVideo: map['proVideo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sorCodigo': sorCodigo,
      'sorData': sorData,
      'parCodigo': parCodigo == 0 ? null : parCodigo,
      'preCodigo': preCodigo,
      'cupCodigo': cupCodigo == 0 ? null : cupCodigo,
      'proCodigo': proCodigo,
      'proVideo': proVideo,
    };
  }
}

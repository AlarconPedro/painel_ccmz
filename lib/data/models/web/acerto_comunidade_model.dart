import 'package:painel_ccmn/data/models/web/pagantes_cobrantes_model.dart';

class AcertoModel {
  int comCodigo;
  String comNome;
  PagantesCobrantesModel pagantesCobrantes;

  AcertoModel({
    required this.comCodigo,
    required this.comNome,
    required this.pagantesCobrantes,
  });

  factory AcertoModel.fromJson(Map<String, dynamic> json) {
    return AcertoModel(
      comCodigo: json['comCodigo'] ?? 0,
      comNome: json['comNome'] ?? '',
      pagantesCobrantes:
          PagantesCobrantesModel.fromJson(json['pagantesCobrantes']),
    );
  }
}

import 'package:painel_ccmz/data/models/checkin_model.dart';

class QuartoPessoasModel {
  int quaCodigo;
  String quaNome;
  int bloCodigo;
  List<CheckinModel> pessoasQuarto;

  QuartoPessoasModel({
    required this.quaCodigo,
    required this.quaNome,
    required this.bloCodigo,
    required this.pessoasQuarto,
  });

  factory QuartoPessoasModel.fromJson(Map<String, dynamic> json) =>
      QuartoPessoasModel(
        quaCodigo: json["quaCodigo"],
        quaNome: json["quaNome"],
        bloCodigo: json["bloCodigo"],
        pessoasQuarto: List<CheckinModel>.from(
            json["pessoasQuarto"].map((x) => CheckinModel.fromJson(x))),
      );
}

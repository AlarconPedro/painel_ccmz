import 'package:painel_ccmn/data/models/web/checkin_model.dart';

class QuartoPessoasModel {
  int quaCodigo;
  String quaNome;
  String bloNome;
  int bloCodigo;
  int vagas;
  List<CheckinModel> pessoasQuarto;

  QuartoPessoasModel({
    required this.quaCodigo,
    required this.quaNome,
    required this.bloNome,
    required this.bloCodigo,
    required this.vagas,
    required this.pessoasQuarto,
  });

  factory QuartoPessoasModel.fromJson(Map<String, dynamic> json) =>
      QuartoPessoasModel(
        quaCodigo: json["quaCodigo"] ?? 0,
        quaNome: json["quaNome"] ?? "",
        bloNome: json["bloNome"] ?? "",
        bloCodigo: json["bloCodigo"] ?? 0,
        vagas: json["vagas"] ?? 0,
        pessoasQuarto:
            json["pessoasQuarto"] == null || json["pessoasQuarto"] == []
                ? []
                : (json["pessoasQuarto"] as List)
                    .map((x) => CheckinModel.fromJson(x))
                    .toList(),
      );
}

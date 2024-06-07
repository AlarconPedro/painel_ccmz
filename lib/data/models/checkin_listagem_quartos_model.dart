import 'package:painel_ccmn/data/models/quarto_pessoas_model.dart';

class CheckinListagemQuartosModel {
  String bloNome;
  List<QuartoPessoasModel> pessoasQuarto;

  CheckinListagemQuartosModel({
    required this.bloNome,
    required this.pessoasQuarto,
  });

  factory CheckinListagemQuartosModel.fromJson(Map<String, dynamic> json) {
    return CheckinListagemQuartosModel(
      bloNome: json['bloNome'],
      pessoasQuarto: List<QuartoPessoasModel>.from(
        json['pessoasQuarto'].map(
          (x) => QuartoPessoasModel.fromJson(x),
        ),
      ),
    );
  }
}

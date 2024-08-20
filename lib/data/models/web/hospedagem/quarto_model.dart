import 'package:painel_ccmn/data/models/web/hospedagem/pessoa_model.dart';

class QuartoModel {
  int quaCodigo;
  String quaNome;
  String bloco;
  int bloCodigo;
  int quaQtdCamas;
  int quaQtdCamaslivres;
  List<PessoaModel> pessoas = [];

  QuartoModel({
    required this.quaCodigo,
    required this.quaNome,
    required this.bloco,
    required this.bloCodigo,
    required this.quaQtdCamas,
    required this.quaQtdCamaslivres,
    required this.pessoas,
  });

  factory QuartoModel.fromJson(Map<String, dynamic> json) {
    return QuartoModel(
      quaCodigo: json['quaCodigo'] ?? 0,
      quaNome: json['quaNome'] ?? '',
      bloco: json['bloco'] ?? '',
      bloCodigo: json['bloCodigo'] ?? 0,
      quaQtdCamas: json['quaQtdcamas'] ?? 0,
      quaQtdCamaslivres: json['quaQtdcamasdisponiveis'] ?? 0,
      pessoas: json['pessoasQuarto'] == null
          ? []
          : (json['pessoasQuarto'] as List)
              .map((e) => PessoaModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quaCodigo': quaCodigo,
      'quaNome': quaNome,
      'bloCodigo': bloCodigo,
      'quaQtdCamas': quaQtdCamas,
    };
  }
}

import 'package:painel_ccmn/funcoes/funcoes.dart';

class MovimentoEstoqueModel {
  int movCodigo;
  int proCodigo;
  String proNome;
  int movQuantidade;
  String movData;
  String movTipo;

  MovimentoEstoqueModel({
    required this.movCodigo,
    required this.proCodigo,
    required this.proNome,
    required this.movQuantidade,
    required this.movData,
    required this.movTipo,
  });

  factory MovimentoEstoqueModel.fromJson(Map<String, dynamic> json) {
    return MovimentoEstoqueModel(
      movCodigo: json['movCodigo'] ?? 0,
      proCodigo: json['proCodigo'] ?? 0,
      proNome: json['proNome'] ?? '',
      movQuantidade: json['movQuantidade'] ?? 0,
      movData: FuncoesData.dataFormatada(json['movData'] ?? ''),
      movTipo: json['movTipo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movCodigo': movCodigo,
      'proCodigo': proCodigo,
      'proNome': proNome,
      'movQuantidade': movQuantidade,
      'movData': movData,
      'movTipo': movTipo,
    };
  }
}

import 'package:painel_ccmn/funcoes/funcoes.dart';

class EventoModel {
  int eveCodigo;
  String eveNome;
  String eveDataInicio;
  String eveDataFim;

  EventoModel({
    required this.eveCodigo,
    required this.eveNome,
    required this.eveDataInicio,
    required this.eveDataFim,
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
        eveCodigo: json["eveCodigo"] ?? 0,
        eveNome: json["eveNome"] ?? "",
        eveDataInicio:
            FuncoesData.dataFormatadaHora(json["eveDatainicio"] ?? ""),
        eveDataFim: FuncoesData.dataFormatadaHora(json["eveDatafim"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "eveCodigo": eveCodigo,
        "eveNome": eveNome,
        "eveDataInicio": eveDataInicio,
        "eveDataFim": eveDataFim,
      };
}

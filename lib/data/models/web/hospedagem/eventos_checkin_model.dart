class EventoCheckinModel {
  int eveCodigo;
  String eveNome;
  String eveDataInicio;
  String eveDataFim;

  EventoCheckinModel({
    required this.eveCodigo,
    required this.eveNome,
    required this.eveDataInicio,
    required this.eveDataFim,
  });

  factory EventoCheckinModel.fromJson(Map<String, dynamic> json) {
    return EventoCheckinModel(
      eveCodigo: json['eveCodigo'] ?? 0,
      eveNome: json['eveNome'] ?? '',
      eveDataInicio: json['eveDatainicio'] ?? '',
      eveDataFim: json['eveDatafim'] ?? '',
    );
  }
}

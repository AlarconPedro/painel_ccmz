class EventoQuartoModel {
  int evqCodigo;
  int quaCodigo;
  int eveCodigo;

  EventoQuartoModel({
    required this.evqCodigo,
    required this.quaCodigo,
    required this.eveCodigo,
  });

  factory EventoQuartoModel.fromJson(Map<String, dynamic> json) {
    return EventoQuartoModel(
      evqCodigo: json['evqCodigo'],
      quaCodigo: json['quaCodigo'],
      eveCodigo: json['eveCodigo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "evqCodigo": evqCodigo,
      "quaCodigo": quaCodigo,
      "eveCodigo": eveCodigo,
    };
  }
}

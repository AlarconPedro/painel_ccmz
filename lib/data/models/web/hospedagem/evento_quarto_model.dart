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
      evqCodigo: json['evqCodigo'] ?? 0,
      quaCodigo: json['quaCodigo'] ?? 0,
      eveCodigo: json['eveCodigo'] ?? 0,
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

class EventoPessoasModel {
  int evpCodigo;
  int eveCodigo;
  int pesCodigo;
  bool evpPagante;
  bool evpCobrante;

  EventoPessoasModel({
    required this.evpCodigo,
    required this.eveCodigo,
    required this.pesCodigo,
    required this.evpPagante,
    required this.evpCobrante,
  });

  factory EventoPessoasModel.fromJson(Map<String, dynamic> json) =>
      EventoPessoasModel(
        evpCodigo: json["evpCodigo"],
        eveCodigo: json["eveCodigo"],
        pesCodigo: json["pesCodigo"],
        evpPagante: json["evpPagante"],
        evpCobrante: json["evpCobrante"],
      );

  Map<String, dynamic> toJson() => {
        "evpCodigo": evpCodigo,
        "eveCodigo": eveCodigo,
        "pesCodigo": pesCodigo,
        "evpPagante": evpPagante,
        "evpCobrante": evpCobrante,
      };
}

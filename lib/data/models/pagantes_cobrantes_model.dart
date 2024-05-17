class PagantesCobrantesModel {
  int pagantes;
  int cobrantes;

  PagantesCobrantesModel({required this.pagantes, required this.cobrantes});

  factory PagantesCobrantesModel.fromJson(Map<String, dynamic> json) {
    return PagantesCobrantesModel(
      pagantes: json['pagantes'],
      cobrantes: json['cobrantes'],
    );
  }
}

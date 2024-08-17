class CategoriaModel {
  int catCodigo;
  String catNome;

  CategoriaModel({required this.catCodigo, required this.catNome});

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
        catCodigo: json['catCodigo'] ?? 0, catNome: json['catNome'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'catCodigo': catCodigo, 'catNome': catNome};
  }
}

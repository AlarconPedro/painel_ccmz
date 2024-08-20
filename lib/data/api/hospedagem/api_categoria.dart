import 'package:painel_ccmn/classes/classes.dart';
import 'package:painel_ccmn/data/data.dart';

class ApiCategoria {
  static final _request = HttpRequest();

  final String _urlGetCategorias = '${Globais.urlBase}categoria';
  final String _urlAddCategoria = '${Globais.urlBase}categoria';
  final String _urlUpdateCategoria = '${Globais.urlBase}categoria';

  Future<dynamic> getCategorias() async {
    return await _request.getJson(_urlGetCategorias);
  }

  Future<dynamic> addCategoria(CategoriaModel categoria) async {
    return await _request.postJson(_urlAddCategoria, categoria.toJson());
  }

  Future<dynamic> updateCategoria(CategoriaModel categoria) async {
    return await _request.putJson(_urlUpdateCategoria, categoria.toJson());
  }
}

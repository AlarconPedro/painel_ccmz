import 'package:painel_ccmn/classes/classes.dart';
import 'package:painel_ccmn/data/data.dart';

import '../../models/web/hospedagem/produto_model.dart';

class ApiProdutos {
  static final _request = HttpRequest();

  final String _urlGetProdutos = '${Globais.urlBase}Produto';
  final String _urlGetProduto = '${Globais.urlBase}Produto/';
  final String _urlAddProduto = '${Globais.urlBase}Produto';
  final String _urlUpdateProduto = '${Globais.urlBase}Produto';
  final String _urlDeleteProduto = '${Globais.urlBase}Produto/';

  Future<dynamic> getProdutos() async {
    return await _request.getJson(_urlGetProdutos);
  }

  Future<dynamic> getProduto(int codigoProduto) async {
    return await _request.getJson(_urlGetProduto + codigoProduto.toString());
  }

  Future<dynamic> addProduto(ProdutoModel produto) async {
    return await _request.postJson(_urlAddProduto, produto.toJson());
  }

  Future<dynamic> updateProduto(ProdutoModel produto) async {
    return await _request.putJson(_urlUpdateProduto, produto.toJson());
  }

  Future<dynamic> deleteProduto(int codigoProduto) async {
    return await _request.deleteJson("$_urlDeleteProduto$codigoProduto");
  }
}

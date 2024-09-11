import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';

class ApiMovimentoEstoque {
  static final _request = HttpRequest();

  //GET
  final String _urlGetMovimentoEstoque = "${Globais.urlBase}MovimentoEstoque";

  //POST
  final String _urlPostMovimentoEstoque = "${Globais.urlBase}MovimentoEstoque";

  //DELETE
  final String _urlDeleteMovimentoEstoque =
      "${Globais.urlBase}MovimentoEstoque";

  //GET
  Future<dynamic> getMovimentoEstoque() async {
    return await _request.getJson(_urlGetMovimentoEstoque);
  }

  // //POST
  // Future<dynamic> postMovimentoEstoque(MovimentoEstoqueModel movimentoEstoque) async {
  //   return await _request.postJson(_urlPostMovimentoEstoque, movimentoEstoque.toJson());
  // }

  //DELETE
  Future<dynamic> deleteMovimentoEstoque(int codigoMovimento) async {
    return await _request
        .deleteJson("$_urlDeleteMovimentoEstoque/$codigoMovimento");
  }
}

import 'package:painel_ccmn/data/data.dart';

import '../../classes/classes.dart';

class ApiRelatorio {
  final _request = HttpRequest();

  //GET
  final String urlGetRelatorioProdutosAcabando =
      "${Globais.urlBase}/Relatorio/ProdutosAcabando";

  //GET
  Future<dynamic> getRelatorioProdutosAcabando() async {
    return await _request.getJson(urlGetRelatorioProdutosAcabando);
  }
}

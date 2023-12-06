import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class ApiBloco {
  static final _request = HttpRequest();

  //GET
  final String _urlGetBlocos = "${Globais.urlBase}bloco";
  final String _urlGetBloco = "${Globais.urlBase}bloco/";

  //POST
  final String _urlAddBloco = "${Globais.urlBase}bloco";

  //UPDATE
  final String _urlUpdateBloco = "${Globais.urlBase}bloco";

  //DELETE
  final String _urlDeleteBloco = "${Globais.urlBase}bloco/";

  //GET
  Future<dynamic> getBlocos() async {
    return await _request.getJson(_urlGetBlocos);
  }

  Future<dynamic> getBloco(int codigoBloco) async {
    return await _request.getJson(_urlGetBloco + codigoBloco.toString());
  }

  //POST
  Future<dynamic> addBloco(BlocoModel bloco) async {
    return await _request.postJson(_urlAddBloco, bloco.toJson());
  }

  //UPDATE
  Future<dynamic> updateBloco(BlocoModel bloco) async {
    return await _request.putJson(_urlUpdateBloco, bloco.toJson());
  }

  //DELETE
  Future<dynamic> deleteBloco(int codigoBloco) async {
    return await _request.deleteJson(_urlDeleteBloco + codigoBloco.toString());
  }
}

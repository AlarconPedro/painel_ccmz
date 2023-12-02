import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class ApiComunidade {
  static final _request = HttpRequest();

  //GET
  final String _urlGetComunidades = "${Globais.urlBase}comunidade";
  final String _urlGetComunidade = "${Globais.urlBase}comunidade/";
  //POST
  final String _urlAddComunidade = "${Globais.urlBase}comunidade";
  //UPDATE
  final String _urlUpdateComunidade = "${Globais.urlBase}comunidade";
  //DELETE
  final String _urlDeleteComunidade = "${Globais.urlBase}comunidade/";

  //GET
  Future<dynamic> getComunidades() async {
    return await _request.getJson(_urlGetComunidades);
  }

  Future<dynamic> getComunidade(int codigoComunidade) async {
    return await _request
        .getJson(_urlGetComunidade + codigoComunidade.toString());
  }

  //POST
  Future<dynamic> addComunidade(ComunidadeModel comunidade) async {
    return await _request.postJson(_urlAddComunidade, comunidade.toMap());
  }

  //UPDATE
  Future<dynamic> updateComunidade(ComunidadeModel comunidade) async {
    return await _request.putJson(_urlUpdateComunidade, comunidade.toMap());
  }

  //DELETE
  Future<dynamic> deleteComunidade(int codigoComunidade) async {
    return await _request
        .deleteJson(_urlDeleteComunidade + codigoComunidade.toString());
  }
}

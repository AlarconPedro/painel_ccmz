import 'package:painel_ccmn/classes/globais.dart';
import 'package:painel_ccmn/data/http/http_request.dart';

class ApiParoquia {
  final HttpRequest _request = HttpRequest();

  final String _urlBase = "${Globais.urlBase}paroquia";

  Future<dynamic> buscarParoquias() async {
    return await _request.getJson(_urlBase);
  }

  Future<dynamic> gravarParoquia(Map<String, dynamic> dados) async {
    return await _request.postJson(_urlBase, dados);
  }

  Future<dynamic> atualizarParoquia(Map<String, dynamic> dados) async {
    return await _request.putJson(_urlBase, dados);
  }

  Future<dynamic> excluirParoquia(String id) async {
    return await _request.deleteJson("$_urlBase/$id");
  }
}

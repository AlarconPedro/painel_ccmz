import '../../classes/classes.dart';
import '../http/http_request.dart';

class ApiAcerto {
  static final _request = HttpRequest();

  //GET
  final String _urlGetEventoCusto = "${Globais.urlBase}acerto/evento/custo/";

  final String _urlGetEventoDespesas =
      "${Globais.urlBase}acerto/evento/despesas/";

  final String _urlGetEventoPessoas =
      "${Globais.urlBase}acerto/evento/pessoas/";

  //GET
  Future<dynamic> getEventoCusto(int codigoEvento) async {
    return await _request.getJson("$_urlGetEventoCusto$codigoEvento");
  }

  Future<dynamic> getEventoDespesas(int codigoEvento) async {
    return await _request.getJson("$_urlGetEventoDespesas$codigoEvento");
  }

  Future<dynamic> getEventoPessoas(int codigoEvento) async {
    return await _request.getJson("$_urlGetEventoPessoas$codigoEvento");
  }
}

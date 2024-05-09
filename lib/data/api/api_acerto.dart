import '../../classes/classes.dart';
import '../http/http_request.dart';

class ApiAcerto {
  static final _request = HttpRequest();

  //GET
  final String _urlGetEventoCusto = "${Globais.urlBase}Acerto/evento/custo/";

  final String _urlGetComunidadesEvento =
      "${Globais.urlBase}Acerto/evento/comunidades/";

  final String _urlGetEventoDespesas =
      "${Globais.urlBase}Acerto/evento/despesas/";

  final String _urlGetEventoPessoas =
      "${Globais.urlBase}Acerto/evento/pessoas/";

  final String _urlGetComuidadePessoas =
      "${Globais.urlBase}Acerto/comunidade/pessoas/";

  final String _urlGetComunidadeDespesas =
      "${Globais.urlBase}Acerto/comunidade/despesas/";

  //GET
  Future<dynamic> getComunidadesEvento(int codigoEvento) async {
    return await _request.getJson("$_urlGetComunidadesEvento$codigoEvento");
  }

  Future<dynamic> getEventoCusto(int codigoEvento) async {
    return await _request.getJson("$_urlGetEventoCusto$codigoEvento");
  }

  Future<dynamic> getEventoDespesas(int codigoEvento) async {
    return await _request.getJson("$_urlGetEventoDespesas$codigoEvento");
  }

  Future<dynamic> getEventoPessoas(int codigoEvento) async {
    return await _request.getJson("$_urlGetEventoPessoas$codigoEvento");
  }

  Future<dynamic> getComunidadePessoas(
      int codigoEvento, int codigoComunidade) async {
    return await _request
        .getJson("$_urlGetComuidadePessoas$codigoEvento/$codigoComunidade");
  }

  Future<dynamic> getComunidadeDespesas(
      int codigoEvento, int codigoComunidade) async {
    return await _request
        .getJson("$_urlGetComunidadeDespesas$codigoEvento/$codigoComunidade");
  }
}

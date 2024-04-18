import '../../classes/classes.dart';
import '../data.dart';

class ApiDashboard {
  static final _request = HttpRequest();

  //GET
  final String _urlGetNumeroPessoasAChegar =
      "${Globais.urlBase}dashboard/numeroPessoasAChegar/";
  final String _urlGetNumeroPessoasChegas =
      "${Globais.urlBase}dashboard/numeroPessoasChegas/";
  final String _urlGetNumeroPessoasNaoVem =
      "${Globais.urlBase}dashboard/numeroPessoasNaovem/";
  final String _urlGetNumeroPessoasCobrantes =
      "${Globais.urlBase}dashboard/numeroPessoasCobrantes/";
  final String _urlGetNumeroPessoasPagantes =
      "${Globais.urlBase}dashboard/numeroPessoasPagantes/";
  final String _urlNumeroCamasLivres =
      "${Globais.urlBase}dashboard/numeroCamasLivres/";
  final String _urlNumeroCamasOcupadas =
      "${Globais.urlBase}dashboard/numeroCamasOcupadas/";
  final String _urlGetPessoasChegas =
      "${Globais.urlBase}dashboard/pessoasChegas/";
  final String _urlGetPessoasAChegar =
      "${Globais.urlBase}dashboard/pessoasAChegar/";
  final String _urlGetPessoasNaoVem =
      "${Globais.urlBase}dashboard/pessoasNaoVem/";
  final String _urlGetQuartoPessoaNaovem =
      "${Globais.urlBase}dashboard/quartoPessoaNaoVem/";
  final String _urlGetQuartoPessoaAChegar =
      "${Globais.urlBase}dashboard/quartoPessoaAChegar/";
  final String _urlGetQuartoPessoaChega =
      "${Globais.urlBase}dashboard/quartoPessoaAChegar/";
  final String _urlGetEventos = "${Globais.urlBase}dashboard/eventos";

  //GET
  Future<dynamic> getNumeroPessoas(int codigoEvento) async {
    return await _request
        .getJson(_urlGetNumeroPessoasAChegar + codigoEvento.toString());
  }

  Future<dynamic> getNumeroPessoasChegas(int codigoEvento) async {
    return await _request
        .getJson(_urlGetNumeroPessoasChegas + codigoEvento.toString());
  }

  Future<dynamic> getNumeroPessoasNaoVem(int codigoEvento) async {
    return await _request
        .getJson(_urlGetNumeroPessoasNaoVem + codigoEvento.toString());
  }

  Future<dynamic> getNumeroPessoasCobrantes(int codigoEvento) async {
    return await _request
        .getJson(_urlGetNumeroPessoasCobrantes + codigoEvento.toString());
  }

  Future<dynamic> getNumeroPessoasPagantes(int codigoEvento) async {
    return await _request
        .getJson(_urlGetNumeroPessoasPagantes + codigoEvento.toString());
  }

  Future<dynamic> getNumeroCamasLivres(int codigoEvento) async {
    return await _request
        .getJson(_urlNumeroCamasLivres + codigoEvento.toString());
  }

  Future<dynamic> getNumeroCamasOcupadas(int codigoEvento) async {
    return await _request
        .getJson(_urlNumeroCamasOcupadas + codigoEvento.toString());
  }

  Future<dynamic> getPessoasAChegar(int codigoEvento) async {
    return await _request
        .getJson(_urlGetPessoasAChegar + codigoEvento.toString());
  }

  Future<dynamic> getPessoasChegas(int codigoEvento) async {
    return await _request
        .getJson(_urlGetPessoasChegas + codigoEvento.toString());
  }

  Future<dynamic> getPessoasNaoVem(int codigoEvento) async {
    return await _request
        .getJson(_urlGetPessoasNaoVem + codigoEvento.toString());
  }

  Future<dynamic> getQuartoPessoaNaovem(int codigoEvento) async {
    return await _request.getJson("$_urlGetQuartoPessoaNaovem$codigoEvento");
  }

  Future<dynamic> getQuartoPessoaAChegar(
      int codigoQuarto, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetQuartoPessoaAChegar$codigoQuarto/$codigoEvento");
  }

  Future<dynamic> getQuartoPessoaChega(
      int codigoQuarto, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetQuartoPessoaChega$codigoQuarto/$codigoEvento");
  }

  Future<dynamic> getEventos() async {
    return await _request.getJson(_urlGetEventos);
  }
}

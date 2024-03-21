import '../../classes/classes.dart';
import '../data.dart';

class ApiDashboard {
  static final _request = HttpRequest();

  //GET
  final String _urlGetNumeroPessoasAChegar =
      "${Globais.urlBase}dashboard/numeroPessoasAChegar";
  final String _urlGetNumeroPessoasChegas =
      "${Globais.urlBase}dashboard/numeroPessoasChegas";
  final String _urlNumeroCamasLivres =
      "${Globais.urlBase}dashboard/numeroCamasLivres";
  final String _urlNumeroCamasOcupadas =
      "${Globais.urlBase}dashboard/numeroCamasOcupadas";
  final String _urlGetPessoasChegas =
      "${Globais.urlBase}dashboard/pessoasAChegar/";
  final String _urlGetPessoasAChegar =
      "${Globais.urlBase}dashboard/pessoasAChegar/";
  final String _urlGetQuartoPessoaAChegar =
      "${Globais.urlBase}dashboard/quartoPessoaAChegar/";
  final String _urlGetQuartoPessoaChega =
      "${Globais.urlBase}dashboard/quartoPessoaAChegar/";
  final String _urlGetEventos = "${Globais.urlBase}dashboard/eventos";

  //GET
  Future<dynamic> getNumeroPessoas() async {
    return await _request.getJson(_urlGetNumeroPessoasAChegar);
  }

  Future<dynamic> getNumeroPessoasChegas() async {
    return await _request.getJson(_urlGetNumeroPessoasChegas);
  }

  Future<dynamic> getNumeroCamasLivres() async {
    return await _request.getJson(_urlNumeroCamasLivres);
  }

  Future<dynamic> getNumeroCamasOcupadas() async {
    return await _request.getJson(_urlNumeroCamasOcupadas);
  }

  Future<dynamic> getPessoasAChegar(int codigoEvento) async {
    return await _request
        .getJson(_urlGetPessoasAChegar + codigoEvento.toString());
  }

  Future<dynamic> getPessoasChegas(int codigoEvento) async {
    return await _request
        .getJson(_urlGetPessoasChegas + codigoEvento.toString());
  }

  Future<dynamic> getQuartoPessoaAChegar(int codigoQuarto) async {
    return await _request
        .getJson(_urlGetQuartoPessoaAChegar + codigoQuarto.toString());
  }

  Future<dynamic> getQuartoPessoaChega(int codigoQuarto) async {
    return await _request
        .getJson(_urlGetQuartoPessoaChega + codigoQuarto.toString());
  }

  Future<dynamic> getEventos() async {
    return await _request.getJson(_urlGetEventos);
  }
}

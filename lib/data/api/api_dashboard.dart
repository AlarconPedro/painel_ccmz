import '../../classes/classes.dart';
import '../data.dart';

class ApiDashboard {
  static final _request = HttpRequest();

  //GET
  final String _urlGetNumeroPessoas =
      "${Globais.urlBase}dashboard/numeroPessoasAChegar";
  final String _urlGetPessoasAChegar =
      "${Globais.urlBase}dashboard/pessoasAChegar/";
  final String _urlGetEventos = "${Globais.urlBase}dashboard/eventos";

  //GET
  Future<dynamic> getNumeroPessoas() async {
    return await _request.getJson(_urlGetNumeroPessoas);
  }

  Future<dynamic> getPessoasAChegar(int codigoEvento) async {
    return await _request
        .getJson(_urlGetPessoasAChegar + codigoEvento.toString());
  }

  Future<dynamic> getEventos() async {
    return await _request.getJson(_urlGetEventos);
  }
}

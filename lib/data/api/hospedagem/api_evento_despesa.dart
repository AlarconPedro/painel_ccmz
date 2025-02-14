import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';
import '../../models/web/hospedagem/evento_despesas_model.dart';

class ApiEventoDespesa {
  final HttpRequest _request = HttpRequest();

  final String _urlGetEventoDespesas = "${Globais.urlBase}EventoDespesa/";

  final String _urlGetServicosEvento =
      "${Globais.urlBase}EventoDespesa/servicos/";

  final String _urlGetProdutosEvento =
      "${Globais.urlBase}EventoDespesa/produtos/";

  final String _urlPostEventoDespesa = "${Globais.urlBase}EventoDespesa/";

  final String _urlPutEventoDespesa = "${Globais.urlBase}EventoDespesa/";

  final String _urlDeleteEventoDespesa = "${Globais.urlBase}EventoDespesa/";

  Future<dynamic> getEventoDespesas(int codigoEvento) async {
    return await _request.getJson("$_urlGetEventoDespesas$codigoEvento");
  }

  Future<dynamic> getServicosEvento(int codigoEvento) async {
    return await _request.getJson("$_urlGetServicosEvento$codigoEvento");
  }

  Future<dynamic> getProdutosEvento(int codigoEvento) async {
    return await _request.getJson("$_urlGetProdutosEvento$codigoEvento");
  }

  Future<dynamic> postEventoDespesa(EventoDespesasModel despesa) async {
    return await _request.postJson(_urlPostEventoDespesa, despesa.toJson());
  }

  Future<dynamic> putEventoDespesa(EventoDespesasModel despesa) async {
    return await _request.putJson(_urlPutEventoDespesa, despesa.toJson());
  }

  Future<dynamic> deleteEventoDespesa(int codigo) async {
    return await _request.deleteJson("$_urlDeleteEventoDespesa$codigo");
  }
}

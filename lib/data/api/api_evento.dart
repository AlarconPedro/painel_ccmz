import 'package:painel_ccmz/classes/classes.dart';
import 'package:painel_ccmz/data/data.dart';

class ApiEvento {
  final _request = HttpRequest();

  //GET
  final String _urlGetEventos = "${Globais.urlBase}evento";
  final String _urlGetEvento = "${Globais.urlBase}evento/";
  final String _urlGetQuartosPavilhao = "${Globais.urlBase}evento/quartos/";
  final String _urlGetQuartosAlocados =
      "${Globais.urlBase}evento/quartos/alocados/";
  //POST
  final String _urlAddEvento = "${Globais.urlBase}evento";
  //PUT
  final String _urlUpdateEvento = "${Globais.urlBase}evento";
  //DELETE
  final String _urlDeleteEvento = "${Globais.urlBase}evento/";

  //GET
  Future<dynamic> getEventos() async {
    return await _request.getJson(_urlGetEventos);
  }

  Future<dynamic> getEvento(int codigoPavilhao, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetEvento/$codigoPavilhao/$codigoEvento");
  }

  Future<dynamic> getQuartosPavilhao(int codigoEvento) async {
    return await _request
        .getJson(_urlGetQuartosPavilhao + codigoEvento.toString());
  }

  Future<dynamic> getQuartosAlocados(int codigoEvento) async {
    return await _request
        .getJson(_urlGetQuartosAlocados + codigoEvento.toString());
  }

  //POST
  Future<dynamic> addEvento(EventoModel evento) async {
    return await _request.postJson(_urlAddEvento, evento.toJson());
  }

  //PUT
  Future<dynamic> updateEvento(EventoModel evento) async {
    return await _request.putJson(_urlUpdateEvento, evento.toJson());
  }

  //DELETE
  Future<dynamic> deleteEvento(int codigoEvento) async {
    return await _request
        .deleteJson(_urlDeleteEvento + codigoEvento.toString());
  }
}

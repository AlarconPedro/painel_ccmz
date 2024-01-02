import 'package:painel_ccmz/classes/classes.dart';
import 'package:painel_ccmz/data/data.dart';

class ApiEvento {
  final _request = HttpRequest();

  //GET
  final String _urlGetEventos = "${Globais.urlBase}evento";
  final String _urlGetEventoNomes = "${Globais.urlBase}evento/nomes";
  final String _urlGetEvento = "${Globais.urlBase}evento/";
  final String _urlGetPessoasEvento = "${Globais.urlBase}evento/pessoas/";
  final String _urlGetQuartosPavilhao = "${Globais.urlBase}evento/quartos/";
  final String _urlGetPessoasAlocadas =
      "${Globais.urlBase}evento/pessoas/alocadas";
  final String _urlGetQuartosAlocados =
      "${Globais.urlBase}evento/quartos/alocados";
  final String _urlGetPessoasQuarto =
      "${Globais.urlBase}evento/pessoas/quarto/";
  //POST
  final String _urlAddEvento = "${Globais.urlBase}evento";
  final String _urlAddPessoasEvento = "${Globais.urlBase}evento/pessoas/";
  final String _urlAddQuartoEvento = "${Globais.urlBase}evento/quartos/";
  //PUT
  final String _urlUpdateEvento = "${Globais.urlBase}evento";
  //DELETE
  final String _urlDeleteEvento = "${Globais.urlBase}evento/";

  //GET
  Future<dynamic> getEventos() async {
    return await _request.getJson(_urlGetEventos);
  }

  Future<dynamic> getEventoNomes() async {
    return await _request.getJson(_urlGetEventoNomes);
  }

  Future<dynamic> getEvento(int codigoPavilhao, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetEvento/$codigoPavilhao/$codigoEvento");
  }

  Future<dynamic> getPessoasEvento(int codigoComunidade) async {
    return await _request
        .getJson(_urlGetPessoasEvento + codigoComunidade.toString());
  }

  Future<dynamic> getQuartosPavilhao(int codigoEvento) async {
    return await _request
        .getJson(_urlGetQuartosPavilhao + codigoEvento.toString());
  }

  Future<dynamic> getQuartosAlocados(int codigoBloco, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetQuartosAlocados/$codigoBloco/$codigoEvento");
  }

  Future<dynamic> getPessoasAlocadas(
      int codigoComundiade, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetPessoasAlocadas/$codigoComundiade/$codigoEvento");
  }

  Future<dynamic> getPessoasQuarto(int codigoQuarto) async {
    return await _request
        .getJson(_urlGetPessoasQuarto + codigoQuarto.toString());
  }

  //POST
  Future<dynamic> addEvento(EventoModel evento) async {
    return await _request.postJson(_urlAddEvento, evento.toJson());
  }

  Future<dynamic> addPessoasEvento(
      List<EventoPessoasModel> pessoas, int codigoEvento) async {
    return await _request.postListJson(
        _urlAddPessoasEvento + codigoEvento.toString(), pessoas);
  }

  Future<dynamic> addQuartoEvento(
      List<EventoQuartoModel> quarto, int codigoBloco) async {
    return await _request.postListJson(
        _urlAddQuartoEvento + codigoBloco.toString(), quarto);
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

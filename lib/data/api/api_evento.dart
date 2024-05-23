import 'package:painel_ccmn/classes/classes.dart';
import 'package:painel_ccmn/data/data.dart';

class ApiEvento {
  final _request = HttpRequest();

  //GET
  final String _urlGetEventos = "${Globais.urlBase}evento/mes/";
  final String _urlGetEventosAtivos = "${Globais.urlBase}evento/ativos";
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
  final String _urlAddPessoasEvento = "${Globais.urlBase}evento/pessoas";
  final String _urlAddQuartoEvento = "${Globais.urlBase}evento/quartos/";
  //PUT
  final String _urlUpdateEvento = "${Globais.urlBase}evento";
  final String _urlUpdatePessoaEvento = "${Globais.urlBase}evento/pessoas";
  //DELETE
  final String _urlDeleteQuartoEvento = "${Globais.urlBase}evento/quarto/";
  final String _urlDeleteEvento = "${Globais.urlBase}evento/";
  final String _urlDeletePessoaEvento = "${Globais.urlBase}evento/pessoas";

  //GET
  Future<dynamic> getEventos(int mes) async {
    return await _request.getJson(_urlGetEventos + mes.toString());
  }

  Future<dynamic> getEventosAtivos() async {
    return await _request.getJson(_urlGetEventosAtivos);
  }

  Future<dynamic> getEventoNomes() async {
    return await _request.getJson(_urlGetEventoNomes);
  }

  // Future<dynamic> getEvento(int codigoPavilhao, int codigoEvento) async {
  //   return await _request
  //       .getJson("$_urlGetEvento/$codigoPavilhao/$codigoEvento");
  // }

  Future<dynamic> getEvento(int codigoEvento) async {
    return await _request.getJson("$_urlGetEvento$codigoEvento");
  }

  Future<dynamic> getPessoasEvento(
      int codigoComunidade, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetPessoasEvento$codigoComunidade/$codigoEvento");
  }

  Future<dynamic> getQuartosPavilhao(int codigoBloco, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetQuartosPavilhao$codigoBloco/$codigoEvento");
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

  Future<dynamic> getPessoasQuarto(int codigoQuarto, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetPessoasQuarto$codigoQuarto/$codigoEvento");
  }

  //POST
  Future<dynamic> addEvento(EventoModel evento) async {
    return await _request.postJson(_urlAddEvento, evento.toJson());
  }

  Future<dynamic> addPessoasEvento(
      List<EventoPessoasModel> pessoas, int codigoEvento) async {
    return await _request.postListJson(_urlAddPessoasEvento, pessoas);
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

  Future<dynamic> updatePessoaEvento(EventoPessoasModel pessoa) async {
    return await _request.putJson(_urlUpdatePessoaEvento, pessoa.toJson());
  }

  //DELETE
  Future<dynamic> deleteQuartoEvento(int codigoQuarto) async {
    return await _request
        .deleteJson(_urlDeleteQuartoEvento + codigoQuarto.toString());
  }

  Future<dynamic> deleteEvento(int codigoEvento) async {
    return await _request
        .deleteJson(_urlDeleteEvento + codigoEvento.toString());
  }

  Future<dynamic> deletePessoasEvento(List<EventoPessoasModel> pessoas) async {
    return await _request.deleteJson(_urlDeletePessoaEvento, pessoas: pessoas);
  }
}

import 'package:painel_ccmn/classes/classes.dart';
import 'package:painel_ccmn/data/data.dart';

class ApiAlocacao {
  static final _request = HttpRequest();

  //GET
  final String _urlGetEventosCheckin = "${Globais.urlBase}alocacao/eventos";
  final String _urlGetAlocacaoBlocos = "${Globais.urlBase}alocacao/blocos/";
  final String _urlGetAlocacaoComunidades =
      "${Globais.urlBase}alocacao/comunidades/";
  final String _urlGetPessoasComunidade =
      "${Globais.urlBase}alocacao/pessoas/comunidade/";
  final String _urlGetQuartosEvento = "${Globais.urlBase}alocacao/quartos/";
  //POST
  final String _urlAddPessoaQuarto = "${Globais.urlBase}alocacao/pessoa/quarto";
  //UPDATE
  final String _urlUpdatePessoaQuarto =
      "${Globais.urlBase}alocacao/pessoa/quarto";
  //DELETE
  final String _urlDeletePessoaQuarto =
      "${Globais.urlBase}alocacao/pessoa/quarto/";

  //GET
  Future<dynamic> getEventosCheckin(int filtro) async {
    return await _request.getJson("$_urlGetEventosCheckin/$filtro");
  }

  Future<dynamic> getAlocacaoBlocos(int codigoEvento) async {
    return await _request
        .getJson(_urlGetAlocacaoBlocos + codigoEvento.toString());
  }

  Future<dynamic> getAlocacaoComunidades(int codigoEvento) async {
    return await _request.getJson("$_urlGetAlocacaoComunidades$codigoEvento");
  }

  Future<dynamic> getPessoasComunidade(
      int codigoEvento, int codigoComunidade) async {
    return await _request
        .getJson("$_urlGetPessoasComunidade$codigoEvento/$codigoComunidade");
  }

  Future<dynamic> getQuartosEvento(int codigoEvento, int codigoBloco) async {
    return await _request
        .getJson("$_urlGetQuartosEvento$codigoEvento/$codigoBloco");
  }

  //POST
  Future<dynamic> addPessoaQuarto(AlocacaoModel alocacaoModel) async {
    return await _request.postJson(_urlAddPessoaQuarto, alocacaoModel.toJson());
  }

  //UPDATE
  Future<dynamic> updatePessoaQuarto(AlocacaoModel alocacaoModel) async {
    return await _request.putJson(
        _urlUpdatePessoaQuarto, alocacaoModel.toJson());
  }

  //DELETE
  Future<dynamic> deletePessoaQuarto(int codigoPessoa, int codigoEvento) async {
    return await _request
        .deleteJson("$_urlDeletePessoaQuarto$codigoPessoa/$codigoEvento");
  }
}

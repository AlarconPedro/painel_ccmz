import '../../../classes/classes.dart';
import '../../data.dart';
import '../../models/web/promocoes/cupom_model.dart';
import '../../models/web/promocoes/participante_model.dart';
import '../../models/web/promocoes/promocao_model.dart';
import '../../models/web/promocoes/sorteio_model.dart';

class ApiPromocao {
  static final _request = HttpRequest();

  //GET
  final String _urlGetPromocoes = "${Globais.urlBase}promocao";
  final String _urlGetGanhadorCupom = "${Globais.urlBase}promocao/ganhador";
  final String _urlGetSorteiosPromocao = "${Globais.urlBase}promocao/sorteios";
  final String _urlGetCuponsPromocao = "${Globais.urlBase}promocao/cupons";
  final String _urlGetParticipantesPromocao =
      "${Globais.urlBase}promocao/participantes";
  final String _urlSortearCupom = "${Globais.urlBase}promocao/sortear/cupom";

  //POST
  final String _urlAddPromocao = "${Globais.urlBase}promocao";
  final String _urlAddSorteioPromocao = "${Globais.urlBase}sorteio";
  final String _urlAddCupomPromocao = "${Globais.urlBase}promocao/cupom";
  final String _urlAddParticipantePromocao =
      "${Globais.urlBase}promocao/participante";

  //UPDATE
  final String _urlUpdatePromocao = "${Globais.urlBase}promocao";
  final String _urlUpdateSorteioPromocao = "${Globais.urlBase}sorteio";
  final String _urlUpdateCupomPromocao = "${Globais.urlBase}promocao/cupom";
  final String _urlUpdateParticipantePromocao =
      "${Globais.urlBase}promocao/participante";

  //DELETE
  final String _urlDeletePromocao = "${Globais.urlBase}promocao/";
  final String _urlDeleteSorteioPromocao = "${Globais.urlBase}sorteio/";
  final String _urlDeleteCupomPromocao = "${Globais.urlBase}promocao/cupom/";
  final String _urlDeleteParticipantePromocao =
      "${Globais.urlBase}promocao/participante/";

  //GET
  Future<dynamic> getPromocoes() async {
    return await _request.getJson(_urlGetPromocoes);
  }

  Future<dynamic> getGanhadorCupom(String filtro,
      {String? cupom, int? skip = 0, int? take = 30}) async {
    return await _request.getJson(
        "$_urlGetGanhadorCupom/$filtro/$skip/$take${cupom != null ? "?codigoCupom=$cupom" : ""}");
  }

  Future<dynamic> getSorteiosPromocao() async {
    return await _request.getJson(_urlGetSorteiosPromocao);
  }

  Future<dynamic> getCuponsPromocao() async {
    return await _request.getJson(_urlGetCuponsPromocao);
  }

  Future<dynamic> getParticipantesPromocao(int codigoPromocao) async {
    return await _request
        .getJson("$_urlGetParticipantesPromocao/$codigoPromocao");
  }

  Future<dynamic> sortearCupom(String codigoCupom) async {
    return await _request.getJson("$_urlSortearCupom/$codigoCupom");
  }

  //POST
  Future<dynamic> addPromocao(PromocaoModel promocao) async {
    return await _request.postJson(_urlAddPromocao, promocao.toMap());
  }

  Future<dynamic> addSorteioPromocao(SorteioModel sorteio) async {
    return await _request.postJson(_urlAddSorteioPromocao, sorteio.toMap());
  }

  Future<dynamic> addCupomPromocao(CupomModel cupom) async {
    return await _request.postJson(_urlAddCupomPromocao, cupom.toMap());
  }

  Future<dynamic> addParticipantePromocao(
      ParticipanteModel participante) async {
    return await _request.postJson(
        _urlAddParticipantePromocao, participante.toMap());
  }

  //UPDATE
  Future<dynamic> updatePromocao(PromocaoModel promocao) async {
    return await _request.putJson(_urlUpdatePromocao, promocao.toMap());
  }

  Future<dynamic> updateSorteioPromocao(SorteioModel sorteio) async {
    return await _request.putJson(_urlUpdateSorteioPromocao, sorteio.toMap());
  }

  Future<dynamic> updateCupomPromocao(CupomModel cupom) async {
    return await _request.putJson(_urlUpdateCupomPromocao, cupom.toMap());
  }

  Future<dynamic> updateParticipantePromocao(
      ParticipanteModel participante) async {
    return await _request.putJson(
        _urlUpdateParticipantePromocao, participante.toMap());
  }

  //DELETE
  Future<dynamic> deletePromocao(int codigoPromocao) async {
    return await _request
        .deleteJson(_urlDeletePromocao + codigoPromocao.toString());
  }

  Future<dynamic> deleteSorteioPromocao(int codigoSorteio) async {
    return await _request
        .deleteJson(_urlDeleteSorteioPromocao + codigoSorteio.toString());
  }

  Future<dynamic> deleteCupomPromocao(int codigoCupom) async {
    return await _request
        .deleteJson(_urlDeleteCupomPromocao + codigoCupom.toString());
  }

  Future<dynamic> deleteParticipantePromocao(int codigoParticipante) async {
    return await _request.deleteJson(
        _urlDeleteParticipantePromocao + codigoParticipante.toString());
  }
}

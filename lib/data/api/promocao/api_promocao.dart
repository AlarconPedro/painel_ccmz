import '../../../classes/classes.dart';
import '../../data.dart';
import '../../models/web/promocoes/cupom_model.dart';
import '../../models/web/promocoes/participante_model.dart';
import '../../models/web/promocoes/premios_mode.dart';
import '../../models/web/promocoes/promocao_model.dart';
import '../../models/web/promocoes/sorteio_model.dart';

class ApiPromocao {
  static final _request = HttpRequest();

  //GET
  final String _urlGetPromocoes = "${Globais.urlBase}promocao";
  final String _urlGetPromocao = "${Globais.urlBase}promocao/";
  final String _urlGetGanhadorCupom = "${Globais.urlBase}promocao/cupons";
  final String _urlGetSorteiosPromocao = "${Globais.urlBase}promocao/sorteios";
  final String _urlGetSorteio = "${Globais.urlBase}promocao/sorteio";
  final String _urlGetPremiosPromocao = "${Globais.urlBase}promocao/premios";
  final String _urlGetCuponsPromocao = "${Globais.urlBase}promocao/cupons";
  final String _urlGetParticipantesPromocao =
      "${Globais.urlBase}promocao/participantes";
  final String _urlSortearCupom = "${Globais.urlBase}promocao/sortear/cupom";

  //POST
  final String _urlAddPromocao = "${Globais.urlBase}promocao";
  final String _urlAddSorteioPromocao = "${Globais.urlBase}promocao/sorteios";
  final String _urlAddPremioPromocao = "${Globais.urlBase}promocao/premios";
  final String _urlAddCupomPromocao = "${Globais.urlBase}promocao/cupom";
  final String _urlAddParticipantePromocao =
      "${Globais.urlBase}promocao/participante";

  //UPDATE
  final String _urlUpdatePromocao = "${Globais.urlBase}promocao";
  final String _urlUpdateSorteioPromocao =
      "${Globais.urlBase}promocao/sorteios";
  final String _urlUpdateCupomPromocao = "${Globais.urlBase}promocao/cupom";
  final String _urlUpdateParticipantePromocao =
      "${Globais.urlBase}promocao/participante";

  //DELETE
  final String _urlDeletePromocao = "${Globais.urlBase}promocao/";
  final String _urlDeleteSorteioPromocao = "${Globais.urlBase}sorteio/";
  final String _urlDeletePremio = "${Globais.urlBase}promocao/premio/";
  final String _urlDeleteCupomPromocao = "${Globais.urlBase}promocao/cupom/";
  final String _urlDeleteParticipantePromocao =
      "${Globais.urlBase}promocao/participantes/";

  //GET
  Future<dynamic> getPromocoes(String filtro) async {
    return await _request.getJson("$_urlGetPromocoes/$filtro");
  }

  Future<dynamic> getPromocao(int codigoPromocao) async {
    return await _request.getJson("$_urlGetPromocao$codigoPromocao");
  }

  Future<dynamic> getCupons(String filtro,
      {String? busca, int? skip = 0, int? take = 30}) async {
    return await _request.getJson(
        "$_urlGetGanhadorCupom/$filtro/$skip/$take${busca != null ? "?busca=$busca" : ""}");
  }

  Future<dynamic> getSorteio(int codigoSorteio) async {
    return await _request.getJson("$_urlGetSorteio/$codigoSorteio");
  }

  Future<dynamic> getSorteiosPromocao() async {
    return await _request.getJson(_urlGetSorteiosPromocao);
  }

  Future<dynamic> getPremiosPromocao(int codigoPromocao) async {
    return await _request.getJson("$_urlGetPremiosPromocao/$codigoPromocao");
  }

  Future<dynamic> getCuponsPromocao() async {
    return await _request.getJson(_urlGetCuponsPromocao);
  }

  Future<dynamic> getParticipantesPromocao(
      int codigoPromocao, String busca) async {
    return await _request
        .getJson("$_urlGetParticipantesPromocao/$codigoPromocao/$busca");
  }

  Future<dynamic> sortearCupom(String codigoCupom, int codigoSorteio) async {
    return await _request
        .getJson("$_urlSortearCupom/$codigoCupom/$codigoSorteio");
  }

  //POST
  Future<dynamic> addPromocao(PromocaoModel promocao) async {
    return await _request.postJson(_urlAddPromocao, promocao.toMap());
  }

  Future<dynamic> addSorteioPromocao(SorteioModel sorteio) async {
    return await _request.postJson(_urlAddSorteioPromocao, sorteio.toMap());
  }

  Future<dynamic> addPremioPromocao(PremiosModel premio) async {
    return await _request.postJson(_urlAddPremioPromocao, premio.toMap());
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

  Future<dynamic> deletePremioPromocao(int codigoPremio) async {
    return await _request
        .deleteJson(_urlDeletePremio + codigoPremio.toString());
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

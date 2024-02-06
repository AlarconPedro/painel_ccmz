import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/data/models/checkin_model.dart';

import '../../classes/classes.dart';
import '../models/quarto_pessoas_model.dart';

class ApiCheckin {
  static final _request = HttpRequest();

  //GET
  final String _urlGetCheckinQuartos = "${Globais.urlBase}QuartoPessoa/";
  final String _urlGetCheckinQuartosBusca = "${Globais.urlBase}QuartoPessoa/";

  //POST
  //UPDATE
  final String _urlUpdateCheckin = "${Globais.urlBase}QuartoPessoa/";

  //GET
  Future<dynamic> getCheckinQuartos(int codigoBloco, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetCheckinQuartos$codigoBloco/$codigoEvento");
  }

  Future<dynamic> getCheckinQuartosBusca(int codigoEvento, String busca) async {
    return await _request
        .getJson("$_urlGetCheckinQuartosBusca$codigoEvento/$busca");
  }

  //POST
  //UPDATE
  Future<dynamic> updateCheckin(CheckinModel dados) async {
    return await _request.putJson(_urlUpdateCheckin, dados.toJson());
  }
}

import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/checkin_model.dart';

import '../../../classes/classes.dart';
import '../../models/web/hospedagem/quarto_pessoas_model.dart';

class ApiCheckin {
  static final _request = HttpRequest();

  //GET
  final String _urlGetCheckinQuartos = "${Globais.urlBase}Checkin/";
  final String _urlGetCheckinQuartosBusca = "${Globais.urlBase}Checkin/";

  //POST
  //UPDATE
  final String _urlUpdateCheckin = "${Globais.urlBase}Checkin/";

  //GET
  Future<dynamic> getCheckinQuartos(int codigoEvento) async {
    return await _request.getJson("$_urlGetCheckinQuartos$codigoEvento");
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

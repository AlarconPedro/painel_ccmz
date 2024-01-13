import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class ApiCheckin {
  static final _request = HttpRequest();

  //GET
  final String _urlGetCheckinQuartos = "${Globais.urlBase}QuartoPessoa/";

  //GET
  Future<dynamic> getCheckinQuartos(int codigoBloco, int codigoEvento) async {
    return await _request
        .getJson("$_urlGetCheckinQuartos/$codigoBloco/$codigoEvento");
  }
}

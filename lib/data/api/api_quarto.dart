import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class ApiQuarto {
  static final _request = HttpRequest();

  //GET
  final String _urlGetQuartos = "${Globais.urlBase}quarto";
  final String _urlGetQuarto = "${Globais.urlBase}quarto/";

  //POST
  final String _urlAddQuarto = "${Globais.urlBase}quarto";

  //UPDATE
  final String _urlUpdateQuarto = "${Globais.urlBase}quarto";

  //DELETE
  final String _urlDeleteQuarto = "${Globais.urlBase}quarto/";

  //GET
  Future<dynamic> getQuartos() async {
    return await _request.getJson(_urlGetQuartos);
  }

  Future<dynamic> getQuarto(int codigoQuarto) async {
    return await _request.getJson(_urlGetQuarto + codigoQuarto.toString());
  }

  //POST
  Future<dynamic> addQuarto(QuartoModel quarto) async {
    return await _request.postJson(_urlAddQuarto, quarto.toMap());
  }

  //UPDATE
  Future<dynamic> updateQuarto(QuartoModel quarto) async {
    return await _request.putJson(_urlUpdateQuarto, quarto.toMap());
  }

  //DELETE
  Future<dynamic> deleteQuarto(int codigoQuarto) async {
    return await _request
        .deleteJson(_urlDeleteQuarto + codigoQuarto.toString());
  }
}

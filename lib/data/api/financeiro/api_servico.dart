import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';
import '../../models/web/hospedagem/servicos_model.dart';

class ApiServico {
  final HttpRequest _request = HttpRequest();

  final String _urlGetServicos = "${Globais.urlBase}Servico";

  final String _urlPostServico = "${Globais.urlBase}Servico";

  final String _urlPutServico = "${Globais.urlBase}Servico";

  final String _urlDeleteServico = "${Globais.urlBase}Servico/";

  Future<dynamic> getServicos() async =>
      await _request.getJson(_urlGetServicos);

  Future<dynamic> postServico(ServicosModel servico) async =>
      await _request.postJson(_urlPostServico, servico.toJson());

  Future<dynamic> putServico(ServicosModel servico) async =>
      await _request.putJson(_urlPutServico, servico.toJson());

  Future<dynamic> deleteServico(int codigo) async =>
      await _request.deleteJson("$_urlDeleteServico$codigo");
}

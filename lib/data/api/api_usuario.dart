import 'package:painel_ccmn/classes/classes.dart';
import 'package:painel_ccmn/data/data.dart';

class ApiUsuario {
  static final _request = HttpRequest();

  //GET
  final String _urlLoginSistema = '${Globais.urlBase}Usuario/';
  final String _urlBuscarUsuarios = '${Globais.urlBase}Usuario';

  //POST
  final String _urlGravarUsuario = '${Globais.urlBase}Usuario';

  //UPDATE
  final String _urlAtualizarUsuario = '${Globais.urlBase}Usuario';

  //DELETE
  final String _urlExcluirUsuario = '${Globais.urlBase}Usuario';

  Future<dynamic> loginSistema(String codigoFirebase) async {
    var retorno = await _request.getJson("$_urlLoginSistema$codigoFirebase");
    return retorno;
  }

  Future<dynamic> getUsuarios() async {
    return await _request.getJson(_urlBuscarUsuarios);
  }

  Future<dynamic> gravarUsuario(UsuarioModel usuario) async {
    return await _request.postJson(_urlGravarUsuario, usuario.toJson());
  }

  Future<dynamic> atualizarUsuario(UsuarioModel usuario) async {
    return await _request.putJson(_urlAtualizarUsuario, usuario.toJson());
  }

  Future<dynamic> excluirUsuario(int codigoUsuario) async {
    return await _request.deleteJson("$_urlExcluirUsuario/$codigoUsuario");
  }
}

import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class ApiPessoas {
  static final _request = HttpRequest();

  //GET
  final String _urlGetPessoas = "${Globais.urlBase}pessoa";
  final String _urlGetPessoa = "${Globais.urlBase}pessoa/";
  final String _urlGetPessoaDetalhe = "${Globais.urlBase}pessoa/detalhes/";
  //POST
  final String _urlAddPessoa = "${Globais.urlBase}pessoa";
  //UPDATE
  final String _urlUpdatePessoa = "${Globais.urlBase}pessoa";
  //DELETE
  final String _urlDeletePessoa = "${Globais.urlBase}pessoa/";

  //GET
  Future<dynamic> getPessoas() async {
    return await _request.getJson(_urlGetPessoas);
  }

  Future<dynamic> getPessoa(int codigoPessoa) async {
    return await _request.getJson(_urlGetPessoa + codigoPessoa.toString());
  }

  Future<dynamic> getPessoaDetalhe(int codigoPessoa) async {
    return await _request
        .getJson(_urlGetPessoaDetalhe + codigoPessoa.toString());
  }
  //POST
}

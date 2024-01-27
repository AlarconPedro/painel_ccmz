import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class ApiPessoas {
  static final _request = HttpRequest();

  //GET
  final String _urlGetPessoa = "${Globais.urlBase}pessoa/";
  final String _urlGetPessoas = "${Globais.urlBase}pessoa/comunidade";
  final String _urlGetPessoasBusca = "${Globais.urlBase}pessoa/comunidade/";
  final String _urlGetPessoaDetalhe = "${Globais.urlBase}pessoa/detalhes/";
  //POST
  final String _urlAddPessoa = "${Globais.urlBase}pessoa";
  //UPDATE
  final String _urlUpdatePessoa = "${Globais.urlBase}pessoa";
  //DELETE
  final String _urlDeletePessoa = "${Globais.urlBase}pessoa/";

  //GET
  Future<dynamic> getPessoas(int codigoComunidade) async {
    return await _request.getJson("$_urlGetPessoas/$codigoComunidade");
  }

  Future<dynamic> getPessoasBusca(int codigoComunidade, String busca) async {
    return await _request
        .getJson("$_urlGetPessoasBusca$codigoComunidade/busca/$busca");
  }

  Future<dynamic> getPessoa(int codigoPessoa) async {
    return await _request.getJson(_urlGetPessoa + codigoPessoa.toString());
  }

  Future<dynamic> getPessoaDetalhe(int codigoPessoa) async {
    return await _request
        .getJson(_urlGetPessoaDetalhe + codigoPessoa.toString());
  }

  //POST
  Future<dynamic> addPessoa(PessoaModel pessoa) async {
    return await _request.postJson(_urlAddPessoa, pessoa.toJson());
  }

  //UPDATE
  Future<dynamic> updatePessoa(PessoaModel pessoa) async {
    return await _request.putJson(_urlUpdatePessoa, pessoa.toJson());
  }

  //DELETE
  Future<dynamic> deletePessoa(int codigoPessoa) async {
    return await _request
        .deleteJson(_urlDeletePessoa + codigoPessoa.toString());
  }
}

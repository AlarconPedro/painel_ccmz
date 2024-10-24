import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/cores.dart';
import '../../../data/data.dart';

class Pessoas extends StatefulWidget {
  const Pessoas({super.key});

  @override
  State<Pessoas> createState() => _PessoasState();
}

class _PessoasState extends State<Pessoas> {
  bool carregando = false;

  List<PessoaModel> pessoas = [];

  List<String> cidades = [];
  List<DropdownMenuItem<int>> cidadesListagem = [
    const DropdownMenuItem(
      value: 0,
      child: Text("Todos"),
    ),
  ];
  List<DropdownMenuItem<int>> comunidades = [];

  TextEditingController campoBusca = TextEditingController();

  int cidadeSelecionada = 0;
  int codigoComunidade = 0;

  buscarPessoas(int comunidade, {String? cidade = "Todos"}) async {
    setState(() => carregando = true);
    var retorno = await ApiPessoas().getPessoas(comunidade, cidade!);
    if (retorno.statusCode == 200) {
      pessoas.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          pessoas.add(PessoaModel.fromJson(item));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarCidades() async {
    setState(() => carregando = true);
    var retorno = await ApiComunidade().getCidades();
    if (retorno.statusCode == 200) {
      cidades.clear();
      var decoded = json.decode(retorno.body);
      cidades.add("Todos");
      for (var item in decoded) {
        setState(() {
          cidades.add(item);
        });
      }
      for (var i = 1; i < cidades.length; i++) {
        setState(() {
          cidadesListagem.add(
            DropdownMenuItem(
              value: i,
              child: Text(cidades[i]),
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarComunidades({String? cidade}) async {
    setState(() => carregando = true);
    // var retorno = await ApiComunidade().getComunidadesNomes();
    var retorno = await ApiPessoas().getComunidades(cidade ?? "Todos");
    if (retorno.statusCode == 200) {
      comunidades.clear();
      for (var item in json.decode(retorno.body)) {
        setState(() {
          comunidades.add(
            cidade == "Todos"
                ? DropdownMenuItem(
                    value: item['comCodigo'],
                    child: Text(item['comNome'] +
                        " - " +
                        item['comCidade'] +
                        " - " +
                        item['comUf']),
                  )
                : DropdownMenuItem(
                    value: item['comCodigo'],
                    child: Text(item['comNome']),
                  ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarComunidadeCampoBusca(String busca) async {
    setState(() => carregando = true);
    var retorno = await ApiPessoas().getPessoasBusca(codigoComunidade, busca);
    if (retorno.statusCode == 200) {
      pessoas.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          pessoas.add(PessoaModel.fromJson(item));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  excluirPessoa(int codigoPessoa) async {
    setState(() => carregando = true);
    var retorno = await ApiPessoas().deletePessoa(codigoPessoa);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Pessoa excluída com sucesso !"),
        ),
      );
      buscarPessoas(codigoComunidade);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao excluir pessoa !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarComunidades();
    buscarCidades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
            color: Cores.branco,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Cores.branco,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Buscar: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: CupertinoTextField(
                              controller: campoBusca,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              placeholder: 'Pesquisar',
                              onSubmitted: (value) async {
                                if (value != "") {
                                  await buscarComunidadeCampoBusca(value);
                                  campoBusca.clear();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CupertinoButton(
                          color: Cores.preto,
                          onPressed: () async {
                            if (campoBusca.text != "") {
                              await buscarComunidadeCampoBusca(campoBusca.text);
                              campoBusca.clear();
                            }
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          child: const Icon(CupertinoIcons.search),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Flexible(
                        child: DropDownForm(
                          label: "Cidade",
                          itens: cidadesListagem,
                          selecionado: cidadeSelecionada,
                          onChange: (value) {
                            setState(() {
                              cidadeSelecionada = value;
                              codigoComunidade = 0;
                            });
                            buscarComunidades(
                                cidade: cidades[cidadeSelecionada]);
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Flexible(
                        child: DropDownForm(
                          label: "Comunidade",
                          itens: comunidades,
                          selecionado: codigoComunidade,
                          onChange: (value) {
                            setState(() => codigoComunidade = value);
                            buscarPessoas(value,
                                cidade: cidades[cidadeSelecionada]);
                          },
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      const Text(
                        'Pessoas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        color: Cores.verdeMedio,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 30,
                        ),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            CupertinoDialogRoute(
                              builder: (context) {
                                return CadastroPessoas();
                              },
                              context: context,
                            ),
                          );
                          buscarPessoas(codigoComunidade);
                        },
                        child: const Text("Nova Pessoa"),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Cores.preto,
                    ),
                  ),
                  const Row(children: [
                    SizedBox(width: 55),
                    Expanded(
                      flex: 4,
                      child: Text(
                        "Nome",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Sexo",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 50),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Comuniade",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 50),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Responsável",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("Catequista",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text("Salmista",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Text("Excluir",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 25),
                  ]),
                  codigoComunidade == 0
                      ? const Expanded(
                          child: Center(
                            child: Text(
                              "Selecione uma comunidade",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : carregando
                          ? const Expanded(
                              child: Center(child: CarregamentoIOS()))
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: ListView.builder(
                                  itemCount: pessoas.length,
                                  itemBuilder: (context, index) {
                                    return MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            CupertinoDialogRoute(
                                              builder: (context) {
                                                return CadastroPessoas(
                                                  pessoa: pessoas[index],
                                                );
                                              },
                                              context: context,
                                            ),
                                          );
                                          buscarPessoas(codigoComunidade);
                                        },
                                        child: CardPessoa(
                                          pessoa: pessoas[index],
                                          excluir: () {
                                            excluirPessoa(
                                                pessoas[index].pesCodigo);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

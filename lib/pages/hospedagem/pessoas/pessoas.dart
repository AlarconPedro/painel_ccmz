import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/telas/modelo_listagem_cadastro.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/cores.dart';
import '../../../data/data.dart';
import '../../../widgets/cards/btn_opcoes_card.dart';
import '../../../widgets/cards/card_listagem_pessoas.dart';

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
    return modeloListagemCadastro(
      fncBusca: buscarComunidadeCampoBusca,
      fncAbrirCadastro: () async {
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
      ctlrBusca: campoBusca,
      listaDados: pessoas,
      filtros: Padding(
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
                buscarComunidades(cidade: cidades[cidadeSelecionada]);
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
                buscarPessoas(value, cidade: cidades[cidadeSelecionada]);
              },
            ),
          ),
        ]),
      ),
      cardListagem: (dados) {
        PessoaModel pessoa = dados;
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              CupertinoDialogRoute(
                builder: (context) {
                  return CadastroPessoas(pessoa: pessoa);
                },
                context: context,
              ),
            );
            buscarPessoas(codigoComunidade);
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: CardListagemPessoas(
              context: context,
              camposCard: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                      flex: 4,
                      child: Text(pessoa.pesNome,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text(pessoa.pesGenero,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(width: 50),
                  Expanded(
                      flex: 2,
                      child: Text(pessoa.comunidade,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(width: 50),
                  Expanded(
                      flex: 2,
                      child: Text(pessoa.pesResponsavel,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text(pessoa.pesCatequista,
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                  Text(pessoa.pesCatequista,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 25),
                ],
              ),
              icone: CupertinoIcons.person,
              btnsOpcoes: [
                BtnOpcoesCard(
                  icone: CupertinoIcons.trash,
                  cor: Cores.vermelhoMedio,
                  dialog: () => showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text("Excluir Pessoa"),
                        content: const Text(
                            "Deseja realmente excluir esta pessoa ?"),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text("Não",
                                style: TextStyle(color: Cores.vermelhoMedio)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text("Sim",
                                style: TextStyle(color: Cores.verdeMedio)),
                            onPressed: () {
                              Navigator.pop(context);
                              excluirPessoa(pessoa.pesCodigo);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      tituloColunas: const Row(
        children: [
          SizedBox(width: 30),
          Expanded(
              flex: 4,
              child:
                  Text("Nome", style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 40),
          Expanded(
              flex: 2,
              child: Text("Gênero",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 20),
          Expanded(
              flex: 2,
              child: Text("Comunidade",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 50),
          Expanded(
              flex: 2,
              child: Text("Responsável",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 2,
              child: Text("Catequista",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              child: Text("Catequizando",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 25),
        ],
      ),
      titulo: "Pessoas",
      btnTitulo: "Nova Pessoa",
      carregando: carregando,
      context: context,
    );
  }
}

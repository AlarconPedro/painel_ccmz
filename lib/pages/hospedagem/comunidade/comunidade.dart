import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/telas/modelo_listagem_cadastro.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/classes.dart';

class Comunidade extends StatefulWidget {
  const Comunidade({super.key});

  @override
  State<Comunidade> createState() => _ComunidadeState();
}

class _ComunidadeState extends State<Comunidade> {
  List<ComunidadeModel> comunidades = [];

  bool carregando = false;

  List<DropdownMenuItem<int>> cidades = [];

  String cidadeSelecionada = "Todos";
  List<Map<int, String>> cidadesList = [];

  buscarCidades() async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiComunidade().getCidades();
    if (retorno.statusCode == 200) {
      cidades.clear();
      cidades.add(const DropdownMenuItem(
        value: 0,
        child: Text("Todos"),
      ));
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          cidades.add(DropdownMenuItem(
            value: decoded.indexOf(item) + 1,
            child: Text(item),
          ));
          cidadesList.add({decoded.indexOf(item) + 1: item});
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer cidades !"),
        ),
      );
    }
    setState(() {
      carregando = false;
    });
  }

  buscarComunidades(String cidade) async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiComunidade().getComunidades(cidade);
    if (retorno.statusCode == 200) {
      comunidades.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          comunidades.add(ComunidadeModel.fromJson(item));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer comunidades !"),
        ),
      );
    }
    setState(() {
      carregando = false;
    });
  }

  deleteComunidade(int codigoComunidade) async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiComunidade().deleteComunidade(codigoComunidade);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Comunidade excluida com sucesso !"),
        ),
      );
      buscarComunidades(cidadeSelecionada);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao excluir comunidade !"),
        ),
      );
    }
    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarCidades();
    buscarComunidades(cidadeSelecionada);
  }

  @override
  Widget build(BuildContext context) {
    return modeloListagemCadastro(
        fncBusca: (busca) {},
        fncAbrirCadastro: () async {
          await Navigator.push(
            context,
            CupertinoDialogRoute(
              builder: (context) {
                return CadastroComunidade();
              },
              context: context,
            ),
          );
          buscarComunidades(cidadeSelecionada);
        },
        ctlrBusca: TextEditingController(),
        listaDados: comunidades,
        cardListagem: (comunidade) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  CupertinoDialogRoute(
                    builder: (context) {
                      return CadastroComunidade(
                        comunidade: comunidade,
                      );
                    },
                    context: context,
                  ),
                );
                buscarComunidades(cidadeSelecionada);
              },
              child: CardComunidade(
                comunidade: comunidade,
                excluir: () {
                  deleteComunidade(comunidade.comCodigo);
                },
              ),
            ),
          );
        },
        tituloColunas: Row(
          children: [
            const SizedBox(width: 50),
            const Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(flex: 4, child: Container()),
            const SizedBox(width: 15),
            const Text("Cidade", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(flex: 2, child: Container()),
            const Text("UF", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(flex: 2, child: Container()),
            const Text("Qtd. Pessoas",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(flex: 2, child: Container()),
            const SizedBox(width: 20),
            const Text("Excluir",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 20),
          ],
        ),
        titulo: "Comunidade",
        btnTitulo: "Nova Comunidade",
        filtros: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Flexible(
              child: DropDownForm(
                label: "Cidade",
                itens: cidades,
                selecionado: cidadesList.indexWhere((element) =>
                        element.values.first == cidadeSelecionada) +
                    1,
                onChange: (value) {
                  // String cidade = cidades[value]
                  //     .child
                  //     .toString()
                  //     .replaceAll("Text", "")
                  //     .replaceAll('("', "")
                  //     .replaceAll('")', "")
                  //     .replaceAll('"', "");
                  setState(() {
                    cidadeSelecionada = value == 0
                        ? "Todos"
                        : cidadesList[value - 1].values.first;
                  });
                  buscarComunidades(cidadeSelecionada);
                },
              ),
            ),
            const Spacer(),
            const Spacer(),
          ]),
        ),
        carregando: carregando,
        context: context);
    // return Esqueleto(
    //   tituloBoto: "Nova Comunidade",
    //   tituloPagina: "Comunidade",
    //   filtro: true,
    //   itens: cidades,
    //   label: "Cidade",
    //   onChange: (value) {
    //     // String cidade = cidades[value]
    //     //     .child
    //     //     .toString()
    //     //     .replaceAll("Text", "")
    //     //     .replaceAll('("', "")
    //     //     .replaceAll('")', "")
    //     //     .replaceAll('"', "");
    //     setState(() {
    //       cidadeSelecionada =
    //           value == 0 ? "Todos" : cidadesList[value - 1].values.first;
    //     });
    //     buscarComunidades(cidadeSelecionada);
    //   },
    //   abrirTelaCadastro: () async {
    //     await Navigator.push(
    //       context,
    //       CupertinoDialogRoute(
    //         builder: (context) {
    //           return CadastroComunidade();
    //         },
    //         context: context,
    //       ),
    //     );
    //     buscarComunidades(cidadeSelecionada);
    //   },
    //   buscaNome: (busca) {},
    //   corpo: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20),
    //       child: Row(
    //         children: [
    //           const SizedBox(width: 40),
    //           const Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
    //           Expanded(flex: 4, child: Container()),
    //           const SizedBox(width: 15),
    //           const Text("Cidade",
    //               style: TextStyle(fontWeight: FontWeight.bold)),
    //           Expanded(flex: 2, child: Container()),
    //           const Text("UF", style: TextStyle(fontWeight: FontWeight.bold)),
    //           Expanded(flex: 2, child: Container()),
    //           const Text("Qtd. Pessoas",
    //               style: TextStyle(fontWeight: FontWeight.bold)),
    //           Expanded(flex: 2, child: Container()),
    //           const SizedBox(width: 20),
    //           const Text("Excluir",
    //               style: TextStyle(fontWeight: FontWeight.bold)),
    //         ],
    //       ),
    //     ),
    //     // const SizedBox(height: 10),
    //     carregando
    //         ? const Flexible(child: Center(child: CarregamentoIOS()))
    //         : listarDados(
    //             dados: comunidades,
    //             cardListagem: (dados) => MouseRegion(
    //                   cursor: SystemMouseCursors.click,
    //                   child: GestureDetector(
    //                     onTap: () async {
    //                       await Navigator.push(
    //                         context,
    //                         CupertinoDialogRoute(
    //                           builder: (context) {
    //                             return CadastroComunidade(
    //                               comunidade: dados,
    //                             );
    //                           },
    //                           context: context,
    //                         ),
    //                       );
    //                       buscarComunidades(cidadeSelecionada);
    //                     },
    //                     child: CardComunidade(
    //                       comunidade: dados,
    //                       excluir: () => deleteComunidade(dados.comCodigo),
    //                     ),
    //                   ),
    //                 ),
    //             textoVazio: "Nenhuma comunidade encontrada !"),
    //     // Flexible(
    //     //     fit: FlexFit.tight,
    //     //     child: Padding(
    //     //       padding: const EdgeInsets.symmetric(horizontal: 10),
    //     //       child: ListView.builder(
    //     //         itemCount: comunidades.length,
    //     //         itemBuilder: (context, index) {
    //     //           return MouseRegion(
    //     //             cursor: SystemMouseCursors.click,
    //     //             child: GestureDetector(
    //     //               onTap: () async {
    //     //                 await Navigator.push(
    //     //                   context,
    //     //                   CupertinoDialogRoute(
    //     //                     builder: (context) {
    //     //                       return CadastroComunidade(
    //     //                         comunidade: comunidades[index],
    //     //                       );
    //     //                     },
    //     //                     context: context,
    //     //                   ),
    //     //                 );
    //     //                 buscarComunidades(cidadeSelecionada);
    //     //               },
    //     //               child: CardComunidade(
    //     //                 comunidade: comunidades[index],
    //     //                 excluir: () {
    //     //                   deleteComunidade(comunidades[index].comCodigo);
    //     //                 },
    //     //               ),
    //     //             ),
    //     //           );
    //     //         },
    //     //       ),
    //     //     ),
    //     //   ),
    //   ],
    // );
  }
}

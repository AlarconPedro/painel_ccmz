import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/produto_model.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../../classes/classes.dart';
import '../../../data/api/hospedagem/api_produtos.dart';

class Produtos extends StatefulWidget {
  bool? selecionarProduto;

  Function? selecionar;

  Produtos({
    super.key,
    this.selecionarProduto = false,
    this.selecionar,
  });

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  List<ProdutoModel> produtos = [];

  bool carregando = false;

  int produtoSelecionado = 0;

  buscarProdutos() async {
    setState(() => carregando = true);
    var retorno = await ApiProdutos().getProdutos();
    if (retorno.statusCode == 200) {
      produtos.clear();
      if (retorno.body != "[]") {
        var decoded = json.decode(retorno.body);
        for (var item in decoded) {
          produtos.add(ProdutoModel.fromJson(item));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar produtos"),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => carregando = false);
  }

  deletarProduto(int id) async {
    setState(() => carregando = true);
    var retorno = await ApiProdutos().deleteProduto(id);
    if (retorno.statusCode == 200) {
      buscarProdutos();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao deletar produto"),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Produto",
      tituloPagina: "Produtos",
      buscaNome: (busca) {},
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => const CadastroProdutos(),
            context: context,
          ),
        );
        buscarProdutos();
      },
      corpo: [
        carregando
            ? const Expanded(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
            : produtos.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        return MouseRegion(
                          cursor: widget.selecionarProduto!
                              ? SystemMouseCursors.click
                              : SystemMouseCursors.basic,
                          child: GestureDetector(
                            onTap: () {
                              if (widget.selecionarProduto!) {
                                if (widget.selecionar != null) {
                                  widget.selecionar!(produtos[index]);
                                  setState(() {
                                    produtoSelecionado =
                                        produtos[index].proCodigo;
                                  });
                                } else {
                                  Navigator.pop(context, produtos[index]);
                                }
                                // Navigator.pop(context, produtos[index]);
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                color: produtoSelecionado ==
                                        produtos[index].proCodigo
                                    ? Cores.verdeMedio
                                    : Colors.transparent,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Cores.branco,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    CupertinoIcons.calendar),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                      produtos[index].proNome),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(produtos[index]
                                                      .proDescricao),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(produtos[index]
                                                      .proCodBarras
                                                      .toString()),
                                                ),
                                                const SizedBox(width: 30),
                                                const Icon(CupertinoIcons
                                                    .chevron_right),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Card(
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    //   elevation: 5,
                                    //   child: CupertinoButton(
                                    //     child: const Icon(
                                    //       CupertinoIcons.bed_double,
                                    //       color: Cores.cinzaEscuro,
                                    //     ),
                                    //     onPressed: () {
                                    //       // quartos();
                                    //     },
                                    //   ),
                                    // ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 5,
                                      child: CupertinoButton(
                                        child: const Icon(
                                          CupertinoIcons.trash,
                                          color: Cores.vermelhoMedio,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                title: const Text(
                                                    "Excluir Evento"),
                                                content: const Text(
                                                    "Deseja realmente excluir este evento ?"),
                                                actions: [
                                                  CupertinoDialogAction(
                                                    child: const Text("Não",
                                                        style: TextStyle(
                                                            color: Cores
                                                                .vermelhoMedio)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  CupertinoDialogAction(
                                                    child: const Text("Sim",
                                                        style: TextStyle(
                                                            color: Cores
                                                                .verdeMedio)),
                                                    onPressed: () {
                                                      // Navigator.pop(context);
                                                      deletarProduto(
                                                          produtos[index]
                                                              .proCodigo);
                                                      // excluir();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                        // return ListTile(
                        //   title: Text(produtos[index].proNome),
                        //   subtitle: Text(produtos[index].proDescricao),
                        //   trailing: IconButton(
                        //     icon: const Icon(Icons.edit),
                        //     onPressed: () {
                        //       // Navigator.push(
                        //       //   context,
                        //       //   CupertinoDialogRoute(
                        //       //     builder: (context) => CadastroProdutos(
                        //       //       produto: produtos[index],
                        //       //     ),
                        //       //     context: context,
                        //       //   ),
                        //       // );
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  )
                : const Expanded(
                    child: Center(
                      child: Text("Nenhum produto cadastrado !"),
                    ),
                  ),
      ],
    );
  }
}

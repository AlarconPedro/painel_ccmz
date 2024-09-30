import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/esqueleto.dart';

import '../../../classes/classes.dart';
import '../../../data/api/produto/api_movimento_estoque.dart';
import '../../../data/models/web/movimento_estoque_model.dart';
import '../../../widgets/widgets.dart';
import 'cadastro_movimento_estoque.dart';

class MovimentoEstoque extends StatefulWidget {
  const MovimentoEstoque({super.key});

  @override
  State<MovimentoEstoque> createState() => _MovimentoEstoqueState();
}

class _MovimentoEstoqueState extends State<MovimentoEstoque> {
  bool carregando = false;

  List<MovimentoEstoqueModel> movimento = [];

  buscarMovimentoEstoque() async {
    setState(() => carregando = true);
    var response = await ApiMovimentoEstoque().getMovimentoEstoque();
    if (response.statusCode == 200) {
      movimento.clear();
      for (var item in json.decode(response.body)) {
        movimento.add(MovimentoEstoqueModel.fromJson(item));
      }
    }
    // var response = await ApiMovimentoEstoque().getMovimentoEstoque();
    // if (response.statusCode == 200) {
    //   print(response.body);
    // }
    setState(() => carregando = false);
  }

  excluirItemMovimentoEstoque(int codigoMovimento) async {
    setState(() => carregando = true);
    var response =
        await ApiMovimentoEstoque().deleteMovimentoEstoque(codigoMovimento);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Movimento excluído com sucesso !"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
      buscarMovimentoEstoque();
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarMovimentoEstoque();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Movimento",
      tituloPagina: "Movimento de Estoque",
      buscaNome: (busca) {},
      abrirTelaCadastro: () {
        Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => const CadastroMovimentoEstoque(),
            context: context,
          ),
        );
      },
      corpo: [
        carregando
            ? const Expanded(
                child: Center(
                  child: CarregamentoIOS(),
                ),
              )
            : Expanded(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Tipo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            flex: 4,
                            child: Text(
                              "Produto",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Data",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Quantidade",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 60),
                          Text(
                            "Excluir",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: movimento.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Cores.branco,
                                          // color: movimento[index].movTipo == "E"
                                          //     ? Cores.verdeClaro.withOpacity(0.5)
                                          //     : Cores.vermelhoClaro.withOpacity(0.5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                  movimento[index].movTipo ==
                                                          "E"
                                                      ? CupertinoIcons
                                                          .arrowshape_turn_up_right_fill
                                                      : CupertinoIcons
                                                          .arrowshape_turn_up_left_fill,
                                                  color: movimento[index]
                                                              .movTipo ==
                                                          "E"
                                                      ? Cores.verdeMedio
                                                      : Cores.vermelhoMedio),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                    movimento[index].proNome),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    movimento[index].movData),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(movimento[index]
                                                    .movQuantidade
                                                    .toString()),
                                              ),
                                              const SizedBox(width: 30),
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
                                    color: Cores.branco,
                                    child: CupertinoButton(
                                      padding: const EdgeInsets.all(15),
                                      color: Cores.branco,
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
                                                  "Excluir Movimento"),
                                              content: const Text(
                                                  "Deseja realmente excluir este movimento ?"),
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
                                                    Navigator.pop(context);
                                                    excluirItemMovimentoEstoque(
                                                        movimento[index]
                                                            .movCodigo);
                                                    // deletarProduto(
                                                    //     produtos[index].proCodigo);
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

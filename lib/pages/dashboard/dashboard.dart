import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/widgets/cards/dashboard/card_pessoa_chegar.dart';

import '../../classes/classes.dart';
import '../../data/api/api_dashboard.dart';
import '../../data/models/dashboard_pessoas_model.dart';
import '../../widgets/widgets.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool carregando = false;

  int numeroPessoasAChegar = 0;
  int numeroPessoasCheckin = 0;
  int codigoEvento = 0;

  final dashBoardController = PageController(initialPage: 0);

  List<DashboardPessoasModel> listaPessoas = [];

  buscarNumeroPessoas() async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getNumeroPessoas();
    if (retorno.statusCode == 200) {
      setState(() {
        numeroPessoasAChegar = int.parse(retorno.body);
      });
    } else {
      setState(() {
        numeroPessoasAChegar = 0;
      });
    }
    setState(() => carregando = false);
  }

  buscarPessoas(int evento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getPessoasAChegar(evento);
    if (retorno.statusCode == 200) {
      var lista = json.decode(retorno.body);
      for (var item in lista) {
        listaPessoas.add(DashboardPessoasModel.fromJson(item));
      }
    }
    setState(() => carregando = false);
  }

  getEventoAtivo() async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getEventos();
    if (retorno.statusCode == 200) {
      int codigo = int.parse(retorno.body);
      await buscarPessoas(codigo);
      setState(() {
        codigoEvento = codigo;
      });
    }
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    buscarNumeroPessoas();
    getEventoAtivo();
    listaPessoas != []
        ? dashBoardController.addListener(() {
            if (dashBoardController.page == 0) {
              buscarPessoas(codigoEvento);
            }
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: CardCorpoTela(
                  carregando: carregando,
                  child: const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [CardDashboard()],
                      ),
                    ),
                  ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //               horizontal: 10,
                  //               vertical: 5,
                  //             ),
                  //             child: Text(
                  //               "Eventos",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Expanded(
                  //         child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           physics: const BouncingScrollPhysics(),
                  //           itemCount: 20,
                  //           shrinkWrap: true,
                  //           itemBuilder: (context, index) {
                  //             return CardCorpoTela(
                  //               child: SizedBox(
                  //                 width: 150,
                  //                 child: Column(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10),
                  //                           color: Cores.cinzaClaro,
                  //                         ),
                  //                         child: const Center(
                  //                           child: Text(
                  //                             "Imagem",
                  //                             style: TextStyle(
                  //                               fontSize: 18,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const Padding(
                  //                       padding: EdgeInsets.all(5),
                  //                       child: Text(
                  //                         "Nome do Evento",
                  //                         style: TextStyle(
                  //                           fontSize: 18,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const Padding(
                  //                       padding: EdgeInsets.all(5),
                  //                       child: Text(
                  //                         "Data do Evento",
                  //                         style: TextStyle(
                  //                           fontSize: 18,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  // );
                  // },
                  // ),
                  // ),
                  // ],
                  // ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: dashBoardController,
                        children: [
                          CardCorpoTela(
                            carregando: carregando,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListView.builder(
                                itemCount: listaPessoas.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: CardPessoaChegar(
                                      pessoas: listaPessoas[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                        color: Cores.branco,
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Cores.branco,
                            ),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        "Eventos",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  verticalDirection: VerticalDirection.down,
                                  runSpacing: 10,
                                  spacing: 10,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 20),
                                          child: Column(
                                            children: [
                                              const Icon(
                                                CupertinoIcons.clear_circled,
                                                color: Cores.cinzaMedio,
                                                size: 35,
                                              ),
                                              const SizedBox(height: 10),
                                              carregando
                                                  ? const CarregamentoIOS()
                                                  : Text(
                                                      numeroPessoasAChegar
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                "Pessoas a Chegar",
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons.clear_circled,
                                            color: Cores.cinzaMedio,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Checkin",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons.clear_circled,
                                            color: Cores.cinzaMedio,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Checkin",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons.clear_circled,
                                            color: Cores.cinzaMedio,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Checkin",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

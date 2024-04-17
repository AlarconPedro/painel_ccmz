import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/api/api_evento.dart';
import 'package:painel_ccmn/pages/alocacao/checkin_quartos.dart';
import 'package:painel_ccmn/widgets/cards/dashboard/card_pessoa_chegar.dart';

import '../../classes/classes.dart';
import '../../data/api/api_dashboard.dart';
import '../../data/models/dashboard_pessoas_model.dart';
import '../../data/models/quarto_pessoas_model.dart';
import '../../widgets/widgets.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool carregando = false;

  int numeroPessoasAChegar = 0;
  int numeroPessoasChegas = 0;
  int numeroPessoasNaoVem = 0;
  int numeroPessoasCheckin = 0;
  int numeroCobrantes = 0;
  int numeroPagantes = 0;
  int eventoAtivo = 0;

  final dashBoardController = PageController(initialPage: 0);

  List<DashboardPessoasModel> listaPessoas = [];
  List<QuartoPessoasModel> quartos = [];

  buscarNumeroPessoas(int codigoEvento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getNumeroPessoas(codigoEvento);
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

  buscarNumeroPessoasChegas(int codigoEvento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getNumeroPessoasChegas(codigoEvento);
    if (retorno.statusCode == 200) {
      setState(() {
        numeroPessoasChegas = int.parse(retorno.body);
      });
    } else {
      setState(() {
        numeroPessoasChegas = 0;
      });
    }
    setState(() => carregando = false);
  }

  buscarNumeroPessoasNaoVem(int codigoEvento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getNumeroPessoasNaoVem(codigoEvento);
    if (retorno.statusCode == 200) {
      setState(() {
        numeroPessoasNaoVem = int.parse(retorno.body);
      });
    } else {
      setState(() {
        numeroPessoasNaoVem = 0;
      });
    }
    setState(() => carregando = false);
  }

  buscarNumeroPessoasCobrantes(int codigoEvento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getNumeroPessoasCobrantes(codigoEvento);
    if (retorno.statusCode == 200) {
      setState(() {
        numeroCobrantes = int.parse(retorno.body);
      });
    } else {
      setState(() {
        numeroCobrantes = 0;
      });
    }
    setState(() => carregando = false);
  }

  buscarNumeroPessoasPagantes(int codigoEvento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getNumeroPessoasPagantes(codigoEvento);
    if (retorno.statusCode == 200) {
      setState(() {
        numeroPagantes = int.parse(retorno.body);
      });
    } else {
      setState(() {
        numeroPagantes = 0;
      });
    }
    setState(() => carregando = false);
  }

  // buscarNumeroCamasLivres(int codigoEvento) async {
  //   setState(() => carregando = true);
  //   var retorno = await ApiDashboard().getNumeroCamasLivres(codigoEvento);
  //   if (retorno.statusCode == 200) {
  //     setState(() {
  //       numeroCobrantes = int.parse(retorno.body);
  //     });
  //   } else {
  //     setState(() {
  //       numeroCobrantes = 0;
  //     });
  //   }
  //   setState(() => carregando = false);
  // }

  // buscarNumeroCamasOcupadas() async {
  //   setState(() => carregando = true);
  //   var retorno = await ApiDashboard().getNumeroCamasOcupadas(codigoEvento);
  //   if (retorno.statusCode == 200) {
  //     setState(() {
  //       numeroPagantes = int.parse(retorno.body);
  //     });
  //   } else {
  //     setState(() {
  //       numeroPagantes = 0;
  //     });
  //   }
  //   setState(() => carregando = false);
  // }

  buscarPessoas(int evento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getPessoasAChegar(evento);
    if (retorno.statusCode == 200) {
      listaPessoas.clear();
      var lista = json.decode(retorno.body);
      for (var item in lista) {
        listaPessoas.add(DashboardPessoasModel.fromJson(item));
      }
    }
    setState(() => carregando = false);
  }

  buscarQuartoPessoa(int codigoQuarto) async {
    setState(() => carregando = true);
    var retorno =
        await ApiDashboard().getQuartoPessoaAChegar(codigoQuarto, eventoAtivo);
    if (retorno.statusCode == 200) {
      var lista = json.decode(retorno.body);
      setState(() {
        quartos.clear();
        quartos.add(QuartoPessoasModel.fromJson(lista));
      });
    }
    setState(() => carregando = false);
  }

  getEventoAtivo() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().getEventosAtivos();
    if (retorno.statusCode == 200) {
      if (retorno.body != "[]") {
        int codigo = json.decode(retorno.body)[0]["eveCodigo"];
        await buscarPessoas(codigo);
        setState(() {
          eventoAtivo = codigo;
        });
        await buscarNumeroPessoas(codigo);
        await buscarNumeroPessoasChegas(codigo);
        await buscarNumeroPessoasNaoVem(codigo);
        await buscarNumeroPessoasCobrantes(codigo);
        await buscarNumeroPessoasPagantes(codigo);
        // buscarNumeroCamasLivres(codigo);
        // buscarNumeroCamasOcupadas(codigo);
      } else {
        setState(() {
          eventoAtivo = 0;
          numeroPagantes = 0;
          numeroCobrantes = 0;
          numeroPessoasAChegar = 0;
          numeroPessoasChegas = 0;
        });
      }
    } else {
      setState(() {
        eventoAtivo = 0;
        numeroPagantes = 0;
        numeroCobrantes = 0;
        numeroPessoasAChegar = 0;
        numeroPessoasChegas = 0;
      });
    }
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    // buscarNumeroCamasOcupadas();
    getEventoAtivo();
    listaPessoas != []
        ? dashBoardController.addListener(() {
            if (dashBoardController.page == 0) {
              buscarPessoas(eventoAtivo);
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
                width: MediaQuery.of(context).size.width - 250,
                child: CardCorpoTela(
                  carregando: carregando,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        CardDashboard(),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Flexible(
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
                                      click: () async {
                                        await buscarQuartoPessoa(
                                            listaPessoas[index].quaCodigo);
                                        dashBoardController.animateToPage(
                                          1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          CheckinQuartos(
                            codigoBloco: 0,
                            codigoEvento: eventoAtivo,
                            quartos: quartos,
                            voltar: () {
                              dashBoardController.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                              getEventoAtivo();
                            },
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
                                      "Evento",
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
                                verticalDirection: VerticalDirection.down,
                                runSpacing: 10,
                                spacing: 10,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        getEventoAtivo();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              CupertinoIcons
                                                  .clear_circled_solid,
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
                                              "A Chegar",
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
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        getEventoAtivo();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              CupertinoIcons
                                                  .checkmark_circle_fill,
                                              color: Cores.verdeMedio,
                                              size: 35,
                                            ),
                                            const SizedBox(height: 10),
                                            carregando
                                                ? const CarregamentoIOS()
                                                : Text(
                                                    numeroPessoasChegas
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Compareceu",
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
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        getEventoAtivo();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              CupertinoIcons
                                                  .clear_circled_solid,
                                              color: Cores.vermelhoMedio,
                                              size: 35,
                                            ),
                                            const SizedBox(height: 10),
                                            carregando
                                                ? const CarregamentoIOS()
                                                : Text(
                                                    numeroPessoasNaoVem
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Não Vem",
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
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: Cores.cinzaMedio,
                                  thickness: 1,
                                ),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      "Cobrança",
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
                                verticalDirection: VerticalDirection.down,
                                runAlignment: WrapAlignment.spaceBetween,
                                runSpacing: 10,
                                spacing: 10,
                                children: [
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              CupertinoIcons
                                                  .person_crop_circle_badge_checkmark,
                                              color: Cores.azulMedio,
                                              size: 35,
                                            ),
                                            const SizedBox(height: 10),
                                            carregando
                                                ? const CarregamentoIOS()
                                                : Text(
                                                    numeroCobrantes.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Cobrantes",
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
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          children: [
                                            const Icon(
                                              CupertinoIcons.money_dollar,
                                              color: Cores.verdeMedio,
                                              size: 35,
                                            ),
                                            const SizedBox(height: 10),
                                            carregando
                                                ? const CarregamentoIOS()
                                                : Text(
                                                    numeroPagantes.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                            const SizedBox(height: 10),
                                            const Text(
                                              "Pagantes",
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
                                ],
                              ),
                              // Wrap(
                              //   direction: Axis.horizontal,
                              //   verticalDirection: VerticalDirection.down,
                              //   runAlignment: WrapAlignment.spaceBetween,
                              //   runSpacing: 10,
                              //   spacing: 10,
                              //   children: [
                              //     MouseRegion(
                              //       cursor: SystemMouseCursors.click,
                              //       child: GestureDetector(
                              //         onTap: () {},
                              //         child: Padding(
                              //           padding: const EdgeInsets.symmetric(
                              //               horizontal: 10, vertical: 20),
                              //           child: Column(
                              //             children: [
                              //               const Icon(
                              //                 CupertinoIcons
                              //                     .person_crop_circle_badge_checkmark,
                              //                 color: Cores.verdeMedio,
                              //                 size: 35,
                              //               ),
                              //               const SizedBox(height: 10),
                              //               carregando
                              //                   ? const CarregamentoIOS()
                              //                   : Text(
                              //                       numeroCamasLivres
                              //                           .toString(),
                              //                       style: const TextStyle(
                              //                         fontSize: 18,
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                       ),
                              //                     ),
                              //               const SizedBox(height: 10),
                              //               const Text(
                              //                 "Camas Livres",
                              //                 maxLines: 2,
                              //                 softWrap: true,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.bold,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     MouseRegion(
                              //       cursor: SystemMouseCursors.click,
                              //       child: GestureDetector(
                              //         onTap: () {},
                              //         child: Padding(
                              //           padding: const EdgeInsets.symmetric(
                              //               horizontal: 10, vertical: 20),
                              //           child: Column(
                              //             children: [
                              //               const Icon(
                              //                 CupertinoIcons.bed_double,
                              //                 color: Cores.vermelhoMedio,
                              //                 size: 35,
                              //               ),
                              //               const SizedBox(height: 10),
                              //               carregando
                              //                   ? const CarregamentoIOS()
                              //                   : Text(
                              //                       numeroCamasOcupadas
                              //                           .toString(),
                              //                       style: const TextStyle(
                              //                         fontSize: 18,
                              //                         fontWeight:
                              //                             FontWeight.bold,
                              //                       ),
                              //                     ),
                              //               const SizedBox(height: 10),
                              //               const Text(
                              //                 "Camas Ocupadas",
                              //                 maxLines: 2,
                              //                 softWrap: true,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: TextStyle(
                              //                   fontSize: 12,
                              //                   fontWeight: FontWeight.bold,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
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

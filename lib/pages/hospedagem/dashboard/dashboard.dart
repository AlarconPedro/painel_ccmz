import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/widgets/cards/dashboard/card_pessoa_chegar.dart';

import '../../../classes/classes.dart';
import '../../../data/data.dart';
import '../../../widgets/widgets.dart';
import '../../pages.dart';

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
  List<DashboardPessoasModel> listaPessoasBusca = [];
  List<QuartoPessoasModel> quartos = [];

  Widget telaDashboard = Container();

  String status = "A";

  TextEditingController campoBusca = TextEditingController();

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

  buscarPessoasChegas(int evento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getPessoasChegas(evento);
    if (retorno.statusCode == 200) {
      listaPessoas.clear();
      var lista = json.decode(retorno.body);
      for (var item in lista) {
        listaPessoas.add(DashboardPessoasModel.fromJson(item));
      }
    }
    setState(() => carregando = false);
  }

  buscarPessoasNaoVem(int evento) async {
    setState(() => carregando = true);
    var retorno = await ApiDashboard().getPessoasNaoVem(evento);
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

  buscarPessoa(String nome) {
    setState(() {
      listaPessoasBusca.clear();
      for (var item in listaPessoas) {
        if (item.pesNome.contains(nome)) {
          listaPessoasBusca.add(item);
        }
      }
    });
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
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          CardCorpoTela(
                            carregando: carregando,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
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
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: Cores.cinzaEscuro,
                                                ),
                                              ),
                                              placeholder: 'Pesquisar',
                                              onSubmitted: (value) async {
                                                if (value.isNotEmpty) {
                                                  buscarPessoa(value);
                                                } else {
                                                  setState(() {
                                                    listaPessoasBusca.clear();
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        CupertinoButton(
                                          color: Cores.preto,
                                          onPressed: () async {
                                            if (campoBusca.text.isNotEmpty) {
                                              buscarPessoa(campoBusca.text);
                                            } else {
                                              setState(() {
                                                listaPessoasBusca.clear();
                                              });
                                            }
                                          },
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 16,
                                          ),
                                          child:
                                              const Icon(CupertinoIcons.search),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: listaPessoasBusca.isEmpty
                                          ? listaPessoas.length
                                          : listaPessoasBusca.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: CardPessoaChegar(
                                            pessoas: listaPessoasBusca.isEmpty
                                                ? listaPessoas[index]
                                                : listaPessoasBusca[index],
                                            status: status,
                                            click: () async {
                                              await buscarQuartoPessoa(
                                                  listaPessoas[index]
                                                      .quaCodigo);
                                              setState(() {
                                                telaDashboard = CheckinQuartos(
                                                  codigoEvento: eventoAtivo,
                                                  quartosBusca: quartos,
                                                  voltar: () {
                                                    dashBoardController
                                                        .animateToPage(
                                                      0,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease,
                                                    );
                                                    setState(() {
                                                      status = "A";
                                                    });
                                                    getEventoAtivo();
                                                  },
                                                );
                                              });
                                              dashBoardController.animateToPage(
                                                1,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.ease,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          telaDashboard,
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
                              color: Cores.branco),
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
                                      onTap: () async {
                                        //getEventoAtivo();
                                        await buscarPessoas(eventoAtivo);
                                        setState(() {
                                          status = "A";
                                        });
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
                                      onTap: () async {
                                        //getEventoAtivo();
                                        await buscarPessoasChegas(eventoAtivo);
                                        setState(() {
                                          status = "C";
                                        });
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
                                      onTap: () async {
                                        //getEventoAtivo();
                                        await buscarPessoasNaoVem(eventoAtivo);
                                        setState(() {
                                          status = "N";
                                        });
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

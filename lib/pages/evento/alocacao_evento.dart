import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';
import '../../data/data.dart';
import '../../widgets/widgets.dart';

class AlocacaoEvento extends StatefulWidget {
  const AlocacaoEvento({super.key});

  @override
  State<AlocacaoEvento> createState() => _AlocacaoEventoState();
}

class _AlocacaoEventoState extends State<AlocacaoEvento> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();

  bool exibirBlocos = false;
  bool carregando = false;

  int eventoSelecionado = 0;
  int quartoSelecionado = 0;
  int blocoSelecionado = 0;
  int comunidadeSelecionada = 0;

  List<DropdownMenuItem> eventos = [];
  List<DropdownMenuItem> blocos = [];
  List<DropdownMenuItem> comunidades = [];
  List<QuartoModel> quartos = [];
  List<PessoaModel> pessoas = [];

  buscarEventos() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().getEventoNomes();
    if (retorno.statusCode == 200) {
      eventos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          eventos.add(
            DropdownMenuItem(
              value: item["eveCodigo"],
              child: Text(item["eveNome"]),
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar eventos!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarBlocos() async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao().getAlocacaoBlocos(eventoSelecionado);
    if (retorno.statusCode == 200) {
      blocos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          blocos.add(
            DropdownMenuItem(
              value: item["bloCodigo"],
              child: Text(item["bloNome"]),
            ),
            // BlocoModel.fromJson(item),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar blocos!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarQuartos(int codigoEvento) async {
    setState(() => carregando = true);
    var retorno =
        await ApiAlocacao().getQuartosEvento(codigoEvento, blocoSelecionado);
    if (retorno.statusCode == 200) {
      quartos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          quartos.add(
            QuartoModel.fromJson(item),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar quartos!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarComunidades() async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao().getAlocacaoComunidades(eventoSelecionado);
    if (retorno.statusCode == 200) {
      comunidades.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          comunidades.add(
            DropdownMenuItem(
              value: item["comCodigo"],
              child: Text(item["comNome"]),
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar comunidades!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarPessoasComunidade(int codigoComunidade) async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao()
        .getPessoasComunidade(eventoSelecionado, codigoComunidade);
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
          content: Text("Erro ao buscar comunidades!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    buscarEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Cores.branco,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pessoas Evento",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Alocação de Evento",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                            left: 2,
                                            right: 2,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 55,
                                                  child: CupertinoTextField(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            Cores.cinzaEscuro,
                                                      ),
                                                    ),
                                                    placeholder: 'Pesquisar',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              CupertinoButton(
                                                color: Cores.preto,
                                                onPressed: () {},
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 16,
                                                  horizontal: 16,
                                                ),
                                                child: const Icon(
                                                    CupertinoIcons.search),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 60,
                                          child: DropDownForm(
                                            label: 'Comunidade',
                                            itens: comunidades,
                                            selecionado: 0,
                                            onChange: (value) {
                                              setState(() {
                                                comunidadeSelecionada = value;
                                              });
                                              buscarPessoasComunidade(value);
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Cores.cinzaClaro,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5,
                                                vertical: 5,
                                              ),
                                              child: ListView.builder(
                                                itemCount: pessoas.length,
                                                itemBuilder: (context, index) {
                                                  return MouseRegion(
                                                    cursor: SystemMouseCursors
                                                        .click,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          // pessoas[index]
                                                          //         .pesSelecionado =
                                                          //     !pessoas[index]
                                                          //         .pesSelecionado;
                                                        });
                                                      },
                                                      child: Card(
                                                        elevation: 5,
                                                        child: ListTile(
                                                          title: Text(
                                                            pessoas[index]
                                                                .pesNome,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            pessoas[index]
                                                                .pesGenero,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          trailing: const Icon(
                                                              CupertinoIcons
                                                                  .chevron_forward),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 10,
                                              left: 2,
                                              right: 2,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 60,
                                                    child: DropDownForm(
                                                      label: 'Evento',
                                                      itens: eventos,
                                                      selecionado: 0,
                                                      onChange: (value) {
                                                        setState(() {
                                                          if (value != 0) {
                                                            exibirBlocos = true;
                                                          } else {
                                                            exibirBlocos =
                                                                false;
                                                          }
                                                          eventoSelecionado =
                                                              value;
                                                        });
                                                        buscarBlocos();
                                                        buscarComunidades();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Visibility(
                                                  visible: exibirBlocos,
                                                  child: Expanded(
                                                    child: SizedBox(
                                                      height: 60,
                                                      child: DropDownForm(
                                                        label: 'Bloco',
                                                        itens: blocos,
                                                        selecionado: 0,
                                                        onChange: (value) {
                                                          setState(() {
                                                            blocoSelecionado =
                                                                value;
                                                          });
                                                          buscarQuartos(value);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Cores.cinzaClaro,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                  vertical: 5,
                                                ),
                                                child: Expanded(
                                                  child: SingleChildScrollView(
                                                      child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    direction: Axis.horizontal,
                                                    children: [
                                                      for (var item in quartos)
                                                        CardQuartoAlocacao(),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 3,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(10),
                                //     child: Container(
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(10),
                                //         color: Cores.cinzaClaro,
                                //       ),
                                //       child: const Expanded(
                                //         child: Wrap(
                                //           alignment: WrapAlignment.center,
                                //           direction: Axis.horizontal,
                                //           children: [
                                //             CardQuartoAlocacao(),
                                //             CardQuartoAlocacao(),
                                //             CardQuartoAlocacao(),
                                //             CardQuartoAlocacao(),
                                //             CardQuartoAlocacao(),
                                //             CardQuartoAlocacao(),
                                //             CardQuartoAlocacao(),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Cores.vermelhoMedio,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 30,
                            ),
                            child: const Text("Cancelar"),
                          ),
                          const Spacer(),
                          CupertinoButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // gravar();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Cores.vermelhoMedio,
                                    content: Text(
                                      'Preencha os campos corretamente',
                                    ),
                                  ),
                                );
                              }
                            },
                            color: Cores.verdeMedio,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 30,
                            ),
                            child: const Text("Salvar"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/api/api_evento.dart';
import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/estrutura/estrutura.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/loading/carregamento_ios.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../data/models/quarto_pessoas_model.dart';

class Alocacao extends StatefulWidget {
  const Alocacao({super.key});

  @override
  State<Alocacao> createState() => _AlocacaoState();
}

class _AlocacaoState extends State<Alocacao> {
  bool carregando = false;

  List<DropdownMenuItem> eventos = [];
  List<QuartoModel> quartos = [];
  List<QuartoPessoasModel> quartosPessoas = [];
  List<BlocoModel> blocos = [];

  int eventoSelecionado = 0;
  int codigoBloco = 0;

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
            BlocoModel.fromJson(item),
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
        await ApiAlocacao().getQuartosEvento(codigoEvento, codigoBloco);
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

  buscarQuartoPessoas() async {
    setState(() => carregando = true);
    var retorno = await ApiCheckin().getCheckinQuartos(
      codigoBloco,
      eventoSelecionado,
    );
    if (retorno.statusCode == 200) {
      quartosPessoas.clear();
      var dados = json.decode(retorno.body);
      for (var dado in dados) {
        setState(() {
          quartosPessoas.add(QuartoPessoasModel.fromJson(dado));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer quartos !"),
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
            child: Expanded(
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
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    color: Cores.cinzaEscuro,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Check-In",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: 500,
                            height: 60,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                labelText: 'Evento',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Cores.cinzaEscuro,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              items: eventos,
                              value: eventoSelecionado != 0
                                  ? eventoSelecionado
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  eventoSelecionado = value;
                                });
                                buscarBlocos();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 1,
                        color: Cores.preto,
                      ),
                    ),
                    carregando
                        ? const Expanded(
                            child: Center(child: CarregamentoIOS()),
                          )
                        : Expanded(
                            child: PageView(
                              controller: Rotas.alocacaoPageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: blocos.length,
                                    itemBuilder: (context, index) {
                                      return MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              codigoBloco =
                                                  blocos[index].bloCodigo;
                                              Rotas.alocacaoPageController
                                                  .animateToPage(
                                                1,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeInOut,
                                              );
                                            });
                                            buscarQuartoPessoas();
                                          },
                                          child: CardBlocoAlocacao(
                                            blocos: blocos[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: carregando
                                      ? const Center(child: CarregamentoIOS())
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Wrap(
                                                  direction: Axis.horizontal,
                                                  children: [
                                                    for (var quarto
                                                        in quartosPessoas)
                                                      GestureDetector(
                                                        onTap: () {},
                                                        child: MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors
                                                                  .click,
                                                          child: CheckinQuartos(
                                                            quarto: quarto,
                                                            abrirQuarto:
                                                                () async {
                                                              await Navigator
                                                                  .push(
                                                                context,
                                                                CupertinoDialogRoute(
                                                                  builder:
                                                                      (context) {
                                                                    return EditarCheckin(
                                                                      dadosQuarto:
                                                                          quarto,
                                                                    );
                                                                  },
                                                                  context:
                                                                      context,
                                                                ),
                                                              );
                                                            },
                                                            voltar: () {
                                                              Rotas
                                                                  .alocacaoPageController
                                                                  .animateToPage(
                                                                0,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              );
                                                            },
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

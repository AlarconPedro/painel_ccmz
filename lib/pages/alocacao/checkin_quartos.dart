import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../data/data.dart';
import '../../data/models/quarto_pessoas_model.dart';

class CheckinQuartos extends StatefulWidget {
  int codigoBloco;
  int codigoEvento;
  Function() voltar;

  CheckinQuartos({
    super.key,
    required this.codigoBloco,
    required this.codigoEvento,
    required this.voltar,
  });

  @override
  State<CheckinQuartos> createState() => _CheckinQuartosState();
}

class _CheckinQuartosState extends State<CheckinQuartos> {
  bool carregando = false;

  List<QuartoPessoasModel> quartos = [];

  buscarQuartos() async {
    setState(() => carregando = true);
    var retorno = await ApiCheckin().getCheckinQuartos(
      widget.codigoBloco,
      widget.codigoEvento,
    );
    if (retorno.statusCode == 200) {
      quartos.clear();
      var dados = json.decode(retorno.body);
      for (var dado in dados) {
        setState(() {
          quartos.add(QuartoPessoasModel.fromJson(dado));
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
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarQuartos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carregando
          ? const Center(child: CarregamentoIOS())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        for (var quarto in quartos)
                          GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                CupertinoDialogRoute(
                                  builder: (context) {
                                    return EditarCheckin(
                                      dadosQuarto: quarto,
                                    );
                                  },
                                  context: context,
                                ),
                              );
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: CardQuartoAlocacao(
                                quarto: quarto,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        color: Cores.vermelhoMedio,
                        child: const Text("Voltar"),
                        onPressed: () {
                          widget.voltar();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

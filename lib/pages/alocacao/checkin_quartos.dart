import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../data/data.dart';
import '../../data/models/quarto_pessoas_model.dart';

class CheckinQuartos extends StatefulWidget {
  int codigoBloco;
  int codigoEvento;
  CheckinQuartos({
    super.key,
    required this.codigoBloco,
    required this.codigoEvento,
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
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  for (var quarto in quartos)
                    CardQuartoAlocacao(
                      quarto: quarto,
                    ),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 10, horizontal: 10),
                  //     child: ListView.builder(
                  //       itemCount: quartos.length,
                  //       itemBuilder: (context, index) {
                  // return
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }
}

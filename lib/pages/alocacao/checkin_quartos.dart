import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class CheckinQuartos extends StatefulWidget {
  int codigoBloco;
  CheckinQuartos({super.key, required this.codigoBloco});

  @override
  State<CheckinQuartos> createState() => _CheckinQuartosState();
}

class _CheckinQuartosState extends State<CheckinQuartos> {
  bool carregando = false;

  buscarQuartos() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carregando
          ? const Center(child: CarregamentoIOS())
          : const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Wrap(
                direction: Axis.horizontal,
                children: [CardQuartoAlocacao()],
              ),
            ),
    );
  }
}

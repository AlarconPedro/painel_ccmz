import 'package:flutter/material.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../data/data.dart';

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

  buscarQuartos() async {
    setState(() => carregando = true);
    var retorno = await ApiCheckin().getCheckinQuartos(
      widget.codigoBloco,
      widget.codigoEvento,
    );
    if (retorno.statusCode == 200) {}
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carregando
          ? const Center(child: CarregamentoIOS())
          : const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  CardQuartoAlocacao(),
                ],
              ),
            ),
    );
  }
}

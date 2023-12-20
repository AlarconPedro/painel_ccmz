import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class AlocacaoQuartos extends StatefulWidget {
  int codigoBloco;
  AlocacaoQuartos({super.key, required this.codigoBloco});

  @override
  State<AlocacaoQuartos> createState() => _AlocacaoQuartosState();
}

class _AlocacaoQuartosState extends State<AlocacaoQuartos> {
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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../data/data.dart';
import '../../data/models/quarto_pessoas_model.dart';

class CheckinQuartos extends StatefulWidget {
  Function() abrirQuarto;
  Function() voltar;
  QuartoPessoasModel quarto;

  CheckinQuartos({
    super.key,
    required this.abrirQuarto,
    required this.voltar,
    required this.quarto,
  });

  @override
  State<CheckinQuartos> createState() => _CheckinQuartosState();
}

class _CheckinQuartosState extends State<CheckinQuartos> {
  bool carregando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carregando
          ? const Center(child: CarregamentoIOS())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.abrirQuarto();
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: CardQuartoAlocacao(
                              quarto: widget.quarto,
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

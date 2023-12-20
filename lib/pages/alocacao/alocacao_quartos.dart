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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    color: Cores.branco,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Cores.branco,
                      ),
                      width: 300,
                      height: 200,
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  "Quarto 1",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Text("Fulano de Tal"),
                              Text("Vazio"),
                              Text("Vazio"),
                            ],
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Vagas: 3",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Text(
                                    "Ocupados: 1",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

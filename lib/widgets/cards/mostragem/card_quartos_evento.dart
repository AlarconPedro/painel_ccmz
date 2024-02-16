import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';

class CardQuartosEvento extends StatelessWidget {
  QuartoModel quarto;
  List<int> quartosSelecionados;
  bool selecionado;

  CardQuartosEvento({
    super.key,
    required this.quarto,
    required this.quartosSelecionados,
    required this.selecionado,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: selecionado ? Cores.azulClaro : Cores.branco,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: 150,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: selecionado ? Cores.azulClaro : Cores.branco,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quarto.quaNome,
                    style: TextStyle(
                      color: selecionado ? Cores.branco : Cores.cinzaEscuro,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Camas: ${quarto.quaQtdCamas}",
                    style: TextStyle(
                      color: selecionado ? Cores.branco : Cores.cinzaEscuro,
                    ),
                  ),
                ],
              ),
              Divider(
                color: selecionado ? Cores.branco : Cores.cinzaEscuro,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: quarto.quaQtdCamaslivres,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.bed_double,
                          color: selecionado ? Cores.branco : Cores.cinzaEscuro,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Livre",
                            style: TextStyle(
                              fontSize: 15,
                              color: selecionado
                                  ? Cores.branco
                                  : Cores.cinzaEscuro,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          CupertinoIcons.checkmark_alt,
                          color: selecionado ? Cores.branco : Cores.verdeMedio,
                          size: 18,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

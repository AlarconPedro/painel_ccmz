import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../../classes/classes.dart';

class CardQuartosEvento extends StatelessWidget {
  QuartoModel quarto;

  CardQuartosEvento({super.key, required this.quarto});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Cores.branco,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Cores.branco,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(quarto.quaNome)],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(quarto.quaQtdCamas.toString())],
              ),
              const Divider(
                color: Cores.cinzaEscuro,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          CupertinoIcons.bed_double,
                          color: Cores.cinzaEscuro,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Pessoa ${index + 1}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Cores.cinzaEscuro,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Cores.verdeMedio,
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class CardQuartos extends StatelessWidget {
  QuartoModel quarto;

  Function excluir;

  CardQuartos({super.key, required this.quarto, required this.excluir});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Cores.branco,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.bed_double),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Text(quarto.quaNome),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(quarto.bloco),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(quarto.quaQtdCamas.toString()),
                      ),
                      const SizedBox(width: 30),
                      const Icon(CupertinoIcons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.trash,
                color: Cores.vermelhoMedio,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Excluir Quarto"),
                      content:
                          const Text("Deseja realmente excluir este quarto ?"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Não",
                              style: TextStyle(color: Cores.vermelhoMedio)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text("Sim",
                              style: TextStyle(color: Cores.verdeMedio)),
                          onPressed: () {
                            Navigator.pop(context);
                            excluir();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

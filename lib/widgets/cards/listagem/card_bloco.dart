import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../../classes/classes.dart';

class CardBloco extends StatelessWidget {
  BlocoModel bloco;

  Function excluir;

  CardBloco({
    super.key,
    required this.bloco,
    required this.excluir,
  });

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
                      const Icon(CupertinoIcons.building_2_fill),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Text(bloco.bloNome),
                      ),
                      const SizedBox(width: 120),
                      Expanded(
                        flex: 2,
                        child: Text(bloco.qtdQuartos.toString()),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(bloco.qtdLivres.toString()),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(bloco.qtdOcupados.toString()),
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
                      title: const Text("Excluir Bloco"),
                      content:
                          const Text("Deseja realmente excluir este bloco ?"),
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

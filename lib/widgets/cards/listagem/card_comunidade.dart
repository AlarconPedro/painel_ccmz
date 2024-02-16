import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';

class CardComunidade extends StatelessWidget {
  ComunidadeModel comunidade;

  Function() excluir;

  CardComunidade({super.key, required this.comunidade, required this.excluir});

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
                      const Icon(CupertinoIcons.person_3),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Text(comunidade.comNome),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(comunidade.comCidade),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        flex: 2,
                        child: Text(comunidade.comUF),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(comunidade.qtdPessoas.toString()),
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
                      title: const Text("Excluir Comunidade"),
                      content: const Text(
                          "Deseja realmente excluir esta comunidade ?"),
                      actions: [
                        //  CupertinoButton(
                        //   color: Cores.vermelhoMedio,
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 20, vertical: 5),
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //   },
                        //   child: const Text("Não"),
                        // ),
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

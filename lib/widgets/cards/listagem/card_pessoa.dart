import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/classes/cores.dart';

import '../../../data/data.dart';

class CardPessoa extends StatelessWidget {
  PessoaModel pessoa;

  Function() excluir;

  CardPessoa({super.key, required this.pessoa, required this.excluir});

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
                      const Icon(CupertinoIcons.person),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Text(pessoa.pesNome),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(pessoa.pesGenero),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(pessoa.comunidade),
                      ),
                      Expanded(
                        flex: 2,
                        child: CupertinoCheckbox(
                            value: pessoa.pesResponsavel == "S" ? true : false,
                            onChanged: (value) {}),
                      ),
                      Expanded(
                        flex: 2,
                        child: CupertinoCheckbox(
                            value: pessoa.pesCatequista == "S" ? true : false,
                            onChanged: (value) {}),
                      ),
                      Expanded(
                        flex: 2,
                        child: CupertinoCheckbox(
                          value: pessoa.pesSalmista == "S" ? true : false,
                          onChanged: (value) {},
                        ),
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
              child:
                  const Icon(CupertinoIcons.trash, color: Cores.vermelhoMedio),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Excluir Pessoa"),
                      content:
                          const Text("Deseja realmente excluir esta pessoa ?"),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class CardComunidade extends StatelessWidget {
  ComunidadeModel comunidade;
  CardComunidade({super.key, required this.comunidade});

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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

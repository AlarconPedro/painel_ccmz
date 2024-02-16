import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/bloco/bloco.dart';

import '../../../classes/classes.dart';
import '../../../data/data.dart';

class CardBlocoAlocacao extends StatelessWidget {
  BlocoModel blocos;

  CardBlocoAlocacao({super.key, required this.blocos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        color: Cores.branco,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Cores.branco,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      blocos.bloNome,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    color: Cores.preto,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/classes/cores.dart';

class CardPessoa extends StatelessWidget {
  const CardPessoa({super.key});

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
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.person),
                      SizedBox(width: 10),
                      Text("Nome da Pessoa"),
                      Spacer(),
                      Text("Sexo"),
                      Spacer(),
                      Text("Comunidade"),
                      Spacer(),
                      Icon(CupertinoIcons.chevron_right),
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

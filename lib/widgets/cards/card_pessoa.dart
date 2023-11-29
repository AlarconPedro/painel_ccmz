import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/classes/cores.dart';

class CardPessoa extends StatelessWidget {
  const CardPessoa({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: Cores.branco,
        child: const Row(
          children: [
            Icon(CupertinoIcons.person),
            Text("Nome da Pessoa"),
          ],
        ),
      ),
    );
  }
}

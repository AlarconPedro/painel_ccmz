import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class BtnOpcoesCard extends StatelessWidget {
  Function dialog;
  IconData icone;
  Color cor;

  BtnOpcoesCard(
      {super.key,
      required this.dialog,
      required this.icone,
      required this.cor});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        color: Cores.branco,
        child: CupertinoButton(
            color: Cores.branco,
            padding: const EdgeInsets.all(15),
            child: Icon(icone, color: cor),
            onPressed: () => dialog()));
  }
}

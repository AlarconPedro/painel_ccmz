import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        child: CupertinoButton(
            child: Icon(icone, color: cor), onPressed: () => dialog()));
  }
}

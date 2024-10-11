import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';

deleteDialog({
  required BuildContext context,
  required Function excluir,
  required String titulo,
  required String mensagem,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(mensagem),
        actions: [
          CupertinoDialogAction(
            child:
                const Text("Não", style: TextStyle(color: Cores.vermelhoMedio)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text("Sim", style: TextStyle(color: Cores.verdeMedio)),
            onPressed: () {
              Navigator.pop(context);
              excluir();
            },
          ),
        ],
      );
    },
  );
}

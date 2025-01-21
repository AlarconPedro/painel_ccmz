import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';

Widget cardListagemBase({
  required List<Widget> actions,
  required List<Widget> campos,
  Color? cor,
}) {
  return Container(
    color: cor ?? Colors.transparent,
    child: Row(
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Cores.branco),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: campos,
                  // const Icon(CupertinoIcons.calendar),
                  // const SizedBox(width: 10),
                  // Expanded(flex: 4, child: Text(evento.eveNome)),
                  // Expanded(flex: 2, child: Text(evento.eveDataInicio)),
                  // Expanded(flex: 2, child: Text(evento.eveDataFim)),
                  // const SizedBox(width: 30),
                  // const Icon(CupertinoIcons.chevron_right),
                ),
              ),
            ),
          ),
        ),
        ...actions,
      ],
    ),
  );
}

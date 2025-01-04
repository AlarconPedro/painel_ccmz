import 'package:flutter/cupertino.dart';

import '../../classes/classes.dart';
import '../textos/textos.dart';

CupertinoButton btnTerciario(
    {required String texto, required Function() onPressed, Widget? icon}) {
  return CupertinoButton(
    onPressed: () => onPressed(),
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    color: Cores.azulMedio,
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    child: Row(
      children: [
        icon ?? const SizedBox(),
        // const Icon(CupertinoIcons.printer, color: Cores.branco),
        // const SizedBox(width: 10),
        Textos.textoPequenoNormal(texto: texto, cor: Cores.branco),
      ],
    ),
  );
}

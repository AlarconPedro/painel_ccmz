import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../classes/classes.dart';

Widget campoBusca({
  required TextEditingController controlador,
  required Function() busca,
  required String titulo,
  IconData? icone = CupertinoIcons.person,
}) {
  return CupertinoTextField(
    controller: controlador,
    placeholder: titulo,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Cores.cinzaMedio,
      ),
      // color: Cores.cinzaClaro,
    ),
    prefix: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Icon(icone, color: Cores.cinzaEscuro)),
    keyboardType: TextInputType.text,
    inputFormatters: [
      MaskTextInputFormatter(mask: "", filter: {"": RegExp(r'[a-zA-Z]')})
    ],
    onSubmitted: (value) {
      if (controlador.text.isNotEmpty) {
        busca();
      }
    },
    onChanged: (value) {
      if (controlador.text.isNotEmpty) {
        busca();
      }
    },
  );
}

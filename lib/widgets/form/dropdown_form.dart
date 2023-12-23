import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class DropDownForm extends StatelessWidget {
  String label;
  List<DropdownMenuItem> itens;
  int selecionado;
  Function(int) onChange;

  DropDownForm({
    super.key,
    required this.label,
    required this.itens,
    required this.selecionado,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: label,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Cores.cinzaEscuro,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      items: itens,
      value: selecionado != 0 ? selecionado : null,
      onChanged: (value) {
        onChange(value);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget campoTexto({
  required String titulo,
  required String dica,
  required IconData icone,
  required Function(String) validador,
  TextInputType? tipo,
  required TextEditingController controlador,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controlador,
      keyboardType: tipo ?? TextInputType.text,
      inputFormatters: tipo == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      decoration: InputDecoration(
        labelText: titulo,
        hintText: dica,
        prefixIcon: Icon(icone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validador(value!),
    ),
  );
}

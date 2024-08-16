import 'package:flutter/material.dart';

Widget campoTexto({
  required String titulo,
  required String dica,
  required IconData icone,
  required Function(String) validador,
  required TextEditingController controlador,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controlador,
      decoration: InputDecoration(
        labelText: titulo,
        hintText: dica,
        prefixIcon: Icon(icone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) => validador(value!),
    ),
  );
}

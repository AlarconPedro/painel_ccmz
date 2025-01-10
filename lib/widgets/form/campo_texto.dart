import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget campoTexto({
  required String titulo,
  required String dica,
  required IconData icone,
  required bool temMascara,
  required MaskTextInputFormatter mascara,
  required Function(String) validador,
  Function()? enviarDados,
  TextInputType? tipo,
  required TextEditingController controlador,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controlador,
      keyboardType: tipo ?? TextInputType.text,
      onChanged: (value) => enviarDados!(),
      inputFormatters: temMascara
          ? [mascara]
          : tipo == TextInputType.number
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

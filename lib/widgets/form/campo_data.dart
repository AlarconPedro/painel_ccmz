import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:painel_ccmn/classes/cores.dart';

Widget campoData(BuildContext context, TextEditingController dataController,
    int flex, String labelText) {
  return Expanded(
    flex: flex,
    child: DateTimeField(
      controller: dataController,
      format: DateFormat("dd/MM/yyyy"),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.calendar_today),
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
      validator: (value) {
        if (value == null || value == DateTime(0)) {
          return 'Por favor, digite a Data !';
        }
        return null;
      },
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          locale: const Locale("pt", "BR"),
          initialEntryMode: DatePickerEntryMode.input,
          confirmText: "Confirmar",
          cancelText: "Cancelar",
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Cores.cinzaEscuro,
                  onPrimary: Cores.branco,
                  surface: Cores.branco,
                  onSurface: Cores.cinzaEscuro,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
          context: context,
          initialDate: currentValue ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
      },
    ),
  );
}

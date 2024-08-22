import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../classes/classes.dart';
import '../../widgets/widgets.dart';

class CadastroPromocoes extends StatefulWidget {
  const CadastroPromocoes({super.key});

  @override
  State<CadastroPromocoes> createState() => _CadastroPromocoesState();
}

class _CadastroPromocoesState extends State<CadastroPromocoes> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataInicioController = TextEditingController();
  TextEditingController dataFimController = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: GlobalKey<FormState>(),
      altura: 2,
      largura: 2,
      campos: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cadastro de Promoções',
              style: TextStyle(
                color: Cores.cinzaEscuro,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Cores.cinzaEscuro,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o nome do Evento !';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: DateTimeField(
                controller: dataInicioController,
                format: DateFormat("dd/MM/yyyy"),
                decoration: const InputDecoration(
                  labelText: 'Data Início',
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      color: Cores.cinzaEscuro,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value == DateTime(0)) {
                    return 'Por favor, digite a Data de Início !';
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
                            surface: Cores.cinzaEscuro,
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
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DateTimeField(
                  controller: dataFimController,
                  format: DateFormat("dd/MM/yyyy"),
                  decoration: const InputDecoration(
                    labelText: 'Data Fim',
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Cores.cinzaEscuro,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value == DateTime(0)) {
                      return 'Por favor, digite a Data de Fim !';
                    }
                    return null;
                  },
                  onShowPicker: (BuildContext context, DateTime? currentValue) {
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
                              surface: Cores.cinzaEscuro,
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
              ),
            ),
          ],
        ),
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 210,
                        ),
                        child: Focus(
                          child: CupertinoTextField(
                            controller: _controllerDescricao,
                            expands: true,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            focusNode: FocusNode(),
                            padding: const EdgeInsets.all(10),
                            placeholder: "Digite aqui...",
                            decoration: BoxDecoration(
                              color: Cores.cinzaClaro,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(
                                color: Cores.cinzaEscuro,
                                width: 1,
                              ),
                              backgroundBlendMode: BlendMode.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
      titulo: '',
      gravar: () {},
      cancelar: () {},
    );
  }
}

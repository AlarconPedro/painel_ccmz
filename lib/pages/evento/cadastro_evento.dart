import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/funcoes/funcoes.dart';
import 'package:painel_ccmn/pages/esqueleto/cadastro_form.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../classes/classes.dart';

class CadastroEvento extends StatefulWidget {
  EventoModel? evento;

  CadastroEvento({super.key, this.evento});

  @override
  State<CadastroEvento> createState() => _CadastroEventoState();
}

class _CadastroEventoState extends State<CadastroEvento> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController dataInicioController = TextEditingController();
  TextEditingController dataFimController = TextEditingController();

  bool carregando = false;

  preparaDados() {
    if (widget.evento != null) {
      return EventoModel(
        eveCodigo: widget.evento!.eveCodigo,
        eveNome: nomeController.text,
        eveDataInicio: FuncoesData.stringToDateTime(dataInicioController.text),
        eveDataFim: FuncoesData.stringToDateTime(dataFimController.text),
      );
    }
    return EventoModel(
      eveCodigo: 0,
      eveNome: nomeController.text,
      eveDataInicio: FuncoesData.stringToDateTime(dataInicioController.text),
      eveDataFim: FuncoesData.stringToDateTime(dataFimController.text),
    );
  }

  gravarEvento() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().addEvento(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Evento cadastrado com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao cadastrar evento !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  atualizarEvento() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().updateEvento(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Evento atualizado com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao atualizar evento !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.evento != null) {
      nomeController.text = widget.evento!.eveNome;
      dataInicioController.text = widget.evento!.eveDataInicio;
      dataFimController.text = widget.evento!.eveDataFim;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: formKey,
      titulo: "Cadastro de Evento",
      altura: 4.5,
      largura: 2,
      gravar: () {
        if (formKey.currentState!.validate()) {
          if (widget.evento != null) {
            atualizarEvento();
          } else {
            gravarEvento();
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Cores.vermelhoMedio,
              content: Text("Por favor, preencha os campos obrigatórios !"),
            ),
          );
        }
      },
      cancelar: () {},
      campos: [
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
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/classes.dart';

class CadastroQuarto extends StatefulWidget {
  QuartoModel? quarto;

  CadastroQuarto({super.key, this.quarto});

  @override
  State<CadastroQuarto> createState() => _CadastroQuartoState();
}

class _CadastroQuartoState extends State<CadastroQuarto> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController camasController = TextEditingController();

  bool carregando = false;

  int blocoSelecionada = 0;

  List<DropdownMenuItem> listaBlocos = [];

  preparaDados() {
    if (widget.quarto != null) {
      return QuartoModel(
        quaCodigo: widget.quarto!.quaCodigo,
        quaNome: nomeController.text,
        bloCodigo: blocoSelecionada,
        bloco: "",
        quaQtdCamas: int.parse(camasController.text),
        quaQtdCamaslivres: widget.quarto!.quaQtdCamaslivres,
        pessoas: widget.quarto!.pessoas,
      );
    }
    return QuartoModel(
      quaCodigo: 0,
      quaNome: nomeController.text,
      bloCodigo: blocoSelecionada,
      bloco: "",
      quaQtdCamas: int.parse(camasController.text),
      quaQtdCamaslivres: 0,
      pessoas: [],
    );
  }

  gravarQuartos() async {
    setState(() => carregando = true);
    var retorno = await ApiQuarto().addQuarto(preparaDados());
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Quarto cadastrado com sucesso !"),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao cadastrar quarto !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  atualizarQuarto() async {
    setState(() => carregando = true);
    var retorno = await ApiQuarto().updateQuarto(preparaDados());
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Quarto atualizado com sucesso !"),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao atualizar quarto !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarBlocos() async {
    setState(() => carregando = true);
    var retorno = await ApiBloco().getBlocos();
    if (retorno.statusCode == 200) {
      listaBlocos.clear();
      listaBlocos.add(
        const DropdownMenuItem(
          value: 0,
          child: Text('Selecione um bloco'),
        ),
      );
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(
          () => listaBlocos.add(
            DropdownMenuItem(
              value: item['bloCodigo'],
              child: Text(item['bloNome']),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer blocos !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarBlocos();
    if (widget.quarto != null) {
      nomeController.text = widget.quarto!.quaNome;
      camasController.text = widget.quarto!.quaQtdCamas.toString();
      blocoSelecionada = widget.quarto!.bloCodigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: formKey,
      titulo: 'Quartos',
      altura: 4.5,
      largura: 2,
      gravar: () {
        if (formKey.currentState!.validate()) {
          widget.quarto == null ? gravarQuartos() : atualizarQuarto();
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
                  maxLength: 250,
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
                      return 'Por favor, digite o nome do quarto';
                    }
                    return null;
                  },
                ),
              ),
            ),
            carregando
                ? const Expanded(
                    flex: 4,
                    child: Center(child: CarregamentoIOS()),
                  )
                : Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 20,
                      ),
                      child: DropdownButtonFormField(
                        // value: blocoSelecionada,
                        value: widget.quarto != null &&
                                widget.quarto!.bloCodigo != 0
                            ? widget.quarto!.bloCodigo
                            : blocoSelecionada,
                        decoration: const InputDecoration(
                          labelText: 'Blocos',
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
                        items: listaBlocos,
                        onChanged: (value) {
                          setState(() {
                            blocoSelecionada = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value < 1) {
                            return 'Por favor, selecione um bloco';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: camasController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: const InputDecoration(
                    labelText: 'Qtd. Camas',
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
                      return 'Por favor, digite a quantidade de camas';
                    }
                    return null;
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

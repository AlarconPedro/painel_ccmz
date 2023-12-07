import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class CadastroQuarto extends StatefulWidget {
  const CadastroQuarto({super.key});

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
    return QuartoModel(
      quaCodigo: 0,
      quaNome: nomeController.text,
      bloCodigo: blocoSelecionada,
      bloco: "",
      quaQtdCamas: int.parse(camasController.text),
    );
  }

  gravarQuartos() async {}

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: formKey,
      titulo: 'Quartos',
      gravar: () {},
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
                          if (value == null || value.isEmpty) {
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

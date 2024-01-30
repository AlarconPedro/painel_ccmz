import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';
import '../../widgets/widgets.dart';

class EstruturaAlocacaoEvento extends StatefulWidget {
  GlobalKey<FormState> formKey;

  Widget comboPessoas;
  Widget comboComunidade;
  Widget comboEvento;
  Widget comboBloco;
  Widget pageView;
  Widget botaoSalvar;
  Widget botaoVoltar;
  Widget botaoFechar;

  Function(String) buscar;

  EstruturaAlocacaoEvento({
    super.key,
    required this.formKey,
    required this.comboPessoas,
    required this.comboComunidade,
    required this.comboEvento,
    required this.comboBloco,
    required this.pageView,
    required this.botaoSalvar,
    required this.botaoVoltar,
    required this.botaoFechar,
    required this.buscar,
  });

  @override
  State<EstruturaAlocacaoEvento> createState() =>
      _EstruturaAlocacaoEventoState();
}

class _EstruturaAlocacaoEventoState extends State<EstruturaAlocacaoEvento> {
  TextEditingController buscaPessoas = TextEditingController();

  bool carregando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Cores.branco,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width / 1.1,
              child: Form(
                key: widget.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pessoas Evento",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Alocação de Evento",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                            left: 2,
                                            right: 2,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 55,
                                                  child: CupertinoTextField(
                                                    controller: buscaPessoas,
                                                    onSubmitted: (value) async {
                                                      if (value.isNotEmpty) {
                                                        setState(() =>
                                                            carregando = true);
                                                        await widget
                                                            .buscar(value);
                                                        setState(() {
                                                          buscaPessoas.clear();
                                                          carregando = false;
                                                        });
                                                      }
                                                    },
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(10),
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            Cores.cinzaEscuro,
                                                      ),
                                                    ),
                                                    placeholder: 'Pesquisar',
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              CupertinoButton(
                                                color: Cores.preto,
                                                onPressed: () async {
                                                  if (buscaPessoas
                                                      .text.isNotEmpty) {
                                                    setState(() =>
                                                        carregando = true);
                                                    await widget.buscar(
                                                        buscaPessoas.text);
                                                    setState(() {
                                                      buscaPessoas.clear();
                                                      carregando = false;
                                                    });
                                                  }
                                                },
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 16,
                                                  horizontal: 16,
                                                ),
                                                child: const Icon(
                                                    CupertinoIcons.search),
                                              ),
                                            ],
                                          ),
                                        ),
                                        widget.comboComunidade,
                                        const SizedBox(height: 5),
                                        widget.comboPessoas,
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 10,
                                              left: 2,
                                              right: 2,
                                            ),
                                            child: Row(
                                              children: [
                                                widget.comboEvento,
                                                const SizedBox(width: 10),
                                                widget.comboBloco,
                                              ],
                                            ),
                                          ),
                                          widget.pageView,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          widget.botaoVoltar,
                          const Spacer(),
                          widget.botaoFechar,
                          widget.botaoSalvar,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

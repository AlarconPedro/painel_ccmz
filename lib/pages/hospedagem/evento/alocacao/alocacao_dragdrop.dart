import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../classes/classes.dart';

class AlocacaoDragDrop extends StatefulWidget {
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

  AlocacaoDragDrop({
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
  State<AlocacaoDragDrop> createState() => _AlocacaoDragDropState();
}

class _AlocacaoDragDropState extends State<AlocacaoDragDrop> {
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
            child: Container(
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: const BoxDecoration(
                  color: Cores.branco,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                          Flexible(
                            fit: FlexFit.tight,
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
                          Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
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
                    Flexible(
                      child: Column(
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            widget.comboEvento,
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Row(
                                          children: [
                                            widget.comboBloco,
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        widget.comboComunidade,
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                            left: 2,
                                            right: 2,
                                          ),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                fit: FlexFit.tight,
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
                                        widget.comboPessoas,
                                        const SizedBox(height: 5),
                                        SizedBox(
                                          width: double.infinity,
                                          child: CupertinoButton(
                                            color: Cores.azulMedio,
                                            onPressed: () async {
                                              setState(() => carregando = true);
                                              await widget.buscar("");
                                              // buscarPessoasComunidade(comunidadeSelecionada);

                                              setState(
                                                  () => carregando = false);
                                            },
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 10,
                                            ),
                                            child: carregando
                                                ? const CupertinoActivityIndicator()
                                                : const Text(
                                                    "Listar Todos",
                                                    style: TextStyle(
                                                      color: Cores.branco,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [widget.pageView],
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

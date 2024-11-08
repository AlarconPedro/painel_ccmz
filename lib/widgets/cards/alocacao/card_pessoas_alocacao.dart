import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';

class CardPessoasAlocacao extends StatefulWidget {
  PessoaModel pessoa;

  Function addPessoa;
  Function removePessoa;
  Function excluir;

  int vagas;
  int ocupadas;

  bool selecionado;

  CardPessoasAlocacao({
    super.key,
    required this.pessoa,
    required this.addPessoa,
    required this.removePessoa,
    required this.vagas,
    required this.ocupadas,
    required this.selecionado,
    required this.excluir,
  });

  @override
  State<CardPessoasAlocacao> createState() => _CardPessoasAlocacaoState();
}

class _CardPessoasAlocacaoState extends State<CardPessoasAlocacao> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              color: widget.selecionado
                  ? Cores.verdeMedio.withOpacity(0.5)
                  : Cores.branco,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (widget.vagas == widget.ocupadas &&
                        !widget.selecionado) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Não há vagas disponíveis neste quarto!",
                            style: TextStyle(
                              color: Cores.branco,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Cores.vermelhoMedio,
                        ),
                      );
                    } else {
                      if (widget.selecionado) {
                        widget.removePessoa();
                      } else {
                        widget.addPessoa();
                      }
                      setState(() {
                        widget.selecionado = !widget.selecionado;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.selecionado
                          ? Cores.verdeMedio.withOpacity(0.5)
                          : Cores.branco,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    height: 60,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    widget.pessoa.pesNome,
                                    style: TextStyle(
                                      color: widget.selecionado
                                          ? Cores.branco
                                          : Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  color: widget.selecionado
                                      ? Cores.branco
                                      : Cores.preto,
                                  widget.pessoa.pesGenero == "F"
                                      ? Icons.female_rounded
                                      : Icons.male_rounded,
                                ),
                              ),
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
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text("Excluir Pessoa"),
                    content: const Text(
                        "Deseja realmente remover esta pessoa do evento ?"),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text("Não",
                            style: TextStyle(color: Cores.vermelhoMedio)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text("Sim",
                            style: TextStyle(color: Cores.verdeMedio)),
                        onPressed: () {
                          Navigator.pop(context);
                          widget.excluir();
                        },
                      ),
                    ],
                  );
                },
              );
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: const Text(
              //       "Deseja realmente excluir esta pessoa?",
              //       style: TextStyle(
              //         color: Cores.branco,
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     backgroundColor: Cores.vermelhoMedio,
              //     action: SnackBarAction(
              //       label: "Excluir",
              //       textColor: Cores.branco,
              //       onPressed: () {},
              //     ),
              //   ),
              // );
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Cores.branco,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Cores.preto.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  CupertinoIcons.trash,
                  color: Cores.vermelhoMedio,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

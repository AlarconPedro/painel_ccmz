import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../../classes/classes.dart';

class CardPessoasAlocacao extends StatefulWidget {
  PessoaModel pessoa;

  Function addPessoa;
  Function removePessoa;

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
  });

  @override
  State<CardPessoasAlocacao> createState() => _CardPessoasAlocacaoState();
}

class _CardPessoasAlocacaoState extends State<CardPessoasAlocacao> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color:
          widget.selecionado ? Cores.verdeMedio.withOpacity(0.5) : Cores.branco,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (widget.vagas == widget.ocupadas && !widget.selecionado) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          color:
                              widget.selecionado ? Cores.branco : Cores.preto,
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
    );
  }
}

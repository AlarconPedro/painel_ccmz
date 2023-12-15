import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../../classes/classes.dart';

class CardPessoasEvento extends StatefulWidget {
  PessoaModel pessoa;
  List<int> pessoasSelecionadas;
  bool selecionado;

  CardPessoasEvento({
    super.key,
    required this.pessoa,
    required this.pessoasSelecionadas,
    required this.selecionado,
  });

  @override
  State<CardPessoasEvento> createState() => _CardPessoasEventoState();
}

class _CardPessoasEventoState extends State<CardPessoasEvento> {
  bool pagante = true;

  bool cobrar = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: widget.selecionado ? Cores.azulClaro : Cores.branco,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: 350,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.selecionado ? Cores.azulClaro : Cores.branco,
        ),
        child: Row(children: [
          Container(
            color: Cores.cinzaClaro,
            width: 100,
            child: Center(
              child: Icon(
                widget.pessoa.pesGenero == "F"
                    ? Icons.female_rounded
                    : Icons.male_rounded,
                size: 50,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                color: widget.selecionado ? Cores.azulClaro : Cores.branco,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                widget.pessoa.pesNome,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: widget.selecionado
                                      ? Cores.branco
                                      : Cores.cinzaEscuro,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Comunidade:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.selecionado
                                    ? Cores.branco
                                    : Cores.cinzaEscuro,
                              ),
                            ),
                            Text(
                              widget.pessoa.comunidade,
                              style: TextStyle(
                                color: widget.selecionado
                                    ? Cores.branco
                                    : Cores.cinzaEscuro,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sexo:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.selecionado
                                    ? Cores.branco
                                    : Cores.cinzaEscuro,
                              ),
                            ),
                            Text(
                              widget.pessoa.pesGenero,
                              style: TextStyle(
                                color: widget.selecionado
                                    ? Cores.branco
                                    : Cores.cinzaEscuro,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "Pagante:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.selecionado
                                    ? Cores.branco
                                    : Cores.cinzaEscuro,
                              ),
                            ),
                            CupertinoCheckbox(
                              value: pagante,
                              onChanged: (value) {
                                setState(() {
                                  pagante = value!;
                                });
                              },
                              checkColor: widget.selecionado
                                  ? Cores.branco
                                  : Cores.cinzaEscuro,
                              activeColor: widget.selecionado
                                  ? Cores.cinzaEscuro
                                  : Cores.branco,
                              side: BorderSide(
                                  color: widget.selecionado
                                      ? Cores.branco
                                      : Cores.cinzaEscuro),
                            ),
                            const Expanded(child: SizedBox()),
                            Text(
                              "Cobrar:",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.selecionado
                                    ? Cores.branco
                                    : Cores.cinzaEscuro,
                              ),
                            ),
                            CupertinoCheckbox(
                              value: cobrar,
                              onChanged: (value) {
                                setState(() {
                                  cobrar = value!;
                                });
                              },
                              checkColor: widget.selecionado
                                  ? Cores.branco
                                  : Cores.cinzaEscuro,
                              activeColor: widget.selecionado
                                  ? Cores.cinzaEscuro
                                  : Cores.branco,
                              side: BorderSide(
                                  color: widget.selecionado
                                      ? Cores.branco
                                      : Cores.cinzaEscuro),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}

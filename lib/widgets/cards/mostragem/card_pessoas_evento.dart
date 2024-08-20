import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';
import '../../../data/models/web/hospedagem/evento_pessoas_model.dart';
import '../../../data/models/web/hospedagem/pessoa_model.dart';

class CardPessoasEvento extends StatefulWidget {
  PessoaModel pessoa;
  List<int> pessoasSelecionadas;
  bool selecionado;

  int eventoSelecionado;

  Function updatePagante;
  Function updateCobrante;

  CardPessoasEvento({
    super.key,
    required this.pessoa,
    required this.pessoasSelecionadas,
    required this.selecionado,
    required this.eventoSelecionado,
    required this.updateCobrante,
    required this.updatePagante,
  });

  @override
  State<CardPessoasEvento> createState() => _CardPessoasEventoState();
}

class _CardPessoasEventoState extends State<CardPessoasEvento> {
  bool carregando = false;

  preparaDadosUpdate(PessoaModel pessoa) {
    return EventoPessoasModel(
      evpCodigo: pessoa.evpCodigo,
      eveCodigo: widget.eventoSelecionado,
      pesCodigo: pessoa.pesCodigo,
      evpPagante: pessoa.pesPagante,
      evpCobrante: pessoa.pesCobrante,
    );
  }

  updatePessoasEvento(PessoaModel pessoa) async {
    setState(() => carregando = true);
    var retorno =
        await ApiEvento().updatePessoaEvento(preparaDadosUpdate(pessoa));
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Pessoa atualizada com sucesso !"),
        ),
      );
      // Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao gravar pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: widget.selecionado ? Cores.azulClaro : Cores.branco,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: 380,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: widget.selecionado ? Cores.azulClaro : Cores.branco,
        ),
        child: Row(
          children: [
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
                          padding: const EdgeInsets.only(left: 10),
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
                                value: widget.pessoa.evpCodigo != 0
                                    ? widget.pessoa.pesPagante
                                    : true,
                                onChanged: (value) {
                                  setState(() {
                                    widget.pessoa.pesPagante = value!;
                                    updatePessoasEvento(widget.pessoa);
                                    // ?
                                    // : widget.pessoa.pesPagante = !value!;
                                  });
                                  // pagante = value!;
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
                                value: widget.pessoa.evpCodigo != 0
                                    ? widget.pessoa.pesCobrante
                                    : true,
                                onChanged: (value) {
                                  // widget.updateCobrante(value!);
                                  setState(() {
                                    widget.pessoa.pesCobrante = value!;
                                    updatePessoasEvento(widget.pessoa);
                                    // ?
                                    // : widget.pessoa.pesCobrante = !value!;
                                  });
                                  // cobrar = value!;
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
          ],
        ),
      ),
    );
  }
}

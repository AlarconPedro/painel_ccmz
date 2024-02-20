import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';

class QuartosEvento extends StatefulWidget {
  int codigoEvento;
  QuartosEvento({super.key, required this.codigoEvento});

  @override
  State<QuartosEvento> createState() => _QuartosEventoState();
}

class _QuartosEventoState extends State<QuartosEvento> {
  List<DropdownMenuItem> listaBlocos = [];
  List<QuartoModel> quartos = [];

  int blocoSelecionado = 0;
  List<int> quartosSelecionados = [];
  int camasSelecionadas = 0;

  bool carregando = true;

  buscarBlocos() async {
    setState(() => carregando = true);
    var retorno = await ApiBloco().getBlocos();
    if (retorno.statusCode == 200) {
      listaBlocos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => listaBlocos.add(
              DropdownMenuItem(
                value: item["bloCodigo"],
                child: Text(item["bloNome"]),
              ),
            ));
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

  buscarQuartosPavilhao(int value) async {
    setState(() => carregando = true);
    var retorno =
        await ApiEvento().getQuartosPavilhao(value, widget.codigoEvento);
    if (retorno.statusCode == 200) {
      quartos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => quartos.add(QuartoModel.fromJson(item)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer quartos !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarQuartosAlocados(int bloco) async {
    setState(() => carregando = true);
    var retorno =
        await ApiEvento().getQuartosAlocados(bloco, widget.codigoEvento);
    if (retorno.statusCode == 200) {
      quartosSelecionados.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => quartosSelecionados.add(item["quaCodigo"]));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer quartos !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  preparaDados() {
    List<EventoQuartoModel> lista = [];
    for (var item in quartosSelecionados) {
      lista.add(EventoQuartoModel(
        evqCodigo: 0,
        quaCodigo: item,
        eveCodigo: widget.codigoEvento,
      ));
    }
    return lista;
  }

  salvarQuartos() async {
    setState(() => carregando = true);
    var retorno =
        await ApiEvento().addQuartoEvento(preparaDados(), blocoSelecionado);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeMedio,
          content: Text("Quartos adicionados com sucesso !"),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao adicionar quartos !"),
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
  }

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
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Quartos do Evento",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      // mainAxisAlignment: ,
                      children: [
                        Expanded(
                          child: carregando
                              ? const CarregamentoIOS()
                              : DropdownButtonFormField(
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
                                  value: blocoSelecionado == 0
                                      ? null
                                      : blocoSelecionado,
                                  items: listaBlocos,
                                  onChanged: (value) async {
                                    await buscarQuartosAlocados(value);
                                    await buscarQuartosPavilhao(value);
                                    setState(
                                      () {
                                        camasSelecionadas = 0;
                                        for (var item in quartos) {
                                          if (quartosSelecionados
                                              .contains(item.quaCodigo)) {
                                            camasSelecionadas +=
                                                item.quaQtdCamaslivres;
                                          }
                                        }
                                        blocoSelecionado = value;
                                      },
                                    );
                                  },
                                ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Quartos Selecionados: ${quartosSelecionados.length}",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Camas Selecionadas: $camasSelecionadas",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Selecionar Todos",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                              SizedBox(
                                  child: CupertinoButton(
                                color: Cores.verdeMedio,
                                padding: const EdgeInsets.all(15),
                                onPressed: () {
                                  if (quartosSelecionados.length <
                                      quartos.length) {
                                    setState(() {
                                      camasSelecionadas = 0;
                                      quartosSelecionados = quartos
                                          .map((e) => e.quaCodigo)
                                          .toList();
                                      for (var item in quartos) {
                                        camasSelecionadas +=
                                            item.quaQtdCamaslivres;
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      camasSelecionadas = 0;
                                      quartosSelecionados.clear();
                                    });
                                  }
                                },
                                child: const Icon(
                                  CupertinoIcons.checkmark_square,
                                  color: Cores.branco,
                                ),
                              )),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Cores.cinzaEscuro,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Expanded(
                    child: blocoSelecionado == 0
                        ? const Center(
                            child: Text("Selecione um bloco"),
                          )
                        : Wrap(
                            children: [
                              for (var quarto in quartos)
                                carregando
                                    ? const Expanded(child: CarregamentoIOS())
                                    : MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (quartosSelecionados
                                                  .contains(quarto.quaCodigo)) {
                                                quartosSelecionados
                                                    .remove(quarto.quaCodigo);
                                                camasSelecionadas -=
                                                    quarto.quaQtdCamaslivres;
                                              } else {
                                                quartosSelecionados
                                                    .add(quarto.quaCodigo);
                                                camasSelecionadas +=
                                                    quarto.quaQtdCamaslivres;
                                              }
                                            });
                                          },
                                          child: CardQuartosEvento(
                                            quarto: quarto,
                                            quartosSelecionados:
                                                quartosSelecionados,
                                            selecionado: quartosSelecionados
                                                .contains(quarto.quaCodigo),
                                          ),
                                        ),
                                      ),
                            ],
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: CupertinoButton(
                          color: Cores.vermelhoMedio,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: CupertinoButton(
                          color: Cores.verdeMedio,
                          onPressed: () {
                            salvarQuartos();
                          },
                          child: const Text("Gravar"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

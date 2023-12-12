import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/widgets/loading/carregamento_ios.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class QuartosEvento extends StatefulWidget {
  const QuartosEvento({super.key});

  @override
  State<QuartosEvento> createState() => _QuartosEventoState();
}

class _QuartosEventoState extends State<QuartosEvento> {
  List<DropdownMenuItem> listaBlocos = [];
  List<QuartoModel> quartos = [];

  int blocoSelecionado = 0;
  List<int> quartosSelecionados = [];

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
    var retorno = await ApiEvento().getQuartosPavilhao(value);
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
                      child: Text("Quartos do Evento",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      // mainAxisAlignment: ,
                      children: [
                        Expanded(
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
                            onChanged: (value) async {
                              await buscarQuartosPavilhao(value);
                              setState(() => blocoSelecionado = value);
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Quartos Selecionados: ${quartosSelecionados.length}",
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                        : carregando
                            ? const Expanded(child: CarregamentoIOS())
                            : Wrap(
                                children: [
                                  for (var quarto in quartos)
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (quartosSelecionados
                                                .contains(quarto.quaCodigo)) {
                                              quartosSelecionados
                                                  .remove(quarto.quaCodigo);
                                            } else {
                                              quartosSelecionados
                                                  .add(quarto.quaCodigo);
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
                          onPressed: () {},
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

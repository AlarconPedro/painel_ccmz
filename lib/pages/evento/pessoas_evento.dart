import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';

class PessoasEvento extends StatefulWidget {
  int codigoEvento;
  PessoasEvento({super.key, required this.codigoEvento});

  @override
  State<PessoasEvento> createState() => _PessoasEventoState();
}

class _PessoasEventoState extends State<PessoasEvento> {
  bool carregando = false;

  List<PessoaModel> pessoas = [];
  List<ComunidadeModel> comunidades = [];

  int comunidadeSelecionada = 0;

  List<int> pessoasSelecionadas = [];

  List<DropdownMenuItem<int>> listaComunidades = [];

  buscarPessoas() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento()
        .getPessoasEvento(comunidadeSelecionada, widget.codigoEvento);
    if (retorno.statusCode == 200) {
      pessoas.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => pessoas.add(PessoaModel.fromJson(item)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarPessoasAlocadas() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento()
        .getPessoasAlocadas(comunidadeSelecionada, widget.codigoEvento);
    if (retorno.statusCode == 200) {
      pessoasSelecionadas.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => pessoasSelecionadas.add(item["pesCodigo"]));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarComunidades() async {
    setState(() => carregando = true);
    var retorno = await ApiComunidade().getComunidades("Todos");
    if (retorno.statusCode == 200) {
      comunidades.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => comunidades.add(ComunidadeModel.fromJson(item)));
      }
      listaComunidades.clear();
      // listaComunidades.add(
      //   const DropdownMenuItem(
      //     value: 0,
      //     child: Text("Selecione uma comunidade"),
      //   ),
      // );
      for (var item in comunidades) {
        listaComunidades.add(
          DropdownMenuItem(
            value: item.comCodigo,
            child: Text("${item.comNome} - ${item.comCidade} - ${item.comUF}"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer comunidades !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  preparaDadosUpload() {
    List<EventoPessoasModel> pessoasEvento = [];
    for (var pessoa in pessoas) {
      if (pessoasSelecionadas.contains(pessoa.pesCodigo)) {
        pessoasEvento.add(
          EventoPessoasModel(
            evpCodigo: pessoa.evpCodigo != 0 ? pessoa.evpCodigo : 0,
            eveCodigo: widget.codigoEvento,
            pesCodigo: pessoa.pesCodigo,
            evpPagante: pessoa.evpCodigo != 0 ? pessoa.pesPagante : true,
            evpCobrante: pessoa.evpCodigo != 0 ? pessoa.pesCobrante : true,
          ),
        );
      }

      // for (var item in pessoasSelecionadas) {
      //   if (pessoas.where((element) => element.pesCodigo == item).isNotEmpty) {
      //     pessoasEvento.add(
      //       EventoPessoasModel(
      //         evpCodigo: pessoas
      //             .where((element) => element.pesCodigo == item)
      //             .first
      //             .evpCodigo,
      //         eveCodigo: widget.codigoEvento,
      //         pesCodigo: item,
      //         evpPagante: pessoas
      //             .where((element) => element.pesCodigo == item)
      //             .first
      //             .pesPagante,
      //         evpCobrante: pessoas
      //             .where((element) => element.pesCodigo == item)
      //             .first
      //             .pesCobrante,
      //       ),
      //     );
      //   } else {
      //     pessoasEvento.add(
      //       EventoPessoasModel(
      //         evpCodigo: 0,
      //         eveCodigo: widget.codigoEvento,
      //         pesCodigo: item,
      //         evpPagante: true,
      //         evpCobrante: true,
      //       ),
      //     );
      //   }
    }
    return pessoasEvento;
  }

  List<EventoPessoasModel> preparaDadosDelete() {
    List<EventoPessoasModel> pessoasEvento = [];
    for (var pessoa in pessoas) {
      pessoasEvento.add(EventoPessoasModel(
        evpCodigo: pessoa.evpCodigo,
        eveCodigo: widget.codigoEvento,
        pesCodigo: pessoa.pesCodigo,
        evpPagante: pessoa.pesPagante,
        evpCobrante: pessoa.pesCobrante,
      ));
    }
    return pessoasEvento;
  }

  salvarPessoas() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().addPessoasEvento(
      preparaDadosUpload(),
      comunidadeSelecionada,
    );
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Pessoas gravadas com sucesso !"),
        ),
      );
      buscarPessoas();
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

  retirarPessoasEvento() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().deletePessoasEvento(preparaDadosDelete());
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Pessoas retiradas com sucesso !"),
        ),
      );
      buscarPessoas();
      // Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao retirar pessoas !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarPessoas();
    buscarComunidades();
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
                      child: Text("Pessoas do Evento",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: carregando
                              ? const CarregamentoIOS()
                              : DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Comunidades',
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
                                  value: comunidadeSelecionada == 0
                                      ? null
                                      : comunidadeSelecionada,
                                  items: listaComunidades,
                                  onChanged: (value) async {
                                    setState(() {
                                      pessoasSelecionadas.clear();
                                      comunidadeSelecionada = value!;
                                    });
                                    await buscarPessoasAlocadas();
                                    await buscarPessoas();
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
                                  "Pessoas Selecionadas: ${pessoasSelecionadas.length}",
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
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
                                    if (pessoasSelecionadas.length <
                                        pessoas.length) {
                                      setState(() {
                                        pessoasSelecionadas = pessoas
                                            .map((e) => e.pesCodigo)
                                            .toList();
                                      });
                                    } else {
                                      setState(() {
                                        pessoasSelecionadas.clear();
                                      });
                                    }
                                  },
                                  child: const Icon(
                                    CupertinoIcons.checkmark_square,
                                    color: Cores.branco,
                                  ),
                                ),
                              ),
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
                  Flexible(
                    fit: FlexFit.tight,
                    child: comunidadeSelecionada == 0
                        ? const Center(
                            child: Text("Selecione uma comunidade"),
                          )
                        : carregando
                            ? const Center(child: CarregamentoIOS())
                            : SingleChildScrollView(
                                child: SizedBox(
                                  child: Wrap(
                                    children: [
                                      for (var pessoa in pessoas)
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (pessoasSelecionadas
                                                    .contains(
                                                        pessoa.pesCodigo)) {
                                                  pessoasSelecionadas
                                                      .remove(pessoa.pesCodigo);
                                                } else {
                                                  pessoasSelecionadas
                                                      .add(pessoa.pesCodigo);
                                                }
                                              });
                                            },
                                            child: CardPessoasEvento(
                                              pessoa: pessoa,
                                              updatePagante: (value) async {
                                                // setState(() {
                                                //   pessoa.pesPagante = value;
                                                // });
                                                // pessoa.pesPagante = value;
                                                // await updatePessoasEvento(
                                                //     pessoa);
                                              },
                                              updateCobrante: (value) async {
                                                // setState(() {
                                                //   pessoa.pesCobrante = value;
                                                // });
                                                // pessoa.pesCobrante = value;
                                                // await updatePessoasEvento(
                                                //     pessoa);
                                              },
                                              pessoasSelecionadas:
                                                  pessoasSelecionadas,
                                              selecionado: pessoasSelecionadas
                                                  .contains(pessoa.pesCodigo),
                                              eventoSelecionado:
                                                  widget.codigoEvento,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
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
                          child: const Text("Fechar"),
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
                            pessoasSelecionadas.isNotEmpty
                                ? salvarPessoas()
                                : retirarPessoasEvento();
                            // salvarPessoas();
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

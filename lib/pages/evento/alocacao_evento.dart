import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/pages/pages.dart';

import '../../classes/classes.dart';
import '../../data/data.dart';
import '../../widgets/widgets.dart';

class AlocacaoEvento extends StatefulWidget {
  const AlocacaoEvento({super.key});

  @override
  State<AlocacaoEvento> createState() => _AlocacaoEventoState();
}

class _AlocacaoEventoState extends State<AlocacaoEvento> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();

  PageController alocacaoController = PageController();

  bool exibirBlocos = false;
  bool exibirVoltar = false;
  bool carregando = false;

  int eventoSelecionado = 0;
  int quartoSelecionado = 0;
  int blocoSelecionado = 0;
  int comunidadeSelecionada = 0;

  List<DropdownMenuItem> eventos = [];
  List<DropdownMenuItem> blocos = [];
  List<DropdownMenuItem> comunidades = [];
  List<QuartoModel> quartos = [];
  List<PessoaModel> pessoas = [];

  List<PessoaModel> pessoasSelecionadas = [];

  QuartoModel quarto = QuartoModel(
    quaCodigo: 0,
    quaNome: "",
    bloCodigo: 0,
    bloco: "",
    quaQtdCamas: 0,
    quaQtdCamaslivres: 0,
  );

  buscarEventos() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().getEventoNomes();
    if (retorno.statusCode == 200) {
      eventos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          eventos.add(
            DropdownMenuItem(
              value: item["eveCodigo"],
              child: Text(item["eveNome"]),
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar eventos!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarBlocos() async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao().getAlocacaoBlocos(eventoSelecionado);
    if (retorno.statusCode == 200) {
      blocos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          blocos.add(
            DropdownMenuItem(
              value: item["bloCodigo"],
              child: Text(item["bloNome"]),
            ),
            // BlocoModel.fromJson(item),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar blocos!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarQuartos() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento()
        .getQuartosAlocados(blocoSelecionado, eventoSelecionado);
    if (retorno.statusCode == 200) {
      quartos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          quartos.add(
            QuartoModel.fromJson(item),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar quartos!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarComunidades() async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao().getAlocacaoComunidades(eventoSelecionado);
    if (retorno.statusCode == 200) {
      comunidades.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          comunidades.add(
            DropdownMenuItem(
              value: item["comCodigo"],
              child: Text(item["comNome"]),
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar comunidades!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarPessoasComunidade(int codigoComunidade) async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao()
        .getPessoasComunidade(eventoSelecionado, codigoComunidade);
    if (retorno.statusCode == 200) {
      pessoas.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          pessoas.add(PessoaModel.fromJson(item));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar comunidades!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    buscarEventos();
  }

  @override
  Widget build(BuildContext context) {
    return EstruturaAlocacaoEvento(
      formKey: formKey,
      comboEvento: Expanded(
        child: SizedBox(
          height: 60,
          child: DropDownForm(
            label: 'Evento',
            itens: eventos,
            selecionado: 0,
            onChange: (value) {
              setState(() {
                if (value != 0) {
                  exibirBlocos = true;
                } else {
                  exibirBlocos = false;
                }
                eventoSelecionado = value;
              });
              buscarBlocos();
              buscarComunidades();
            },
          ),
        ),
      ),
      comboPessoas: Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Cores.cinzaClaro,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: ListView.builder(
              itemCount: pessoas.length,
              itemBuilder: (context, index) {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // pessoas[index]
                        //         .pesSelecionado =
                        //     !pessoas[index]
                        //         .pesSelecionado;
                      });
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          pessoas[index].pesNome,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          pessoas[index].pesGenero,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(CupertinoIcons.chevron_forward),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      comboComunidade: SizedBox(
        height: 60,
        child: DropDownForm(
          label: 'Comunidade',
          itens: comunidades,
          selecionado: 0,
          onChange: (value) {
            setState(() {
              comunidadeSelecionada = value;
            });
            buscarPessoasComunidade(value);
          },
        ),
      ),
      comboBloco: Visibility(
        visible: exibirBlocos,
        child: Expanded(
          child: SizedBox(
            height: 60,
            child: DropDownForm(
              label: 'Bloco',
              itens: blocos,
              selecionado: 0,
              onChange: (value) {
                setState(() {
                  blocoSelecionado = value;
                });
                buscarQuartos();
              },
            ),
          ),
        ),
      ),
      pageView: Expanded(
        child: Container(
          color: Cores.branco,
          child: PageView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            controller: alocacaoController,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Cores.cinzaClaro,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  child: Expanded(
                    child: SingleChildScrollView(
                        child: Wrap(
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: [
                        for (var item in quartos)
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  quarto = item;
                                  alocacaoController.animateToPage(
                                    1,
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    curve: Curves.ease,
                                  );
                                  exibirVoltar = true;
                                });
                              },
                              child: CardEventoQuarto(
                                quarto: item,
                              ),
                            ),
                          )
                      ],
                    )),
                  ),
                ),
              ),
              AlocacaoEventoPessoas(
                quarto: quarto,
                removePessoa: (int pessoa) {
                  setState(() {
                    pessoasSelecionadas.remove(pessoa);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      botaoSalvar: Visibility(
        visible: exibirVoltar,
        child: CupertinoButton(
          onPressed: () {
            setState(() {
              alocacaoController.animateToPage(
                0,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.ease,
              );
              exibirVoltar = false;
            });
          },
          color: Cores.verdeMedio,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 30,
          ),
          child: const Text("Salvar"),
        ),
      ),
      botaoVoltar: Visibility(
        visible: exibirVoltar,
        child: CupertinoButton(
          onPressed: () {
            setState(() {
              alocacaoController.animateToPage(
                0,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.ease,
              );
              exibirVoltar = false;
            });
          },
          color: Cores.vermelhoMedio,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 30,
          ),
          child: const Text("Voltar"),
        ),
      ),
      botaoFechar: Visibility(
        visible: !exibirVoltar,
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Cores.verdeMedio,
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 30,
          ),
          child: const Text("Fechar"),
        ),
      ),
    );
  }
}

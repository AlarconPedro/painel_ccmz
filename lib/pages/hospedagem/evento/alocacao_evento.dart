import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../../classes/classes.dart';
import '../../../data/data.dart';
import '../../../widgets/widgets.dart';

class AlocacaoEvento extends StatefulWidget {
  int codigoEvento;
  AlocacaoEvento({super.key, required this.codigoEvento});

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

  int ocupadas = 0;

  List<DropdownMenuItem> eventos = [];
  List<DropdownMenuItem> blocos = [];
  List<DropdownMenuItem> comunidades = [];
  List<QuartoModel> quartos = [];
  List<PessoaModel> pessoas = [];

  List<PessoaModel> pessoasSelecionadas = [];

  List<Widget> vagasQuarto = [];

  List<PessoaModel> pessoasQuarto = [];

  QuartoModel quarto = QuartoModel(
    quaCodigo: 0,
    quaNome: "",
    bloCodigo: 0,
    bloco: "",
    quaQtdCamas: 0,
    quaQtdCamaslivres: 0,
    pessoas: [],
  );

  buscarEventos() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().getEvento(widget.codigoEvento);
    if (retorno.statusCode == 200) {
      eventos.clear();
      var decoded = json.decode(retorno.body);
      // for (var item in decoded) {
      setState(() {
        eventos.add(
          DropdownMenuItem(
            value: decoded["eveCodigo"],
            child: Text(decoded["eveNome"]),
          ),
        );
      });
      // var retorno = await ApiEvento().getEventosAtivos();
      // if (retorno.statusCode == 200) {
      //   if (retorno.body != "[]") {
      //     eventos.clear();
      //     var decoded = json.decode(retorno.body);
      //     for (var item in decoded) {
      //       setState(() {
      //         eventos.add(
      //           DropdownMenuItem(
      //             value: item["eveCodigo"],
      //             child: Text(item["eveNome"]),
      //           ),
      //         );
      //       });
      //     }
      //   } else {
      //     retorno = await ApiEvento().getEvento(widget.codigoEvento);
      //     if (retorno.statusCode == 200) {
      //       eventos.clear();
      //       var decoded = json.decode(retorno.body);
      //       setState(() {
      //         eventos.add(
      //           DropdownMenuItem(
      //             value: decoded["eveCodigo"],
      //             child: Text(decoded["eveNome"]),
      //           ),
      //         );
      //       });
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text("Erro ao buscar eventos!"),
      //           backgroundColor: Cores.vermelhoMedio,
      //         ),
      //       );
      //     }
      //   }
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
              child: Text(item["comNome"] +
                  " - " +
                  item['comCidade'] +
                  " - " +
                  item['comUf']),
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

  buscarPessoasAlocadas() async {
    setState(() => carregando = true);
    var retorno =
        await ApiEvento().getPessoasQuarto(quarto.quaCodigo, eventoSelecionado);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      // pessoasQuarto.clear();
      ocupadas = 0;
      for (var item in decoded) {
        setState(() {
          pessoasQuarto.add(PessoaModel.fromJson(item));
          ocupadas++;
        });
      }
      for (var pessoa in pessoasQuarto) {
        vagasQuarto.add(
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Cores.verdeMedio.withOpacity(0.2),
                    border: Border.all(
                      // color: Cores.verdeMedio.withOpacity(0.2),
                      color: Cores.preto,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.person),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            pessoa.pesNome,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  removerPessoaQuarto(pessoa.pesCodigo);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Cores.vermelhoMedio,
                      borderRadius: BorderRadius.circular(10),
                      // color: Cores.verdeMedio.withOpacity(0.2),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        CupertinoIcons.trash,
                        color: Cores.branco,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    setState(() => carregando = false);
  }

  pessoasBusca(String busca) async {
    setState(() => carregando = true);
    if (busca.isNotEmpty) {
      var listaPessoas = pessoas.where((element) {
        return element.pesNome
            .toString()
            .toUpperCase()
            .contains(busca.toString().toUpperCase());
      }).toList();
      if (listaPessoas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nenhuma pessoa encontrada!"),
            backgroundColor: Cores.vermelhoMedio,
          ),
        );
        buscarPessoasComunidade(comunidadeSelecionada);
      }
      pessoas.clear();
      setState(() {
        pessoas = listaPessoas;
      });
    } else {
      buscarPessoasComunidade(comunidadeSelecionada);
    }
    setState(() => carregando = false);
  }

  alimentarPessoasSelecionadas() async {
    setState(() => carregando = true);
    if (pessoasSelecionadas != []) {
      for (var pessoa in pessoasSelecionadas) {
        setState(() {
          ocupadas++;
        });
        vagasQuarto.add(
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Cores.verdeMedio.withOpacity(0.2),
                    border: Border.all(
                      // color: Cores.verdeMedio.withOpacity(0.2),
                      color: Cores.preto,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.person),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            pessoa.pesNome,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  () {};
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Cores.vermelhoMedio,
                      borderRadius: BorderRadius.circular(10),
                      // color: Cores.verdeMedio.withOpacity(0.2),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        CupertinoIcons.trash,
                        color: Cores.branco,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    setState(() => carregando = false);
  }

  alimentarCamasVazias() async {
    setState(() => carregando = true);
    int camasVazias = quarto.quaQtdCamas - vagasQuarto.length;
    for (var i = 0; i < camasVazias; i++) {
      vagasQuarto.add(
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Cores.verdeMedio.withOpacity(0.2),
            border: Border.all(
              // color: Cores.verdeMedio.withOpacity(0.2),
              color: Cores.preto,
              width: 2,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(CupertinoIcons.bed_double),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Vazio",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    setState(() => carregando = false);
  }

  criarVagas() async {
    vagasQuarto.clear();
    pessoasQuarto.clear();
    await buscarPessoasAlocadas();
    await alimentarPessoasSelecionadas();
    await alimentarCamasVazias();
  }

  adicionarPessoaQuarto(int codigoPessoa) async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao().addPessoaQuarto(
      AlocacaoModel(
        pesCodigo: codigoPessoa,
        quaCodigo: quarto.quaCodigo,
        qupCodigo: 0,
        pesChave: false,
        pesCheckin: false,
        pesNaovem: false,
      ),
    );

    if (retorno.statusCode == 200) {
      criarVagas();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pessoa adicionada com sucesso!"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
      setState(() {
        pessoasSelecionadas.clear();
      });
      buscarPessoasComunidade(comunidadeSelecionada);
      // alocacaoController.animateToPage(
      //   0,
      //   duration: const Duration(
      //     milliseconds: 500,
      //   ),
      //   curve: Curves.ease,
      // );
      setState(() => carregando = false);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao adicionar pessoa!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
      setState(() => carregando = false);
      return false;
    }
  }

  removerPessoaQuarto(int codigoPessoa) async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao().deletePessoaQuarto(codigoPessoa);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pessoa removida com sucesso!"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
      setState(() {
        pessoasSelecionadas.clear();
      });
      criarVagas();
      buscarPessoasComunidade(comunidadeSelecionada);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao remover pessoa!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  removerPessoaEvento(int codigoPessoa) async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().removerPessoas(
      [codigoPessoa],
      eventoSelecionado,
    );
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pessoa removida com sucesso!"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
      setState(() {
        pessoasSelecionadas.clear();
      });
      criarVagas();
      buscarPessoasComunidade(comunidadeSelecionada);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao remover pessoa!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  criarVagasQuartos(QuartoModel quartoModel) {
    // if (widget.quarto.pessoas != null) {
    // widget.quarto.pessoas!.sort((a, b) => a.pesNome.compareTo(b.pesNome));
    int quantidadeCamasOcupadas = 0;
    List<Widget> alocacaoQuarto = [];
    alimentarCamasVaziasQuarto(
        quartoModel,
        alimentarCamasOcupadas(
            quartoModel, quantidadeCamasOcupadas, alocacaoQuarto),
        alocacaoQuarto);
    return alocacaoQuarto;
  }

  alimentarCamasOcupadas(QuartoModel quartoAlocado, int quantidadeCamasOcupadas,
      List<Widget> alocacaoQuarto) {
    for (var i = 0; i < quartoAlocado.pessoas.length; i++) {
      setState(() {
        alocacaoQuarto.add(
          Row(
            children: [
              Icon(
                quartoAlocado.pessoas[i].pesGenero == "F"
                    ? Icons.female_rounded
                    : Icons.male_rounded,
                color: quartoAlocado.pessoas[i].pesGenero == "F"
                    ? Cores.rosaEscuro
                    : Cores.azulMedio,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  // quarto.quaNome,
                  quartoAlocado.pessoas[i].pesNome,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      });
      quantidadeCamasOcupadas++;
    }
    return quantidadeCamasOcupadas;
  }

  alimentarCamasVaziasQuarto(QuartoModel quartoAlocado,
      int quantidadeCamasOcupadas, List<Widget> alocacaoQuarto) {
    setState(() {
      // quarto.quaQtdCamaslivres = quarto.quaQtdCamas - pessoas.length;
      quarto.quaQtdCamaslivres =
          quartoAlocado.quaQtdCamas - quantidadeCamasOcupadas;
    });
    for (var i = 0;
        i < quartoAlocado.quaQtdCamas - quantidadeCamasOcupadas;
        i++) {
      setState(() {
        alocacaoQuarto.add(
          const Row(
            children: [
              Icon(CupertinoIcons.person),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Vazio",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  initState() {
    super.initState();
    buscarEventos();
    criarVagas();
  }

  @override
  Widget build(BuildContext context) {
    return EstruturaAlocacaoEvento(
      formKey: formKey,
      buscar: (value) {
        setState(() {
          pessoasSelecionadas.clear();
          // vagasQuarto.clear();
          pessoasQuarto.clear();
          pessoasBusca(value);
        });
      },
      comboEvento: Flexible(
        fit: FlexFit.tight,
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
      comboPessoas: Flexible(
        fit: FlexFit.tight,
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
              itemCount: comunidades.isNotEmpty ? pessoas.length : 0,
              itemBuilder: (context, index) {
                return CardPessoasAlocacao(
                  pessoa: pessoas[index],
                  ocupadas: ocupadas,
                  vagas: quarto.quaQtdCamas,
                  selecionado: pessoasSelecionadas.contains(pessoas[index]),
                  addPessoa: () async {
                    if (ocupadas >= quarto.quaQtdCamas) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Quarto cheio!"),
                          backgroundColor: Cores.vermelhoMedio,
                        ),
                      );
                      return;
                    }
                    if (quarto.quaCodigo != 0) {
                      await adicionarPessoaQuarto(pessoas[index].pesCodigo);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Selecione um quarto!"),
                          backgroundColor: Cores.vermelhoMedio,
                        ),
                      );
                    }
                    // var retorno =
                    // if (retorno) {
                    //   setState(() {
                    //     pessoasSelecionadas.add(pessoas[index]);
                    //   });
                    // }
                  },
                  excluir: () {
                    removerPessoaEvento(pessoas[index].pesCodigo);
                  },
                  removePessoa: () {
                    setState(() {
                      pessoasSelecionadas.remove(pessoas[index]);
                      ocupadas--;
                    });
                    criarVagas();
                  },
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
          // selecionado: 0,
          selecionado: comunidadeSelecionada,
          onChange: (value) {
            setState(() {
              comunidadeSelecionada = value;
            });
            buscarPessoasComunidade(value);
            pessoasSelecionadas.clear();
            criarVagas();
          },
        ),
      ),
      comboBloco: Visibility(
        visible: exibirBlocos,
        child: Flexible(
          fit: FlexFit.tight,
          child: SizedBox(
            height: 60,
            child: DropDownForm(
              label: 'Bloco',
              itens: blocos,
              selecionado: 0,
              onChange: (value) async {
                setState(() {
                  blocoSelecionado = value;
                });
                if (quarto.quaCodigo != 0) {
                  alocacaoController.animateToPage(
                    0,
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.ease,
                  );
                }
                await buscarQuartos();
                await criarVagas();
              },
            ),
          ),
        ),
      ),
      pageView: Flexible(
        fit: FlexFit.tight,
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
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
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
                                    buscarComunidades();
                                    criarVagas();
                                  },
                                  child: CardEventoQuarto(
                                    quarto: item,
                                    // atualizar: () {
                                    //   criarVagasQuartos(item);
                                    // },
                                    alocacaoQuarto: criarVagasQuartos(item),
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
                // removePessoa: (int pessoa) {
                //   setState(() {
                //     pessoasSelecionadas.remove(pessoa);
                //   });
                //   removerPessoaQuarto(pessoa);
                // },
                vagasQuarto: vagasQuarto,
                // pessoas: pessoasSelecionadas.map((e) => e.pesNome).toList(),
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
              // comunidadeSelecionada = 0;
              // pessoas.clear();
              exibirVoltar = false;
              // comunidades.clear();
              vagasQuarto.clear();
              pessoasQuarto.clear();
              quarto.quaCodigo = 0;
              // comunidadeSelecionada = 0;
            });
            buscarQuartos();
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
              // comunidadeSelecionada = 0;
              // pessoas.clear();
              exibirVoltar = false;
              // comunidades.clear();
              vagasQuarto.clear();
              pessoasQuarto.clear();
              quarto.quaCodigo = 0;

              // comunidadeSelecionada = 0;
            });
            buscarQuartos();
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
            // comunidadeSelecionada = 0;
            // pessoas.clear();
            Navigator.pop(context);
            // comunidades.clear();
            vagasQuarto.clear();
            pessoasQuarto.clear();
            quarto.quaCodigo = 0;

            buscarQuartos();
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

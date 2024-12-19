import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/estrutura/estrutura.dart';
import 'package:painel_ccmn/funcoes/funcoes.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/cards/alocacao/card_evento_checkin.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../classes/classes.dart';

class Alocacao extends StatefulWidget {
  const Alocacao({super.key});

  @override
  State<Alocacao> createState() => _AlocacaoState();
}

class _AlocacaoState extends State<Alocacao> {
  bool carregando = false;
  bool exibirCabecalho = true;

  List<DropdownMenuItem> statuEvento = [
    const DropdownMenuItem(
      value: 1,
      child: Text("Vigentes"),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text("Realizados"),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text("Todos"),
    ),
  ];
  List<CheckinListagemQuartosModel> quartos = [];
  List<BlocoModel> blocos = [];
  List<EventoCheckinModel> eventos = [];
  List<QuartoPessoasModel> quartosBusca = [];

  int eventoSelecionado = 1;
  int codigoBloco = 0;
  int codigoEvento = 0;

  TextEditingController buscaController = TextEditingController();

  final pdf = pw.Document();

  buscarQuartoBusca(String busca) async {
    Rotas.alocacaoPageController.keepPage;
    setState(() => carregando = true);
    var retorno =
        await ApiCheckin().getCheckinQuartosBusca(codigoEvento, busca);
    if (retorno.statusCode == 200) {
      quartosBusca.clear();
      var dados = json.decode(retorno.body);
      for (var dado in dados) {
        quartosBusca.add(QuartoPessoasModel.fromJson(dado));
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

  buscarEventos() async {
    setState(() => carregando = true);
    var retorno = await ApiAlocacao().getEventosCheckin(eventoSelecionado);
    if (retorno.statusCode == 200) {
      eventos.clear();
      if (retorno.body == "[]") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nenhum evento encontrado!"),
            backgroundColor: Cores.amareloEscuro,
          ),
        );
        setState(() => carregando = false);
        return;
      }
      var decoded = json.decode(retorno.body);
      setState(() {
        for (var item in decoded) {
          eventos.add(EventoCheckinModel.fromJson(item));
        }
      });
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

  buscarQuartos({int? codigo}) async {
    setState(() => carregando = true);
    quartosBusca.clear();
    var retorno = await ApiCheckin().getCheckinQuartos(codigo ?? codigoEvento);
    print(retorno.body);
    if (retorno.statusCode == 200) {
      quartos.clear();
      var dados = json.decode(retorno.body);
      for (var dado in dados) {
        // setState(() {
        quartos.add(CheckinListagemQuartosModel.fromJson(dado));
        // });
      }
      // print(quartos[0].pessoasQuarto[0].pessoasQuarto[0].pesNome);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer quartos !"),
        ),
      );
    }
    setState(() => carregando = false);
    // Rotas.alocacaoPageController.animateToPage(1,
    //     duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  gerarPDFQuartos(int codigoEvento) async {
    await buscarQuartos(codigo: codigoEvento);
    pdf.addPage(
      pw.MultiPage(
        orientation: pw.PageOrientation.landscape,
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(10),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text("Alocação de Quartos"),
          ),
          pw.Table.fromTextArray(
            context: context,
            data: [
              for (var i = 0; i < quartos.length; i++)
                [
                  quartos[i].bloNome,
                  // for (var j = 0; j < quartos[i].pessoasQuarto.length; j++) ...[
                  //   quartos[i].pessoasQuarto[j].pessoasQuarto[j].pesNome,
                  // quartos[i].pessoasQuarto[j].pessoasQuarto[j].pesCheckin
                  //     ? "Sim"
                  //     : "Não",
                  // ],
                ],
            ],
            // data: [
            //   <String>[
            //     "Bloco",
            //     "Quarto",
            //     "Pessoas",
            //     "Checkin",
            //   ],
            //   for (var quarto in quartos)
            //     [
            //       quarto.bloNome,
            //       // quarto.pessoasQuarto[quarto.pessoasQuarto.length - 1].quaNome,
            //       quarto.pessoasQuarto.length.toString(),
            //       // quarto
            //       //         .pessoasQuarto[quarto.pessoasQuarto.length - 1]
            //       //         .pessoasQuarto[quarto.pessoasQuarto.length - 1]
            //       //         .pesCheckin
            //       //     ? "Sim"
            //       //     : "Não",
            //     ],
            // ],
          ),
        ],
      ),
    );
    FuncoesPDF.gerarPDF(pdf, "Quartos");
  }

  @override
  initState() {
    super.initState();
    buscarEventos();
    Rotas.alocacaoPageController.addListener(() {
      if (Rotas.alocacaoPageController.page == 0) {
        setState(() {
          exibirCabecalho = true;
        });
      } else {
        setState(() {
          exibirCabecalho = false;
        });
      }
    });
    // buscarEventosAtivos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
            color: Cores.branco,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Cores.branco,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Buscar: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: CupertinoTextField(
                              controller: buscaController,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              placeholder: 'Pesquisar',
                              onSubmitted: (value) async {
                                if (buscaController.text.isEmpty) {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //     content: Text("Digite algo para buscar!"),
                                  //     backgroundColor: Cores.vermelhoMedio,
                                  //   ),
                                  // );
                                  await buscarQuartos();
                                } else {
                                  await buscarQuartoBusca(buscaController.text);
                                }
                                // await buscarQuartoBusca(value);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CupertinoButton(
                          color: Cores.preto,
                          onPressed: () async {
                            if (buscaController.text.isEmpty) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text("Digite algo para buscar!"),
                              //     backgroundColor: Cores.vermelhoMedio,
                              //   ),
                              // );
                              await buscarQuartos();
                            }
                            await buscarQuartoBusca(buscaController.text);

                            // await buscarQuartoBusca(buscaController.text);
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          child: const Icon(CupertinoIcons.search),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Check-In",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // const Expanded(child: SizedBox()),
                        SizedBox(
                          width: 500,
                          height: 60,
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Eventos',
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
                            items: statuEvento,
                            value: eventoSelecionado != 0
                                ? eventoSelecionado
                                : null,
                            onChanged: (value) async {
                              setState(() {
                                eventoSelecionado = value;
                              });
                              await buscarEventos();
                              // buscarBlocos();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Cores.preto,
                    ),
                  ),
                  exibirCabecalho
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              SizedBox(width: 35),
                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Eventos",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Data Início",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Data Fim",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50),
                              Text(
                                "Visualizar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Checkin",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: carregando
                        ? const Center(child: CarregamentoIOS())
                        :
                        //  quartos.isEmptys
                        //     ?
                        quartosBusca.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: PageView(
                                  controller: Rotas.alocacaoPageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    ListView.builder(
                                      itemCount: eventos.length,
                                      itemBuilder: (context, index) {
                                        return CardEventoCheckin(
                                          eventoDados: eventos[index],
                                          quartos: () async {
                                            gerarPDFQuartos(
                                                eventos[index].eveCodigo);
                                          },
                                          checkin: () {
                                            setState(() {
                                              codigoEvento =
                                                  eventos[index].eveCodigo;
                                            });
                                            Rotas.alocacaoPageController
                                                .animateToPage(
                                              1,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      child: CheckinQuartos(
                                        codigoEvento: codigoEvento,
                                        quartosBusca: quartosBusca,
                                        voltar: () {
                                          Rotas.alocacaoPageController
                                              .animateToPage(
                                            0,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: ListView.builder(
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    quartosBusca[index].bloNome,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Wrap(
                                              direction: Axis.horizontal,
                                              children: [
                                                for (var quarto in quartosBusca)
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        CupertinoDialogRoute(
                                                          builder: (context) {
                                                            return EditarCheckin(
                                                              dadosQuarto:
                                                                  quarto,
                                                              refresh: () {},
                                                            );
                                                          },
                                                          context: context,
                                                        ),
                                                      );
                                                      buscarQuartos();
                                                    },
                                                    child: MouseRegion(
                                                      cursor: SystemMouseCursors
                                                          .click,
                                                      child: CardQuartoAlocacao(
                                                        quarto: quarto,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 20,
                                              ),
                                              child: Divider(
                                                  color: Cores.cinzaMedio),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
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

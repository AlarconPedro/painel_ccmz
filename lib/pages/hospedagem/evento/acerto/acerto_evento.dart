import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/hospedagem/evento/acerto/acerto_evento_data.dart';
import 'package:painel_ccmn/widgets/botoes/btn_mini.dart';
import 'package:painel_ccmn/widgets/botoes/btn_secundario.dart';
import 'package:painel_ccmn/widgets/cards/mostragem/card_despesas_pessoas.dart';
import 'package:painel_ccmn/widgets/separador.dart';
import 'package:painel_ccmn/widgets/snack_notification.dart';

import '../../../../classes/classes.dart';
import '../../../../widgets/botoes/btn_primario.dart';
import '../../../../widgets/botoes/btn_terciario.dart';
import '../../../../widgets/form/campo_texto.dart';
import '../../../../widgets/textos/textos.dart';
import '../../../../widgets/widgets.dart';

class AcertoEvento extends StatefulWidget {
  int codigoEvento;
  String nomeEvento;
  Function mudarPagina;
  AcertoEvento({
    super.key,
    required this.codigoEvento,
    required this.nomeEvento,
    required this.mudarPagina,
  });

  @override
  State<AcertoEvento> createState() => _AcertoEventoState();
}

class _AcertoEventoState extends State<AcertoEvento> {
  double alturaFormulario = 530;
  double larguraFormulario = 950;

  bool carregando = false;
  bool dividirComunidade = false;

  List<EventoDespesasModel> despesasExtra = [];
  List<Map<String, double>> despesasExtraComunidade = [];

  TextEditingController valorCozinhaController = TextEditingController();
  TextEditingController valorHostiariaController = TextEditingController();
  TextEditingController valorhHospedagemController = TextEditingController();

  TextEditingController nomeDespesaController = TextEditingController();
  TextEditingController valorDespesaController = TextEditingController();
  TextEditingController qtdDespesaController = TextEditingController();

  List<AcertoModel> comunidadesEvento = [];

  MaskTextInputFormatter valorFormatter = MaskTextInputFormatter(
    mask: '###.###.###.###.###,00',
    filter: {"#": RegExp(r'[0-9]')},
  );
  double valorTotal = 0;
  double valorEvento = 0;
  double valorExtraEvento = 0;
  double valorComunidade = 0;
  double valorPorPessoa = 0;
  double valorHospedagem = 0;
  double valorCozinha = 0;
  double valorHostiaria = 0;

  String tipoCobrancaEvento = "";

  int pagantesEvento = 0;
  int cobrantesEvento = 0;
  int pagantesComunidade = 0;
  int cobrantesComunidade = 0;

  int codigoComunidade = 0;

  alterarAlturaFormulario() {
    setState(() {
      if (alturaFormulario == 800 && dividirComunidade) {
        alturaFormulario = 530;
      } else {
        alturaFormulario = 800;
      }
    });
  }

  calcularValorTotalComunidade() {
    // double valorTotal = 0;
    // valorTotal += (valorPorPessoa * cobrantesComunidade);
    double valorExtra = 0;
    for (var item in despesasExtra) {
      valorExtra += item.dseValor;
    }
    return valorExtra;
  }

  calcularValores() {
    valorHospedagem = valorEvento * cobrantesEvento;
    valorhHospedagemController.text = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    ).format(valorHospedagem);
    valorTotal = valorCozinha + valorHostiaria + valorHospedagem;
    valorPorPessoa = valorTotal / pagantesEvento;
    valorComunidade = valorPorPessoa * cobrantesComunidade;
    valorExtraEvento = calcularValorTotalComunidade();
  }

  AcertoEventoData acertoEventoData = AcertoEventoData();

  buscarDadosEvento() async {
    setState(() => carregando = true);
    //// Buscar Comuniades do Evento
    await acertoEventoData.buscarComunidadesEvento(
        codigoEvento: widget.codigoEvento,
        dadosRetorno: (dados) {
          comunidadesEvento.clear();
          for (var item in dados) {
            comunidadesEvento.add(AcertoModel.fromJson(item));
          }
        },
        erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro ao buscar comunidades do evento"))));
    //// Buscar Despesas do Evento
    await acertoEventoData.buscarCustoEvento(
        codigoEvento: widget.codigoEvento,
        dadosRetorno: (dados) {
          valorEvento = dados["eveValor"];
          tipoCobrancaEvento = dados["eveTipoCobranca"];
        },
        erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro ao buscar despesas do evento"))));
    //// Buscar Despesas Cozinha do Evento
    await acertoEventoData.buscarCustoCozinha(
        codigoEvento: widget.codigoEvento,
        dadosRetorno: (dados) {
          valorCozinha = double.parse(dados);
          valorCozinhaController.text = NumberFormat.currency(
            locale: 'pt_BR',
            symbol: 'R\$',
            decimalDigits: 2,
          ).format(valorCozinha);
        },
        erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro ao buscar despesas da cozinha do evento"))));
    //// Buscar Despesas Hostiária do Evento
    await acertoEventoData.buscarCustoHostiaria(
        codigoEvento: widget.codigoEvento,
        dadosRetorno: (dados) {
          valorHostiaria = double.parse(dados);
          valorHostiariaController.text = NumberFormat.currency(
            locale: 'pt_BR',
            symbol: 'R\$',
            decimalDigits: 2,
          ).format(valorHostiaria);
        },
        erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro ao buscar despesas da hostiária do evento"))));
    //// Buscar Pagantes e Cobrantes do Evento
    await acertoEventoData.buscarPessoasPagantesCobrantesEvento(
        codigoEvento: widget.codigoEvento,
        dadosRetorno: (dados) {
          pagantesEvento = dados["pagantes"];
          cobrantesEvento = dados["cobrantes"];
        },
        erro: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Erro ao buscar pagantes e cobrantes do evento"))));
    //// Buscar Despesas extra do Evento
    await acertoEventoData.busarDespesasExtraEvento(widget.codigoEvento,
        (dados) {
      for (var item in dados) {
        despesasExtra.add(EventoDespesasModel.fromJson(item));
      }
    }, () {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Erro ao buscar despesas extras do evento")));
    });
    //// Caclular total do evento
    calcularValores();
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarDadosEvento();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Card(
          color: Cores.cinzaClaro,
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: alturaFormulario,
            width: larguraFormulario,
            child: Column(
              children: [
                SizedBox(
                  height: 320,
                  child: Center(
                    child: carregando
                        ? const CarregamentoIOS()
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              color: Cores.branco,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                        color: Cores.azulMedio),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(children: [
                                        Textos.textoMedioNormal(
                                            texto:
                                                "Evento: ${widget.nomeEvento}",
                                            cor: Cores.branco),
                                        const Spacer(),
                                        Textos.textoMedioNormal(
                                            texto: "Cobrante: $cobrantesEvento",
                                            cor: Cores.branco),
                                        const SizedBox(width: 10),
                                        Textos.textoMedioNormal(
                                            texto: "Pagante: $pagantesEvento",
                                            cor: Cores.branco),
                                        const SizedBox(width: 10)
                                      ]),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: campoTexto(
                                              titulo: "Valor Hospedagem:",
                                              dica: "R\$ 0,00",
                                              icone: CupertinoIcons.house,
                                              temMascara: false,
                                              tipo: TextInputType.number,
                                              mascara:
                                                  CurrencyTextInputFormatter
                                                      .currency(
                                                locale: "pt_BR",
                                                symbol: "R\$",
                                                decimalDigits: 2,
                                                name: "Real",
                                              ),
                                              validador: (validador) {
                                                if (validador.isEmpty) {
                                                  return 'Por favor, digite o valor da hospedagem';
                                                }
                                                return null;
                                              },
                                              controlador:
                                                  valorhHospedagemController)),
                                      btnMini(
                                          onPressed: () {
                                            acertoEventoData
                                                .inserirAtualizarValorHospedagem(
                                                    codigoEvento:
                                                        widget.codigoEvento,
                                                    qtdPessoasCobrantes:
                                                        cobrantesEvento,
                                                    valorHospedagem:
                                                        valorhHospedagemController
                                                            .text,
                                                    dadosRetorno: (dados) {
                                                      snackNotification(
                                                          context: context,
                                                          mensage:
                                                              "Valor da hospedagem do evento atualizado",
                                                          cor:
                                                              Cores.verdeMedio);
                                                      buscarDadosEvento();
                                                    },
                                                    erro: () => snackNotification(
                                                        context: context,
                                                        mensage:
                                                            "Erro ao inserir valor da hospedagem"));
                                          },
                                          child: const Icon(Icons.save,
                                              color: Cores.branco)),
                                      separador(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          children: [
                                            Textos.textoPequeno(
                                                texto: "Divisão :",
                                                cor: Cores.preto),
                                            const SizedBox(width: 10),
                                            Textos.textoPequeno(
                                                texto: "Pessoa",
                                                cor: Cores.preto),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: CupertinoSwitch(
                                                  value: dividirComunidade,
                                                  onChanged: (value) {
                                                    alterarAlturaFormulario();
                                                    setState(() =>
                                                        dividirComunidade =
                                                            value);
                                                  }),
                                            ),
                                            Textos.textoPequeno(
                                                texto: "Comunidade",
                                                cor: Cores.preto),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: SizedBox(
                                          width: 350,
                                          child: btnTerciario(
                                            texto: "Serviços",
                                            onPressed: () =>
                                                widget.mudarPagina(),
                                            icon: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Icon(
                                                    CupertinoIcons.wrench,
                                                    size: 30,
                                                    color: Cores.branco)),
                                          ),
                                        ),
                                      ),
                                      separador(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: SizedBox(
                                          width: 350,
                                          child: btnTerciario(
                                            texto: "Outras Despesas",
                                            onPressed: () =>
                                                widget.mudarPagina(),
                                            icon: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Icon(
                                                    CupertinoIcons.cube_box,
                                                    size: 30,
                                                    color: Cores.branco)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: campoTexto(
                                  //           titulo: "Valor Cozinha:",
                                  //           dica: "R\$ 0,00",
                                  //           icone: CupertinoIcons
                                  //               .shopping_cart,
                                  //           tipo: TextInputType.number,
                                  //           temMascara: false,
                                  //           mascara:
                                  //               CurrencyTextInputFormatter
                                  //                   .currency(
                                  //             locale: "pt_BR",
                                  //             symbol: "R\$",
                                  //             decimalDigits: 2,
                                  //             name: "Real",
                                  //           ),
                                  //           validador: (validador) {
                                  //             if (validador.isEmpty) {
                                  //               return 'Por favor, digite o valor da cozinha';
                                  //             }
                                  //             return null;
                                  //           },
                                  //           controlador:
                                  //               valorCozinhaController),
                                  //     ),
                                  //     btnMini(
                                  //         onPressed: () async {
                                  //           await acertoEventoData
                                  //               .inserirAtualizarValorCozinha(
                                  //                   codigoEvento: widget
                                  //                       .codigoEvento,
                                  //                   valorCozinha:
                                  //                       valorCozinhaController
                                  //                           .text,
                                  //                   dadosRetorno:
                                  //                       (dados) {
                                  //                     // valorCozinhaController
                                  //                     //         .text =
                                  //                     //     NumberFormat
                                  //                     //         .currency(
                                  //                     //   locale:
                                  //                     //       'pt_BR',
                                  //                     //   symbol: 'R\$',
                                  //                     //   decimalDigits:
                                  //                     //       2,
                                  //                     // ).format(double
                                  //                     //         .parse(dados
                                  //                     //             .body));
                                  //                     ScaffoldMessenger
                                  //                             .of(
                                  //                                 context)
                                  //                         .showSnackBar(
                                  //                             const SnackBar(
                                  //                                 content:
                                  //                                     Text("Valor da cozinha do evento atualizado")));
                                  //                     buscarDadosEvento();
                                  //                   },
                                  //                   erro: () {
                                  //                     ScaffoldMessenger
                                  //                             .of(
                                  //                                 context)
                                  //                         .showSnackBar(
                                  //                             const SnackBar(
                                  //                                 content:
                                  //                                     Text("Erro ao inserir valor da cozinha do evento")));
                                  //                   });
                                  //         },
                                  //         child: const Icon(Icons.save,
                                  //             color: Cores.branco))
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: campoTexto(
                                  //           titulo: "Valor Hostiária:",
                                  //           dica: "R\$ 0,00",
                                  //           icone: CupertinoIcons
                                  //               .person_3_fill,
                                  //           tipo: TextInputType.number,
                                  //           temMascara: false,
                                  //           mascara:
                                  //               CurrencyTextInputFormatter
                                  //                   .currency(
                                  //             locale: "pt_BR",
                                  //             symbol: "R\$",
                                  //             decimalDigits: 2,
                                  //             name: "Real",
                                  //           ),
                                  //           validador: (validador) {
                                  //             if (validador.isEmpty) {
                                  //               return 'Por favor, digite o valor da hostiária';
                                  //             }
                                  //             return null;
                                  //           },
                                  //           controlador:
                                  //               valorHostiariaController),
                                  //     ),
                                  //     btnMini(
                                  //         onPressed: () {
                                  //           acertoEventoData
                                  //               .inserirAtualizarValorHostiaria(
                                  //                   codigoEvento: widget
                                  //                       .codigoEvento,
                                  //                   valorHostiaria:
                                  //                       valorHostiariaController
                                  //                           .text,
                                  //                   dadosRetorno:
                                  //                       (dados) {
                                  //                     // valorHostiariaController
                                  //                     //         .text =
                                  //                     //     NumberFormat
                                  //                     //         .currency(
                                  //                     //   locale:
                                  //                     //       'pt_BR',
                                  //                     //   symbol: 'R\$',
                                  //                     //   decimalDigits:
                                  //                     //       2,
                                  //                     // ).format(double
                                  //                     //         .parse(dados
                                  //                     //             .body));
                                  //                     ScaffoldMessenger
                                  //                             .of(
                                  //                                 context)
                                  //                         .showSnackBar(
                                  //                             const SnackBar(
                                  //                                 content:
                                  //                                     Text("Valor da hostiária do evento atualizado")));
                                  //                     buscarDadosEvento();
                                  //                   },
                                  //                   erro: () {
                                  //                     ScaffoldMessenger
                                  //                             .of(
                                  //                                 context)
                                  //                         .showSnackBar(
                                  //                             const SnackBar(
                                  //                                 content:
                                  //                                     Text("Erro ao inserir valor da hostiária do evento")));
                                  //                   });
                                  //         },
                                  //         child: const Icon(Icons.save,
                                  //             color: Cores.branco))
                                  // ],
                                  // ),
                                  //   ],
                                  // ),
                                  // ),
                                  // const Spacer(),

                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Textos.textoPequeno(
                                            texto: "Total Serviços:",
                                            cor: Cores.preto),
                                        Textos.textoPequeno(
                                            texto: NumberFormat.currency(
                                                    locale: 'pt_BR',
                                                    symbol: 'R\$',
                                                    decimalDigits: 2)
                                                .format(valorTotal),
                                            cor: Cores.preto),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Textos.textoPequeno(
                                            texto: "Total Outras Despesas:",
                                            cor: Cores.preto),
                                        Textos.textoPequeno(
                                            texto: NumberFormat.currency(
                                                    locale: 'pt_BR',
                                                    symbol: 'R\$',
                                                    decimalDigits: 2)
                                                .format(valorTotal),
                                            cor: Cores.preto),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Textos.textoMedio(
                                            texto: "Total Evento:",
                                            cor: Cores.preto),
                                        Textos.textoMedio(
                                            texto: NumberFormat.currency(
                                                    locale: 'pt_BR',
                                                    symbol: 'R\$',
                                                    decimalDigits: 2)
                                                .format(valorTotal),
                                            cor: Cores.preto),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: dividirComunidade
                      ? ListView.builder(
                          itemCount: comunidadesEvento.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: CardDespesasComunidade(
                                    valorPorPessoa: valorPorPessoa,
                                    pagante: pagantesComunidade,
                                    cobrante: cobrantesComunidade,
                                    nomeComunidade:
                                        comunidadesEvento[index].comNome));
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: CardDespesasPessoas(
                              valorPorPessoa: valorPorPessoa,
                              qtdCobrantes: cobrantesEvento,
                              qtdComunidades: comunidadesEvento.length,
                              qtdPagantes: pagantesEvento,
                              valorEvento: valorTotal)),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Cores.branco,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        btnSecundario(
                            texto: "Fechar",
                            onPressed: () => Navigator.pop(context)),
                        btnPrimario(
                            texto: "Gerar",
                            onPressed: () {},
                            icon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(CupertinoIcons.printer,
                                    color: Cores.branco))),
                      ],
                    ),
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

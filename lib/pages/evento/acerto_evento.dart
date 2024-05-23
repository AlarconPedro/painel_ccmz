import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/data/models/acerto_comunidade_model.dart';
import 'package:painel_ccmn/data/models/evento_despesas_model.dart';
import 'package:painel_ccmn/widgets/widgets.dart';
import 'package:pdf/pdf.dart';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;

import '../../classes/classes.dart';
import '../../data/api/api_acerto.dart';

class AcertoEvento extends StatefulWidget {
  int codigoEvento;
  String nomeEvento;
  AcertoEvento({
    super.key,
    required this.codigoEvento,
    required this.nomeEvento,
  });

  @override
  State<AcertoEvento> createState() => _AcertoEventoState();
}

class _AcertoEventoState extends State<AcertoEvento> {
  List<EventoDespesasModel> despesasExtra = [];
  List<Map<String, double>> despesasExtraComunidade = [];

  TextEditingController valorCozinhaController = TextEditingController();
  TextEditingController valorHostiariaController = TextEditingController();

  TextEditingController nomeDespesaController = TextEditingController();
  TextEditingController valorDespesaController = TextEditingController();
  TextEditingController qtdDespesaController = TextEditingController();

  List<AcertoModel> comunidadesEvento = [];

  MaskTextInputFormatter valorFormatter = MaskTextInputFormatter(
    mask: '###.###.###.###.###,00',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool carregando = false;

  double valorEvento = 0;
  double valorExtraEvento = 0;
  double valorComunidade = 0;
  double valorPorPessoa = 0;
  double valorCozinha = 0;
  double valorHostiaria = 0;

  String tipoCobrancaEvento = "";

  int pagantesEvento = 0;
  int cobrantesEvento = 0;
  int pagantesComunidade = 0;
  int cobrantesComunidade = 0;

  int codigoComunidade = 0;

  final pdf = pw.Document();

  buscaDadosPrimarios() async {
    await buscarCustoEvento();
    await buscarCustoCozinha();
    await buscarCustoHostiaria();
    await buscarPessoasPagantesCobrantesEvento();
    await buscarComunidadesEvento();
  }

  buscarComunidadesEvento() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().getComunidadesEvento(widget.codigoEvento);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      setState(() {
        // codigoComunidade = decoded[0]["comCodigo"];
        for (var element in decoded) {
          comunidadesEvento.add(AcertoModel.fromJson(element));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar pessoas pagantes e cobrantes"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarCustoEvento() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().getEventoCusto(widget.codigoEvento);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      setState(() {
        valorEvento = decoded["eveValor"];
        tipoCobrancaEvento = decoded["eveTipoCobranca"];
      });
      await busarDespesasExtraEvento();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar custo do evento"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarCustoCozinha() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().getValorCozinha(widget.codigoEvento);
    if (retorno.statusCode == 200) {
      setState(() {
        valorCozinha = double.parse(retorno.body);
        valorCozinhaController.text = NumberFormat.currency(
          locale: 'pt_BR',
          symbol: 'R\$',
          decimalDigits: 2,
        ).format(valorCozinha);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar custo da cozinha"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarCustoHostiaria() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().getValorHostiaria(widget.codigoEvento);
    if (retorno.statusCode == 200) {
      setState(() {
        valorHostiaria = double.parse(retorno.body);
        valorHostiariaController.text = NumberFormat.currency(
          locale: 'pt_BR',
          symbol: 'R\$',
          decimalDigits: 2,
        ).format(valorHostiaria);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar custo da hostiaria"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarPessoasPagantesCobrantesEvento() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().getEventoPessoas(widget.codigoEvento);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      setState(() {
        pagantesEvento = decoded["pagantes"];
        cobrantesEvento = decoded["cobrantes"];
        valorEvento =
            ((cobrantesEvento * valorEvento) + valorCozinha + valorHostiaria);
        valorPorPessoa =
            double.parse((valorEvento / pagantesEvento).toStringAsFixed(2));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar pessoas pagantes e cobrantes"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  busarDespesasExtraEvento() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().getEventoDespesas(widget.codigoEvento);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      despesasExtra.clear();
      setState(() {
        for (var element in decoded) {
          despesasExtra.add(EventoDespesasModel.fromJson(element));
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar despesas extras do evento"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  busarDespesasExtraComunidade() async {}

  inserirAtualizarValorCozinha() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().postDespesaCozinha(
      widget.codigoEvento,
      double.parse(valorCozinhaController.text),
    );
    if (retorno.statusCode == 200) {
      calcularValorTotalEvento();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Valor da cozinha atualizado com sucesso"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao atualizar valor da cozinha"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    await buscarCustoCozinha();
    calcularValorTotalEvento();
    setState(() => carregando = false);
  }

  inserirAtualizarValorHostiaria() async {
    setState(() => carregando = true);
    var retorno = await ApiAcerto().postDespesaHostiaria(
      widget.codigoEvento,
      double.parse(valorHostiariaController.text),
    );
    if (retorno.statusCode == 200) {
      calcularValorTotalEvento();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Valor da hostiaria atualizado com sucesso"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao atualizar valor da hostiaria"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    await buscarCustoHostiaria();
    calcularValorTotalEvento();
    setState(() => carregando = false);
  }

  calcularValorTotalEvento() {
    double total = 0;
    setState(() {
      total = 0;
      total += valorEvento;
      total += valorCozinha;
      total += valorHostiaria;
      for (var element in despesasExtra) {
        total += (element.dseValor * element.dseQuantidade);
        valorExtraEvento += (element.dseValor * element.dseQuantidade);
      }
      for (var element in despesasExtraComunidade) {
        total += element.values.first;
      }
    });
    calcularValoresPorPessoa(total);
    return total;
  }

  calcularValoresPorPessoa(double valorEvento) {
    setState(() {
      valorPorPessoa = 0;
      valorPorPessoa =
          double.parse((valorEvento / pagantesEvento).toStringAsFixed(2));
    });
  }

  EventoDespesasModel prearaDadosDespesaEvento() {
    return EventoDespesasModel(
      dseCodigo: 0,
      eveCodigo: widget.codigoEvento,
      dseNome: nomeDespesaController.text,
      dseQuantidade: qtdDespesaController.text.isEmpty
          ? 1
          : int.parse(qtdDespesaController.text),
      dseValor: double.parse(valorDespesaController.text),
    );
  }

  inserirNovaDespesaEvento() async {
    setState(() => carregando = true);
    var retorno =
        await ApiAcerto().postDespesaEvento(prearaDadosDespesaEvento());
    if (retorno.statusCode == 200) {
      await busarDespesasExtraEvento();
      valorDespesaController.clear();
      nomeDespesaController.clear();
      qtdDespesaController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Despesa adicionada com sucesso"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao adicionar despesa"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  gerarPDF() async {
    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download",
          "Dados Acerto Evento - ${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();
  }

  criarPaginasPDF() {
    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(10),
        build: (context) => [
          pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColors.black,
                width: 1,
              ),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 20),
                child: pw.Row(
                  children: [
                    pw.Text(
                      "Acerto do Evento",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Spacer(),
                    pw.Text(
                      widget.nomeEvento,
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // pw.Header(
              //   level: 1,
              //   child: pw.Text("Evento: ${widget.nomeEvento}"),
              // ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Text("Valor Total Cozinha: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Divider(
                          color: PdfColors.black,
                          thickness: 1,
                        ),
                      ),
                    ),
                    pw.Text(
                        NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2)
                            .format(valorCozinha),
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              // pw.Header(
              //   level: 1,
              //   child: pw.Text(
              //       "Valor Total Cozinha: ${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2).format(valorCozinha)}"),
              // ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Text("Valor Total Hostiaria: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Divider(
                          color: PdfColors.black,
                          thickness: 1,
                        ),
                      ),
                    ),
                    pw.Text(
                        NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2)
                            .format(valorHostiaria),
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),

              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Text("Valor Total Hospedagem: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Divider(
                          color: PdfColors.black,
                          thickness: 1,
                        ),
                      ),
                    ),
                    pw.Text(
                        NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2)
                            .format(valorEvento),
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Text("Valor Total Despesas Adicionais Evento: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Divider(
                          color: PdfColors.black,
                          thickness: 1,
                        ),
                      ),
                    ),
                    pw.Text(
                        NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2)
                            .format(despesasExtra
                                .map((e) => e.dseValor * e.dseQuantidade)
                                .reduce((value, element) => value + element)),
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              // pw.Padding(
              //   padding: const pw.EdgeInsets.only(bottom: 10),
              //   child: pw.Row(
              //     children: [
              //       pw.Text("Valor Total Extra Comunidade: ",
              //           style: const pw.TextStyle(fontSize: 10)),
              //       pw.Expanded(
              //         child: pw.Padding(
              //           padding: const pw.EdgeInsets.symmetric(horizontal: 10),
              //           child: pw.Divider(
              //             color: PdfColors.black,
              //             thickness: 1,
              //           ),
              //         ),
              //       ),
              //       pw.Text(
              //           NumberFormat.currency(
              //                   locale: 'pt_BR',
              //                   symbol: 'R\$',
              //                   decimalDigits: 2)
              //               .format(despesasExtraComunidade
              //                   .map((e) => e.values.first)
              //                   .reduce((value, element) => value + element)),
              //           style: const pw.TextStyle(fontSize: 10)),
              //     ],
              //   ),
              // ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Text("Valor Total Evento: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                        child: pw.Divider(
                          color: PdfColors.black,
                          thickness: 1,
                        ),
                      ),
                    ),
                    pw.Text(
                        NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2)
                            .format(calcularValorTotalEvento()),
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              // pw.Header(
              //   level: 1,
              //   child: pw.Text("Despesas Adicionais"),
              // ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text("Despesas Adicionais"),
                  ],
                ),
              ),
              pw.Table.fromTextArray(
                context: context,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                },
                data: [
                  ["Nome", "Quantidade", "Valor Unitário", "Valor Total"],
                  ...despesasExtra.map((e) => [
                        e.dseNome,
                        e.dseQuantidade.toString(),
                        NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ).format(e.dseValor),
                        NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ).format(e.dseValor * e.dseQuantidade),
                      ]),
                ],
              ),
            ]),
          ),
          // pw.Header(
          //   level: 1,
          //   child: pw.Text("Despesas Por Comunidade"),
          // ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(vertical: 10),
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "Rateio Por Comunidade",
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                  )
                ]),
          ),

          pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: PdfColors.black,
                width: 1,
              ),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text("Comunidades"),
                  ],
                ),
              ),
              pw.Table.fromTextArray(
                context: context,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                  4: pw.Alignment.center,
                },
                data: [
                  [
                    "Comunidade",
                    "Cobrantes",
                    "Pagantes",
                    "Valor por Pessoa",
                    "Total",
                  ],
                  ...comunidadesEvento.map((e) => [
                        e.comNome,
                        e.pagantesCobrantes.cobrantes.toString(),
                        e.pagantesCobrantes.pagantes.toString(),
                        NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ).format(valorPorPessoa),
                        NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ).format(
                            valorPorPessoa * e.pagantesCobrantes.cobrantes),
                      ]),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text("Despesas Adicionais por Comunidade"),
                  ],
                ),
              ),
              pw.Table.fromTextArray(
                context: context,
                columnWidths: {
                  0: pw.FlexColumnWidth(1.25),
                  1: pw.FlexColumnWidth(1.25),
                  2: pw.FlexColumnWidth(1),
                  3: pw.FlexColumnWidth(1),
                  4: pw.FlexColumnWidth(1),
                },
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                },
                data: [
                  [
                    "Comunidade",
                    "Nome",
                    "Quantidade",
                    "Valor Unitário",
                    "Valor Total"
                  ],
                  ...despesasExtraComunidade.map((e) => [
                        e.keys.first,
                        e.values.first,
                        "1",
                        NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ).format(e.values.first),
                        NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ).format(e.values.first),
                      ]),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
    gerarPDF();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscaDadosPrimarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Card(
            color: Cores.cinzaClaro,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: Cores.branco,
                    ),
                    child: carregando
                        ? const Expanded(
                            child: SizedBox(
                            height: 350,
                            child: Center(
                              child: CarregamentoIOS(),
                            ),
                          ))
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Evento: ${widget.nomeEvento}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "Cobrante: $cobrantesEvento",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Pagante: $pagantesEvento",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Text(
                                        "Valor Cozinha:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height: 45,
                                          child: CupertinoTextField(
                                            placeholder: "R\$ 0,00",
                                            controller: valorCozinhaController,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                valorCozinha = double.parse(
                                                  value.replaceAll(',', '.'),
                                                );
                                              });
                                            },
                                            inputFormatters: const [],
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Cores.cinzaEscuro,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CupertinoButton(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        color: Cores.verdeMedio,
                                        onPressed: () {
                                          inserirAtualizarValorCozinha();
                                        },
                                        child: const Icon(
                                            CupertinoIcons.check_mark),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Valor Hostiária:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: SizedBox(
                                          height: 45,
                                          child: CupertinoTextField(
                                            placeholder: "R\$ 0,00",
                                            controller:
                                                valorHostiariaController,
                                            keyboardType: TextInputType.number,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Cores.cinzaEscuro,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CupertinoButton(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 10,
                                        ),
                                        color: Cores.verdeMedio,
                                        onPressed: () {
                                          inserirAtualizarValorHostiaria();
                                        },
                                        child: const Icon(
                                            CupertinoIcons.check_mark),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        // "Valor Total:",
                                        "Valor Hospedagem:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Cores.branco,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Cores.cinzaEscuro,
                                              width: 1,
                                            ),
                                          ),
                                          height: 45,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  NumberFormat.currency(
                                                    locale: 'pt_BR',
                                                    symbol: 'R\$',
                                                    decimalDigits: 2,
                                                  ).format(valorEvento),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  const Text(
                                    "Despesas/Serviços Adicionais:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Nome:",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: CupertinoTextField(
                                                      placeholder:
                                                          "Despesa ou Serviço",
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      controller:
                                                          nomeDespesaController,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              Cores.cinzaEscuro,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Column(
                                                  children: [
                                                    Text(
                                                      "Qtd:",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 20),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 65,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      maxLength: 2,
                                                      controller:
                                                          qtdDespesaController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Qtd.',
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            color: Cores
                                                                .cinzaEscuro,
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Por favor, digite a quantidade de itens/serviços';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Valor:",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: CupertinoTextField(
                                                      placeholder: "R\$ 0,00",
                                                      keyboardType:
                                                          TextInputType.number,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      controller:
                                                          valorDespesaController,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color:
                                                              Cores.cinzaEscuro,
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        children: [
                                          CupertinoButton(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 10,
                                            ),
                                            color: Cores.verdeMedio,
                                            onPressed: () {
                                              inserirNovaDespesaEvento();
                                            },
                                            child: const Text("+"),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Divider(
                                      color: Cores.cinzaEscuro,
                                      thickness: 1,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: despesasExtra.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(despesasExtra[index].dseNome,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Spacer(),
                                              Text(
                                                  despesasExtra[index]
                                                      .dseQuantidade
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Spacer(),
                                              Text(
                                                  NumberFormat.currency(
                                                    locale: 'pt_BR',
                                                    symbol: 'R\$',
                                                    decimalDigits: 2,
                                                  ).format(despesasExtra[index]
                                                      .dseValor),
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: comunidadesEvento.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: CardDespesasComunidade(
                            // nomeDespesaController: nomeDespesaController,
                            // valorDespesaController: valorDespesaController,
                            valorPorPessoa: valorPorPessoa,
                            cobrante: comunidadesEvento[index]
                                .pagantesCobrantes
                                .cobrantes,
                            pagante: comunidadesEvento[index]
                                .pagantesCobrantes
                                .pagantes,
                            nomeComunidade: comunidadesEvento[index].comNome,
                          ),
                        );
                      },
                    ),
                  ),
                  // const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      color: Cores.branco,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text("Total:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text(
                              NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2,
                              ).format(calcularValorTotalEvento()),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Cores.branco,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Divider(
                        color: Cores.cinzaEscuro,
                        thickness: 1,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Cores.branco,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 40,
                            ),
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
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 40,
                            ),
                            color: Cores.verdeMedio,
                            onPressed: () {
                              // salvarPessoas();
                              criarPaginasPDF();
                            },
                            child: const Row(
                              children: [
                                Icon(CupertinoIcons.printer),
                                SizedBox(width: 10),
                                Text("Gerar"),
                              ],
                            ),
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
      ),
    );
  }
}

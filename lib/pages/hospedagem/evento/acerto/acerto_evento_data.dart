import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:painel_ccmn/data/api/hospedagem/api_evento_despesa.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart';

import '../../../../data/data.dart';
import '../../../../data/models/web/hospedagem/evento_despesas_model.dart';
import '../../../../funcoes/funcoes_mascara.dart';

class AcertoEventoData {
  buscarEventoDespesas(
      {required int codigoEvento,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    var retorno = await ApiEventoDespesa().getEventoDespesas(codigoEvento);
    if (retorno.statusCode == 200) {
      dadosRetorno(json.decode(retorno.body));
    } else {
      erro();
    }
  }

  buscarServicosEvento(
      {required int codigoEvento,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    var retorno = await ApiEventoDespesa().getServicosEvento(codigoEvento);
    if (retorno.statusCode == 200) {
      dadosRetorno(json.decode(retorno.body));
    } else {
      erro();
    }
  }

  buscarProdutosEvento(
      {required int codigoEvento,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    var retorno = await ApiEventoDespesa().getProdutosEvento(codigoEvento);
    if (retorno.statusCode == 200) {
      dadosRetorno(json.decode(retorno.body));
    } else {
      erro();
    }
  }

  buscarComunidadesEvento({
    required int codigoEvento,
    required Function(dynamic) dadosRetorno,
    required Function() erro,
  }) async {
    var retorno = await ApiAcerto().getComunidadesEvento(codigoEvento);
    if (retorno.statusCode == 200) {
      dadosRetorno(json.decode(retorno.body));
    } else {
      erro();
    }
  }

  buscarCustoEvento({
    required int codigoEvento,
    required Function(dynamic) dadosRetorno,
    required Function() erro,
  }) async {
    var retorno = await ApiAcerto().getEventoCusto(codigoEvento);
    if (retorno.statusCode == 200) {
      dadosRetorno(json.decode(retorno.body));
    } else {
      erro();
    }
  }

  buscarCustoCozinha({
    required int codigoEvento,
    required Function(dynamic) dadosRetorno,
    required Function() erro,
  }) async {
    var retorno = await ApiAcerto().getValorCozinha(codigoEvento);
    if (retorno.statusCode == 200) {
      dadosRetorno(retorno.body);
    } else {
      erro();
    }
    // setState(() => carregando = false);
  }

  buscarCustoHostiaria({
    required int codigoEvento,
    required Function(dynamic) dadosRetorno,
    required Function() erro,
  }) async {
    // setState(() => carregando = true);
    var retorno = await ApiAcerto().getValorHostiaria(codigoEvento);
    if (retorno.statusCode == 200) {
      dadosRetorno(retorno.body);
    } else {
      erro();
    }
    // setState(() => carregando = false);
  }

  buscarPessoasPagantesCobrantesEvento({
    required int codigoEvento,
    required Function(dynamic) dadosRetorno,
    required Function() erro,
  }) async {
    // setState(() => carregando = true);
    var retorno = await ApiAcerto().getEventoPessoas(codigoEvento);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      dadosRetorno(decoded);
    } else {
      erro();
    }
    // setState(() => carregando = false);
  }

  busarDespesasExtraEvento(
      int codigoEvento, Function(dynamic) dadosRetorno, Function() erro) async {
    var retorno = await ApiAcerto().getEventoDespesas(codigoEvento);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      dadosRetorno(decoded);
    } else {
      erro();
    }
  }

  // busarDespesasExtraComunidade() async {}

  inserirDespesaEvento(
      {required EventoDespesasModel despesa,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    var retorno = await ApiEventoDespesa().postEventoDespesa(despesa);
    if (retorno.statusCode == 200) {
      dadosRetorno(retorno.body);
    } else {
      erro();
    }
  }

  inserirAtualizarValorCozinha(
      {required int codigoEvento,
      required String valorCozinha,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    // setState(() => carregando = true);
    var retorno = await ApiAcerto().postDespesaCozinha(
      codigoEvento,
      double.parse(valorCozinha.replaceAll("R\$", "").replaceAll(",", ".")),
    );
    if (retorno.statusCode == 200) {
      dadosRetorno(retorno.body);
    } else {
      erro();
    }
    // await buscarCustoCozinha();
    // calcularValorTotalEvento();
    // setState(() => carregando = false);
  }

  inserirAtualizarValorHostiaria(
      {required int codigoEvento,
      required String valorHostiaria,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    // setState(() => carregando = true);
    var retorno = await ApiAcerto().postDespesaHostiaria(
      codigoEvento,
      double.parse(valorHostiaria.replaceAll("R\$", "").replaceAll(",", ".")),
    );
    if (retorno.statusCode == 200) {
      dadosRetorno(retorno.body);
    } else {
      erro();
    }
    // await buscarCustoHostiaria();
    // calcularValorTotalEvento();
    // setState(() => carregando = false);
  }

  inserirAtualizarValorHospedagem(
      {required int codigoEvento,
      required int qtdPessoasCobrantes,
      required String valorHospedagem,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    // setState(() => carregando = true);
    double valor = (double.parse(valorHospedagem
            .replaceAll("R\$", "")
            .replaceAll(",", ".")
            .replaceAll(" ", "")) /
        qtdPessoasCobrantes);
    var retorno = await ApiAcerto().postDespesaHospedagem(codigoEvento, valor);
    if (retorno.statusCode == 200) {
      dadosRetorno(retorno.body);
    } else {
      erro();
    }
    // await buscarCustoEvento();
    // calcularValorTotalEvento();
    // setState(() => carregando = false);
  }

  excluirDespesaEvento(
      {required int codigoDespesa,
      required Function(dynamic) dadosRetorno,
      required Function() erro}) async {
    var retorno = await ApiEventoDespesa().deleteEventoDespesa(codigoDespesa);
    if (retorno.statusCode == 200) {
      dadosRetorno(retorno.body);
    } else {
      erro();
    }
  }

  // calcularValoresPorPessoa(double valorEvento) {
  //   setState(() {
  //     valorPorPessoa = 0;
  //     valorPorPessoa =
  //         double.parse((valorEvento / pagantesEvento).toStringAsFixed(2));
  //   });
  // }
  gerarPDF(pw.Document documento) async {
    // final pdf = pw.Document();
    var savedFile = await documento.save();
    List<int> fileInts = List.from(savedFile);
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download",
          "Dados Acerto Evento - ${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();
  }

  calcularValoresExtras(int codigoComunidade, List<dynamic> servicosEvento,
      List<dynamic> produtosEvento, double valorPorPessoa, int pagantes) {
    List<dynamic> servicos = servicosEvento
        .where((element) => element.serComunidade == codigoComunidade)
        .toList();
    List<dynamic> produtos = produtosEvento
        .where((element) => element.serComunidade == codigoComunidade)
        .toList();
    if (servicos.isEmpty && produtos.isEmpty) {
      return valorPorPessoa;
    } else if (servicos.isNotEmpty && produtos.isEmpty) {
      return valorPorPessoa +
          (servicos
                  .map((e) => e.serValor * e.serQuantidade)
                  .reduce((value, element) => value + element) /
              pagantes);
    } else if (servicos.isEmpty && produtos.isNotEmpty) {
      return valorPorPessoa +
          (produtos
                  .map((e) => e.serValor * e.serQuantidade)
                  .reduce((value, element) => value + element) /
              pagantes);
    } else {
      return valorPorPessoa +
          ((servicos
                      .map((e) => e.serValor * e.serQuantidade)
                      .reduce((value, element) => value + element) +
                  produtos
                      .map((e) => e.serValor * e.serQuantidade)
                      .reduce((value, element) => value + element)) /
              pagantes);
    }
  }

  adicionarServicosComunidades(
      List<dynamic> servicosEvento, List<dynamic> comunidadesEvento) {
    List<Map<dynamic, dynamic>> servicosComunidades = [];
    for (var item in servicosEvento) {
      for (var comunidade in comunidadesEvento) {
        if (item.serComunidade == comunidade.comCodigo) {
          servicosComunidades.add({
            "comunidade": comunidade.comNome,
            "servico": item.serNome,
            "valor": item.serValor,
            "quantidade": item.serQuantidade,
            "total": item.serValor * item.serQuantidade,
          });
        }
      }
    }
    return servicosComunidades;
  }

  adicionarProdutosComunidades(
      List<dynamic> produtosEvento, List<dynamic> comunidadesEvento) {
    List<Map<dynamic, dynamic>> produtosComunidades = [];
    for (var item in produtosEvento) {
      for (var comunidade in comunidadesEvento) {
        if (item.serComunidade == comunidade.comCodigo) {
          produtosComunidades.add({
            "comunidade": comunidade.comNome,
            "produto": item.serNome,
            "valor": item.serValor,
            "quantidade": item.serQuantidade,
            "total": item.serValor * item.serQuantidade,
          });
        }
      }
    }
    return produtosComunidades;
  }

  criarPaginasPDF({
    required String nomeEvento,
    required double valorServicos,
    required double valorProdutos,
    required double valorEvento,
    required double valorPorPessoa,
    required double valorTotal,
    required List<dynamic> comunidadesEvento,
    required List<dynamic> servicosEvento,
    required List<dynamic> produtosEvento,
    required bool dividirPorPessoa,
  }) {
    final pdf = pw.Document();
    pdf.addPage(
      // pw.Page(
      //   build: (pw.Context context) =>
      //       pw.Center(child: pw.Text('Hello World!')),
      // ),
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(10),
        build: (context) => [
          pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 1),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 20),
                child: pw.Row(
                  children: [
                    pw.Text("Acerto do Evento",
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Spacer(),
                    pw.Text(nomeEvento,
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Text("Valor Total Serviços: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Flexible(
                      fit: pw.FlexFit.tight,
                      child: pw.Divider(color: PdfColors.black, thickness: 1),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text(
                        NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2)
                            .format(valorServicos),
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Text("Valor Total Produtos: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Flexible(
                      fit: pw.FlexFit.tight,
                      child: pw.Divider(color: PdfColors.black, thickness: 1),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text(
                        NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2)
                            .format(valorProdutos),
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
                    pw.Flexible(
                      fit: pw.FlexFit.tight,
                      child: pw.Divider(color: PdfColors.black, thickness: 1),
                    ),
                    pw.SizedBox(width: 10),
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
                    pw.Text("Valor Total Evento: ",
                        style: const pw.TextStyle(fontSize: 10)),
                    pw.Flexible(
                      fit: pw.FlexFit.tight,
                      child: pw.Divider(
                        color: PdfColors.black,
                        thickness: 1,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Text(FuncoesMascara.mascaraDinheiro(valorTotal),
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            ]),
          ),
          servicosEvento.any((element) => element.serComunidade == 0)
              ? servicosEvento.isNotEmpty
                  ? pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 20, bottom: 8),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text("Serviços do Evento",
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold))
                          ]),
                    )
                  : pw.SizedBox()
              : pw.SizedBox(),
          servicosEvento.any((element) => element.serComunidade == 0)
              ? servicosEvento.isNotEmpty
                  ? pw.Container(
                      padding: const pw.EdgeInsets.all(15),
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                          borderRadius: pw.BorderRadius.circular(10)),
                      child: pw.Column(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 10),
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [pw.Text("Serviços")])),
                        pw.Table.fromTextArray(
                          context: context,
                          cellAlignments: {
                            0: pw.Alignment.centerLeft,
                            1: pw.Alignment.center,
                            2: pw.Alignment.center,
                            3: pw.Alignment.center,
                          },
                          data: [
                            [
                              "Nome",
                              "Valor",
                              "Quantidade",
                              "Total",
                            ],
                            ...servicosEvento
                                .where((element) => element.serComunidade == 0)
                                .map((e) => [
                                      e.serNome,
                                      FuncoesMascara.mascaraDinheiro(
                                          e.serValor),
                                      e.serQuantidade.toString(),
                                      FuncoesMascara.mascaraDinheiro(
                                          e.serValor * e.serQuantidade)
                                    ]),
                          ],
                        ),
                      ]),
                    )
                  : pw.SizedBox()
              : pw.SizedBox(),
          dividirPorPessoa
              ? pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20, bottom: 8),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Servicos por Comunidade",
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: pw.FontWeight.bold))
                      ]),
                )
              : pw.SizedBox(),
          dividirPorPessoa
              ? pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                      borderRadius: pw.BorderRadius.circular(10)),
                  child: pw.Column(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 10),
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [pw.Text("Servicos")])),
                    pw.Table.fromTextArray(context: context, cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                    }, data: [
                      [
                        "Comunidade",
                        "Nome",
                        "Valor",
                        "Quantidade",
                        "Total",
                      ],
                      ...adicionarServicosComunidades(
                              servicosEvento, comunidadesEvento)
                          .map((e) => [
                                e["comunidade"],
                                e["servico"],
                                FuncoesMascara.mascaraDinheiro(e["valor"]),
                                e["quantidade"].toString(),
                                FuncoesMascara.mascaraDinheiro(e["total"])
                              ]),
                    ]),
                  ]),
                )
              : pw.SizedBox(),
          produtosEvento.any((element) => element.serComunidade == 0)
              ? produtosEvento.isNotEmpty
                  ? pw.Padding(
                      padding: const pw.EdgeInsets.only(top: 20, bottom: 8),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text("Produtos do Evento",
                                style: pw.TextStyle(
                                    fontSize: 16,
                                    fontWeight: pw.FontWeight.bold))
                          ]),
                    )
                  : pw.SizedBox()
              : pw.SizedBox(),
          produtosEvento.any((element) => element.serComunidade == 0)
              ? produtosEvento.isNotEmpty
                  ? pw.Container(
                      padding: const pw.EdgeInsets.all(15),
                      decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(color: PdfColors.black, width: 1),
                          borderRadius: pw.BorderRadius.circular(10)),
                      child: pw.Column(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 10),
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [pw.Text("Produtos")])),
                        pw.Table.fromTextArray(
                          context: context,
                          cellAlignments: {
                            0: pw.Alignment.centerLeft,
                            1: pw.Alignment.center,
                            2: pw.Alignment.center,
                            3: pw.Alignment.center,
                          },
                          data: [
                            [
                              "Nome",
                              "Valor",
                              "Quantidade",
                              "Total",
                            ],
                            ...produtosEvento
                                .where((element) => element.serComunidade == 0)
                                .map((e) => [
                                      e.serNome,
                                      FuncoesMascara.mascaraDinheiro(
                                          e.serValor),
                                      e.serQuantidade.toString(),
                                      FuncoesMascara.mascaraDinheiro(
                                          e.serValor * e.serQuantidade)
                                    ]),
                          ],
                        ),
                      ]),
                    )
                  : pw.SizedBox()
              : pw.SizedBox(),
          dividirPorPessoa
              ? pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20, bottom: 8),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Produtos por Comunidade",
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: pw.FontWeight.bold))
                      ]),
                )
              : pw.SizedBox(),
          dividirPorPessoa
              ? pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                      borderRadius: pw.BorderRadius.circular(10)),
                  child: pw.Column(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 10),
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [pw.Text("Produtos")])),
                    pw.Table.fromTextArray(context: context, cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                    }, data: [
                      [
                        "Comunidade",
                        "Nome",
                        "Valor",
                        "Quantidade",
                        "Total",
                      ],
                      ...adicionarProdutosComunidades(
                              produtosEvento, comunidadesEvento)
                          .map((e) => [
                                e["comunidade"],
                                e["produto"],
                                FuncoesMascara.mascaraDinheiro(e["valor"]),
                                e["quantidade"].toString(),
                                FuncoesMascara.mascaraDinheiro(e["total"])
                              ]),
                    ]),
                  ]),
                )
              : pw.SizedBox(),
          //verificar se não está maior que a tela do pdf
          !dividirPorPessoa
              ? pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20, bottom: 8),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Rateio Por Pessoa",
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: pw.FontWeight.bold))
                      ]),
                )
              : pw.Padding(
                  padding: const pw.EdgeInsets.only(top: 20, bottom: 8),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Rateio Por Comunidade",
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: pw.FontWeight.bold))
                      ]),
                ),
          dividirPorPessoa
              ? pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                      borderRadius: pw.BorderRadius.circular(10)),
                  child: pw.Column(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 10),
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [pw.Text("Comunidades")])),
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
                              servicosEvento.any((element) =>
                                      element.serComunidade == e.comCodigo)
                                  ? FuncoesMascara.mascaraDinheiro(
                                      calcularValoresExtras(
                                        e.comCodigo,
                                        servicosEvento,
                                        produtosEvento,
                                        valorPorPessoa,
                                        e.pagantesCobrantes.pagantes,
                                      ),
                                    )
                                  : FuncoesMascara.mascaraDinheiro(
                                      valorPorPessoa),
                              // FuncoesMascara.mascaraDinheiro(valorPorPessoa),
                              FuncoesMascara.mascaraDinheiro(servicosEvento.any(
                                      (element) =>
                                          element.serComunidade == e.comCodigo)
                                  ? (calcularValoresExtras(
                                        e.comCodigo,
                                        servicosEvento,
                                        produtosEvento,
                                        valorPorPessoa,
                                        e.pagantesCobrantes.pagantes,
                                      ) *
                                      e.pagantesCobrantes.cobrantes)
                                  : (valorPorPessoa *
                                      e.pagantesCobrantes.cobrantes))
                            ]),
                      ],
                    ),
                  ]),
                )
              : pw.Container(
                  padding: const pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 1),
                      borderRadius: pw.BorderRadius.circular(10)),
                  child: pw.Column(children: [
                    pw.Padding(
                        padding: const pw.EdgeInsets.only(bottom: 10),
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [pw.Text("Pessoas")])),
                    pw.Table.fromTextArray(context: context, cellAlignments: {
                      0: pw.Alignment.centerLeft,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                    }, data: [
                      [
                        "Qtd. Comunidades",
                        "Cobrantes",
                        "Pagantes",
                        "Valor por Pessoa",
                        "Total",
                      ],
                      [
                        comunidadesEvento.length,
                        comunidadesEvento
                            .map((e) => e.pagantesCobrantes.cobrantes)
                            .reduce((value, element) => value + element),
                        comunidadesEvento
                            .map((e) => e.pagantesCobrantes.pagantes)
                            .reduce((value, element) => value + element),
                        FuncoesMascara.mascaraDinheiro(valorPorPessoa),
                        FuncoesMascara.mascaraDinheiro(valorPorPessoa *
                            comunidadesEvento
                                .map((e) => e.pagantesCobrantes.cobrantes)
                                .reduce((value, element) => value + element))
                      ],
                    ]
                        // ...comunidadesEvento.map((e) => [
                        //       comunidadesEvento.length,
                        //       comunidadesEvento
                        //           .map((e) => e.pagantesCobrantes.cobrantes)
                        //           .reduce((value, element) => value + element),
                        //       comunidadesEvento
                        //           .map((e) => e.pagantesCobrantes.pagantes)
                        //           .reduce((value, element) => value + element),
                        //       // e.pagantesCobrantes.cobrantes.toString(),
                        //       // e.pagantesCobrantes.pagantes.toString(),
                        //       FuncoesMascara.mascaraDinheiro(valorPorPessoa),
                        //       FuncoesMascara.mascaraDinheiro(valorPorPessoa *
                        //           e.pagantesCobrantes.cobrantes)
                        //     ]),
                        // ],
                        ),
                  ]),
                ),
        ],
      ),
    );
    gerarPDF(pdf);
  }
}

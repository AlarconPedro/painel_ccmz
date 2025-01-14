import 'dart:convert';

import '../../../../data/data.dart';

class AcertoEventoData {
  buscarComunidadesEvento({
    required int codigoEvento,
    required Function(dynamic) dadosRetorno,
    required Function() erro,
  }) async {
    var retorno = await ApiAcerto().getComunidadesEvento(codigoEvento);
    if (retorno.statusCode == 200) {
      print(retorno.body);
      var decoded = json.decode(retorno.body);
      dadosRetorno(decoded);
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
      var decoded = json.decode(retorno.body);
      dadosRetorno(decoded);
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

  // calcularValorTotalEvento() {
  //   double total = 0;
  //   setState(() {
  //     total = 0;
  //     total += valorEvento;
  //     total += valorCozinha;
  //     total += valorHostiaria;
  //     for (var element in despesasExtra) {
  //       total += (element.dseValor * element.dseQuantidade);
  //       valorExtraEvento += (element.dseValor * element.dseQuantidade);
  //     }
  //     for (var element in despesasExtraComunidade) {
  //       total += element.values.first;
  //     }
  //   });
  //   calcularValoresPorPessoa(total);
  //   return total;
  // }

  // calcularValoresPorPessoa(double valorEvento) {
  //   setState(() {
  //     valorPorPessoa = 0;
  //     valorPorPessoa =
  //         double.parse((valorEvento / pagantesEvento).toStringAsFixed(2));
  //   });
  // }

  // EventoDespesasModel prearaDadosDespesaEvento() {
  //   return EventoDespesasModel(
  //     dseCodigo: 0,
  //     eveCodigo: widget.codigoEvento,
  //     dseNome: nomeDespesaController.text,
  //     dseQuantidade: qtdDespesaController.text.isEmpty
  //         ? 1
  //         : int.parse(qtdDespesaController.text),
  //     dseValor: double.parse(valorDespesaController.text),
  //   );
  // }

  // inserirNovaDespesaEvento() async {
  //   setState(() => carregando = true);
  //   var retorno =
  //       await ApiAcerto().postDespesaEvento(prearaDadosDespesaEvento());
  //   if (retorno.statusCode == 200) {
  //     await busarDespesasExtraEvento();
  //     valorDespesaController.clear();
  //     nomeDespesaController.clear();
  //     qtdDespesaController.clear();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Despesa adicionada com sucesso"),
  //         backgroundColor: Cores.verdeMedio,
  //       ),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Erro ao adicionar despesa"),
  //         backgroundColor: Cores.vermelhoMedio,
  //       ),
  //     );
  //   }
  //   setState(() => carregando = false);
  // }

  // gerarPDF() async {
  //   var savedFile = await pdf.save();
  //   List<int> fileInts = List.from(savedFile);
  //   html.AnchorElement(
  //       href:
  //           "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
  //     ..setAttribute("download",
  //         "Dados Acerto Evento - ${DateTime.now().millisecondsSinceEpoch}.pdf")
  //     ..click();
  // }

  // criarPaginasPDF() {
  //   final pdf = pw.Document();
  //   pdf.addPage(
  //     pw.MultiPage(
  //       margin: const pw.EdgeInsets.all(10),
  //       build: (context) => [
  //         pw.Container(
  //           padding: const pw.EdgeInsets.all(15),
  //           decoration: pw.BoxDecoration(
  //             border: pw.Border.all(
  //               color: PdfColors.black,
  //               width: 1,
  //             ),
  //             borderRadius: pw.BorderRadius.circular(10),
  //           ),
  //           child: pw.Column(children: [
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 20),
  //               child: pw.Row(
  //                 children: [
  //                   pw.Text(
  //                     "Acerto do Evento",
  //                     style: pw.TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.Spacer(),
  //                   pw.Text(
  //                     widget.nomeEvento,
  //                     style: pw.TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 10),
  //               child: pw.Row(
  //                 children: [
  //                   pw.Text("Valor Total Cozinha: ",
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                   pw.Flexible(
  //                     fit: pw.FlexFit.tight,
  //                     child: pw.Divider(
  //                       color: PdfColors.black,
  //                       thickness: 1,
  //                     ),
  //                   ),
  //                   pw.SizedBox(width: 10),
  //                   pw.Text(
  //                       NumberFormat.currency(
  //                               locale: 'pt_BR',
  //                               symbol: 'R\$',
  //                               decimalDigits: 2)
  //                           .format(valorCozinha),
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                 ],
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 10),
  //               child: pw.Row(
  //                 children: [
  //                   pw.Text("Valor Total Hostiaria: ",
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                   pw.Flexible(
  //                     fit: pw.FlexFit.tight,
  //                     child: pw.Divider(
  //                       color: PdfColors.black,
  //                       thickness: 1,
  //                     ),
  //                   ),
  //                   pw.SizedBox(width: 10),
  //                   pw.Text(
  //                       NumberFormat.currency(
  //                               locale: 'pt_BR',
  //                               symbol: 'R\$',
  //                               decimalDigits: 2)
  //                           .format(valorHostiaria),
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                 ],
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 10),
  //               child: pw.Row(
  //                 children: [
  //                   pw.Text("Valor Total Hospedagem: ",
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                   pw.Flexible(
  //                     fit: pw.FlexFit.tight,
  //                     child: pw.Divider(
  //                       color: PdfColors.black,
  //                       thickness: 1,
  //                     ),
  //                   ),
  //                   pw.SizedBox(width: 10),
  //                   pw.Text(
  //                       NumberFormat.currency(
  //                               locale: 'pt_BR',
  //                               symbol: 'R\$',
  //                               decimalDigits: 2)
  //                           .format(valorEvento),
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                 ],
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 10),
  //               child: pw.Row(
  //                 children: [
  //                   pw.Text("Valor Total Despesas Adicionais Evento: ",
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                   pw.Flexible(
  //                     fit: pw.FlexFit.tight,
  //                     child: pw.Divider(
  //                       color: PdfColors.black,
  //                       thickness: 1,
  //                     ),
  //                   ),
  //                   pw.SizedBox(width: 10),
  //                   pw.Text(
  //                       despesasExtra.isNotEmpty
  //                           ? FuncoesMascara.mascaraDinheiro(despesasExtra
  //                               .map((e) => e.dseValor * e.dseQuantidade)
  //                               .reduce((value, element) => value + element))
  //                           : "R\$ 0,00",
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 10),
  //               child: pw.Row(
  //                 children: [
  //                   pw.Text("Valor Total Evento: ",
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                   pw.Flexible(
  //                     fit: pw.FlexFit.tight,
  //                     child: pw.Divider(
  //                       color: PdfColors.black,
  //                       thickness: 1,
  //                     ),
  //                   ),
  //                   pw.SizedBox(width: 10),
  //                   pw.Text(
  //                       FuncoesMascara.mascaraDinheiro(
  //                           calcularValorTotalEvento()),
  //                       style: const pw.TextStyle(fontSize: 10)),
  //                 ],
  //               ),
  //             ),
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 10),
  //               child: pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.center,
  //                 children: [
  //                   pw.Text("Despesas Adicionais"),
  //                 ],
  //               ),
  //             ),
  //             pw.Table.fromTextArray(
  //               context: context,
  //               cellAlignments: {
  //                 0: pw.Alignment.centerLeft,
  //                 1: pw.Alignment.center,
  //                 2: pw.Alignment.center,
  //                 3: pw.Alignment.center,
  //               },
  //               data: [
  //                 ["Nome", "Quantidade", "Valor Unitário", "Valor Total"],
  //                 ...despesasExtra.map((e) => [
  //                       e.dseNome,
  //                       e.dseQuantidade.toString(),
  //                       FuncoesMascara.mascaraDinheiro(e.dseValor),
  //                       FuncoesMascara.mascaraDinheiro(
  //                           e.dseValor * e.dseQuantidade)
  //                     ]),
  //               ],
  //             ),
  //           ]),
  //         ),
  //         pw.Padding(
  //           padding: const pw.EdgeInsets.symmetric(vertical: 10),
  //           child: pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.center,
  //               children: [
  //                 pw.Text("Rateio Por Comunidade",
  //                     style: pw.TextStyle(
  //                         fontSize: 16, fontWeight: pw.FontWeight.bold))
  //               ]),
  //         ),
  //         pw.Container(
  //           padding: const pw.EdgeInsets.all(15),
  //           decoration: pw.BoxDecoration(
  //               border: pw.Border.all(color: PdfColors.black, width: 1),
  //               borderRadius: pw.BorderRadius.circular(10)),
  //           child: pw.Column(children: [
  //             pw.Padding(
  //                 padding: const pw.EdgeInsets.only(bottom: 10),
  //                 child: pw.Row(
  //                     mainAxisAlignment: pw.MainAxisAlignment.center,
  //                     children: [pw.Text("Comunidades")])),
  //             pw.Table.fromTextArray(
  //               context: context,
  //               cellAlignments: {
  //                 0: pw.Alignment.centerLeft,
  //                 1: pw.Alignment.center,
  //                 2: pw.Alignment.center,
  //                 3: pw.Alignment.center,
  //                 4: pw.Alignment.center,
  //               },
  //               data: [
  //                 [
  //                   "Comunidade",
  //                   "Cobrantes",
  //                   "Pagantes",
  //                   "Valor por Pessoa",
  //                   "Total",
  //                 ],
  //                 ...comunidadesEvento.map((e) => [
  //                       e.comNome,
  //                       e.pagantesCobrantes.cobrantes.toString(),
  //                       e.pagantesCobrantes.pagantes.toString(),
  //                       FuncoesMascara.mascaraDinheiro(valorPorPessoa),
  //                       FuncoesMascara.mascaraDinheiro(
  //                           valorPorPessoa * e.pagantesCobrantes.cobrantes)
  //                     ]),
  //               ],
  //             ),
  //             pw.SizedBox(height: 10),
  //             pw.Padding(
  //               padding: const pw.EdgeInsets.only(bottom: 10),
  //               child: pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.center,
  //                 children: [
  //                   pw.Text("Despesas Adicionais por Comunidade"),
  //                 ],
  //               ),
  //             ),
  //             pw.Table.fromTextArray(
  //               context: context,
  //               columnWidths: {
  //                 0: const pw.FlexColumnWidth(1.25),
  //                 1: const pw.FlexColumnWidth(1.25),
  //                 2: const pw.FlexColumnWidth(1),
  //                 3: const pw.FlexColumnWidth(1),
  //                 4: const pw.FlexColumnWidth(1),
  //               },
  //               cellAlignments: {
  //                 0: pw.Alignment.centerLeft,
  //                 1: pw.Alignment.center,
  //                 2: pw.Alignment.center,
  //                 3: pw.Alignment.center,
  //               },
  //               data: [
  //                 [
  //                   "Comunidade",
  //                   "Nome",
  //                   "Quantidade",
  //                   "Valor Unitário",
  //                   "Valor Total"
  //                 ],
  //                 ...despesasExtraComunidade.map((e) => [
  //                       e.keys.first,
  //                       e.values.first,
  //                       "1",
  //                       FuncoesMascara.mascaraDinheiro(e.values.first),
  //                       FuncoesMascara.mascaraDinheiro(e.values.first)
  //                     ]),
  //               ],
  //             ),
  //           ]),
  //         ),
  //       ],
  //     ),
  //   );
  //   gerarPDF();
  // }
}

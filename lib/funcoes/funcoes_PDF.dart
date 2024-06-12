import 'dart:convert';

import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class FuncoesPDF {
  static gerarPDF(pw.Document pdf, String titulo) async {
    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute(
          "download", "$titulo - ${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();
  }
}

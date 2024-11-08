import 'package:flutter/material.dart';

Widget listarDados({
  required List<dynamic> dados,
  required Function(dynamic dados) cardListagem,
  required String textoVazio,
  double? horPad,
  double? vrtPad,
}) {
  return Expanded(
    child: dados.isEmpty
        ? Center(
            child: Text(textoVazio,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horPad ??= 10, vertical: vrtPad ??= 10),
            child: ListView.builder(
                itemCount: dados.length,
                itemBuilder: (context, index) => cardListagem(dados[index]))),
  );
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../classes/classes.dart';

class AlocacaoEventoPessoas extends StatelessWidget {
  QuartoModel quarto;

  List<Widget> vagasQuarto;

  Function removePessoa;

  AlocacaoEventoPessoas({
    super.key,
    required this.quarto,
    required this.vagasQuarto,
    required this.removePessoa,
  });

  bool carregando = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 150,
        horizontal: 200,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Cores.branco,
        boxShadow: const [
          BoxShadow(
            color: Cores.cinzaMedio,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                quarto.quaNome,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Cores.verdeMedio.withOpacity(0.2),
              ),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ...vagasQuarto,
                    ],
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

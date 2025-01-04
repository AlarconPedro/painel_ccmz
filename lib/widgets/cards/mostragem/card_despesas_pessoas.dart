import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../classes/classes.dart';

class CardDespesasPessoas extends StatelessWidget {
  int qtdComunidades;
  int qtdCobrantes;
  int qtdPagantes;
  double valorPorPessoa;
  double valorEvento;
  CardDespesasPessoas({
    super.key,
    required this.qtdComunidades,
    required this.qtdCobrantes,
    required this.qtdPagantes,
    required this.valorPorPessoa,
    required this.valorEvento,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Cores.branco,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Cores.azulMedio,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Comunidades: $qtdComunidades",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Cores.branco,
                        )),
                    const Spacer(),
                    Text("Cobrante: $qtdCobrantes",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Cores.branco,
                        )),
                    const SizedBox(width: 10),
                    Text("Pagante: $qtdPagantes",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Cores.branco,
                        )),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    "Valor por Pessoa:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          NumberFormat.currency(
                                  locale: 'pt_BR',
                                  symbol: 'R\$',
                                  decimalDigits: 2)
                              .format(valorPorPessoa),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text("Valor Total:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Text(
                          NumberFormat.currency(
                                  decimalDigits: 2,
                                  locale: 'pt_BR',
                                  symbol: 'R\$',
                                  name: 'R\$')
                              .format(valorEvento),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

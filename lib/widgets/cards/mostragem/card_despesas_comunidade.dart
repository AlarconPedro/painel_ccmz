import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../classes/classes.dart';

class CardDespesasComunidade extends StatefulWidget {
  TextEditingController nomeDespesaController;
  TextEditingController valorDespesaController;

  double valorPorPessoa;

  CardDespesasComunidade(
      {super.key,
      required this.nomeDespesaController,
      required this.valorDespesaController,
      required this.valorPorPessoa});

  @override
  State<CardDespesasComunidade> createState() => _CardDespesasComunidadeState();
}

class _CardDespesasComunidadeState extends State<CardDespesasComunidade> {
  List<Map<String, double>> despesasExtra = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Cores.branco,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Comunidade: Nome da Comunidade",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Cobrante: 80",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Pagante: 80",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Valor P/ Pessoa:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Cores.branco,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Cores.cinzaEscuro,
                          width: 1,
                        ),
                      ),
                      height: 45,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              NumberFormat.currency(
                                locale: 'pt_BR',
                                symbol: 'R\$',
                                decimalDigits: 2,
                              ).format(widget.valorPorPessoa),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                  // const SizedBox(width: 10),
                  // Expanded(
                  //   child: SizedBox(
                  //     height: 45,
                  //     child: CupertinoTextField(
                  //       placeholder: NumberFormat.currency(
                  //         locale: 'pt_BR',
                  //         symbol: 'R\$',
                  //         decimalDigits: 2,
                  //       ).format(widget.valorPorPessoa),
                  //       keyboardType: TextInputType.number,
                  //       inputFormatters: [
                  //         TextInputFormatter.withFunction(
                  //           (oldValue, newValue) {
                  //             if (newValue.text.isEmpty) {
                  //               return newValue.copyWith(
                  //                 text: '0,00',
                  //               );
                  //             } else {
                  //               final double value = double.parse(
                  //                 newValue.text.replaceAll(',', '.'),
                  //               );
                  //               final String newText = NumberFormat.currency(
                  //                 locale: 'pt_BR',
                  //                 symbol: 'R\$',
                  //                 decimalDigits: 2,
                  //               ).format(value / 100);
                  //               return newValue.copyWith(
                  //                 text: newText,
                  //               );
                  //             }
                  //           },
                  //         ),
                  //       ],
                  //       padding: const EdgeInsets.all(5),
                  //       decoration: BoxDecoration(
                  //         // color: Cores.cinzaClaro,
                  //         border: Border.all(
                  //           color: Cores.cinzaEscuro,
                  //           width: 1,
                  //         ),
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  const SizedBox(width: 10),
                  const Text(
                    "Valor Total:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Cores.branco,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Cores.cinzaEscuro,
                          width: 1,
                        ),
                      ),
                      height: 45,
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text("R\$ 0,00"),
                          ],
                        ),
                      )),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Divider(
                  color: Cores.cinzaEscuro,
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Despesas/Serviços Adicionais:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Nome:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: CupertinoTextField(
                        placeholder: "Despesa ou Serviço",
                        padding: const EdgeInsets.all(5),
                        controller: widget.nomeDespesaController,
                        decoration: BoxDecoration(
                          // color: Cores.cinzaClaro,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Cores.cinzaEscuro,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Valor:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: CupertinoTextField(
                        placeholder: "R\$ 0,00",
                        keyboardType: TextInputType.number,
                        padding: const EdgeInsets.all(5),
                        controller: widget.valorDespesaController,
                        decoration: BoxDecoration(
                          // color: Cores.cinzaClaro,
                          borderRadius: BorderRadius.circular(10),
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
                      // salvarPessoas();
                      setState(() {
                        despesasExtra.add({
                          widget.nomeDespesaController.text: double.parse(
                            widget.valorDespesaController.text
                                .replaceAll(',', '.'),
                          ),
                        });
                        widget.nomeDespesaController.clear();
                        widget.valorDespesaController.clear();
                      });
                    },
                    child: const Text("+"),
                  ),
                ],
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
                          Text(despesasExtra[index].keys.first,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text(
                              despesasExtra[index]
                                  .values
                                  .first
                                  .toStringAsFixed(2),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
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
    );
  }
}

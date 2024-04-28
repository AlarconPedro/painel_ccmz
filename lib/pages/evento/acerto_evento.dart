import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';

class AcertoEvento extends StatefulWidget {
  const AcertoEvento({super.key});

  @override
  State<AcertoEvento> createState() => _AcertoEventoState();
}

class _AcertoEventoState extends State<AcertoEvento> {
  List<Map<String, double>> despesasExtra = [];

  TextEditingController valorCozinhaController = TextEditingController();
  TextEditingController valorHostiariaController = TextEditingController();

  TextEditingController nomeDespesaController = TextEditingController();
  TextEditingController valorDespesaController = TextEditingController();

  buscarPessoasPagantesCobrantesEvento() async {}

  buscarPessoasPagantesCobrantesComunidade() async {}

  busarDespesasExtraEvento() async {}

  busarDespesasExtraComunidade() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
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
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    color: Cores.branco,
                    shape: const RoundedRectangleBorder(
                      // borderRadius: BorderRadius.only(
                      //   topLeft: Radius.circular(10),
                      //   topRight: Radius.circular(10),
                      // ),
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
                                  "Evento: Nome do Evento",
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
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                            if (newValue.text.isEmpty) {
                                              return newValue.copyWith(
                                                text: '0,00',
                                              );
                                            } else {
                                              final double value = double.parse(
                                                newValue.text
                                                    .replaceAll(',', '.'),
                                              );
                                              final String newText =
                                                  NumberFormat.currency(
                                                locale: 'pt_BR',
                                                symbol: 'R\$',
                                                decimalDigits: 2,
                                              ).format(value / 100);
                                              return newValue.copyWith(
                                                text: newText,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        // color: Cores.cinzaClaro,
                                        border: Border.all(
                                          color: Cores.cinzaEscuro,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
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
                                      keyboardType: TextInputType.number,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        // color: Cores.cinzaClaro,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Cores.cinzaEscuro,
                                          width: 1,
                                        ),
                                      ),
                                      // decoration: BoxDecoration(
                                      //   color: Cores.cinzaClaro,
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Valor Total:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Divider(
                                color: Cores.cinzaEscuro,
                                thickness: 1,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Despesas/Serviços Adicionais:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
                                  "Nome:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: CupertinoTextField(
                                      placeholder: "Despesa ou Serviço",
                                      padding: const EdgeInsets.all(5),
                                      controller: nomeDespesaController,
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
                                      keyboardType: TextInputType.number,
                                      padding: const EdgeInsets.all(5),
                                      controller: valorDespesaController,
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
                                        nomeDespesaController.text:
                                            double.parse(
                                          valorDespesaController.text
                                              .replaceAll(',', '.'),
                                        ),
                                      });
                                      nomeDespesaController.clear();
                                      valorDespesaController.clear();
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
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        const Spacer(),
                                        Text(
                                            despesasExtra[index]
                                                .values
                                                .first
                                                .toStringAsFixed(2),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
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
                  CardDespesasComunidade(
                    nomeDespesaController: nomeDespesaController,
                    valorDespesaController: valorDespesaController,
                  ),
                  const Spacer(),
                  Container(
                    decoration: const BoxDecoration(
                      color: Cores.branco,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text("Total:",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Spacer(),
                          Text("R\$ 0,00",
                              style: TextStyle(
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

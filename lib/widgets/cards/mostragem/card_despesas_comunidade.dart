import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/servico_evento_model.dart';

import '../../../classes/classes.dart';

class CardDespesasComunidade extends StatelessWidget {
  // TextEditingController nomeDespesaController;
  // TextEditingController valorDespesaController;

  double valorPorPessoa;
  List<ServicoEventoModel>? servicosComunidade;
  List<ServicoEventoModel>? produtosComunidade;

  int pagante;
  int cobrante;
  int codigoComunidade;

  String nomeComunidade;

  CardDespesasComunidade({
    super.key,
    // required this.nomeDespesaController,
    // required this.valorDespesaController,
    required this.valorPorPessoa,
    this.servicosComunidade,
    this.produtosComunidade,
    required this.pagante,
    required this.cobrante,
    required this.codigoComunidade,
    required this.nomeComunidade,
  });

  List<Map<String, double>> despesasExtra = [];

  TextEditingController nomeDespesaController = TextEditingController();

  TextEditingController valorDespesaController = TextEditingController();

  List<ServicoEventoModel> listaServicos = [];
  List<ServicoEventoModel> listaProdutos = [];

  double valoresExtras = 0;
  double valorTotalComunidade = 0;

  calcularValorTotalComunidade() {
    if (servicosComunidade != null) {
      for (var item in servicosComunidade!) {
        if (item.serComunidade == codigoComunidade) {
          listaServicos.add(item);
        }
      }
    }
    if (produtosComunidade != null) {
      for (var item in produtosComunidade!) {
        if (item.serComunidade == codigoComunidade) {
          listaProdutos.add(item);
        }
      }
    }
    double servicos = listaServicos.fold(
        0, (previousValue, element) => previousValue + element.serValor);
    double produtos = listaProdutos.fold(
        0, (previousValue, element) => previousValue + element.serValor);
    valoresExtras = ((servicos + produtos) / pagante);
    valorPorPessoa += valoresExtras;
    valorTotalComunidade = (valorPorPessoa * cobrante);
    // for (var item in despesasExtra) {
    //   valorTotal += item.values.first;
    // }
  }

  @override
  Widget build(BuildContext context) {
    calcularValorTotalComunidade();
    return Card(
      elevation: 5,
      color: Cores.branco,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
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
                    Text("Comunidade: $nomeComunidade",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Cores.branco,
                        )),
                    const Spacer(),
                    Text("Cobrante: $cobrante",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Cores.branco,
                        )),
                    const SizedBox(width: 10),
                    Text("Pagante: $pagante",
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                .format(valorTotalComunidade),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              ),
            ),
            listaServicos.isNotEmpty
                ? Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                      ...listaServicos
                          .map((e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    Text(e.serNome,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    Text(
                                        NumberFormat.currency(
                                                locale: 'pt_BR',
                                                symbol: 'R\$',
                                                decimalDigits: 2)
                                            .format(e.serValor),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ))
                          .toList(),
                      ...listaProdutos.map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              children: [
                                Text(e.serNome,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                Text(
                                    NumberFormat.currency(
                                            locale: 'pt_BR',
                                            symbol: 'R\$',
                                            decimalDigits: 2)
                                        .format(e.serValor),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ))
                    ],
                  )
                // Expanded(
                //     child: ListView.builder(
                //       itemCount: servicosComunidade!.length,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 5, horizontal: 10),
                //           child: Row(
                //             children: [
                //               Text(servicosComunidade![index].serNome,
                //                   style: const TextStyle(
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.bold)),
                //               const Spacer(),
                //               Text(
                //                   NumberFormat.currency(
                //                           locale: 'pt_BR',
                //                           symbol: 'R\$',
                //                           decimalDigits: 2)
                //                       .format(servicosComunidade![index]
                //                           .serValor),
                //                   style: const TextStyle(
                //                       fontSize: 18,
                //                       fontWeight: FontWeight.bold)),
                //             ],
                //           ),
                //         );
                //       },
                //     ),
                //   )
                : const SizedBox(),
            // produtosComunidade != null
            //     ? produtosComunidade!.isNotEmpty
            //         ? Expanded(
            //             child: ListView.builder(
            //               itemCount: produtosComunidade!.length,
            //               itemBuilder: (context, index) {
            //                 return Padding(
            //                   padding: const EdgeInsets.symmetric(
            //                       vertical: 5, horizontal: 10),
            //                   child: Row(
            //                     children: [
            //                       Text(produtosComunidade![index].serNome,
            //                           style: const TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.bold)),
            //                       const Spacer(),
            //                       Text(
            //                           NumberFormat.currency(
            //                                   locale: 'pt_BR',
            //                                   symbol: 'R\$',
            //                                   decimalDigits: 2)
            //                               .format(produtosComunidade![index]
            //                                   .serValor),
            //                           style: const TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.bold)),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           )
            //         : const SizedBox()
            //     : const SizedBox(),
          ],
        ),
      ),
    );
    // return Card(
    //   elevation: 5,
    //   color: Cores.branco,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(10)),
    //   ),
    //   child: SizedBox(
    //     width: MediaQuery.of(context).size.width / 1.5,
    //     height: 300,
    //     child: Column(
    //       children: [
    //         Container(
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(10),
    //               topRight: Radius.circular(10),
    //             ),
    //             color: Cores.azulMedio,
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text("Comunidade: ${widget.nomeComunidade}",
    //                     style: const TextStyle(
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                       color: Cores.branco,
    //                     )),
    //                 const Spacer(),
    //                 Text("Cobrante: ${widget.cobrante}",
    //                     style: const TextStyle(
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                       color: Cores.branco,
    //                     )),
    //                 const SizedBox(width: 10),
    //                 Text("Pagante: ${widget.pagante}",
    //                     style: const TextStyle(
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                       color: Cores.branco,
    //                     )),
    //                 const SizedBox(width: 10),
    //               ],
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10),
    //           child: Row(
    //             children: [
    //               const Text(
    //                 "Valor P/ Pessoa:",
    //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //               ),
    //               const SizedBox(width: 10),
    //               Flexible(
    //                 fit: FlexFit.tight,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: Cores.branco,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Cores.cinzaEscuro,
    //                       width: 1,
    //                     ),
    //                   ),
    //                   height: 45,
    //                   child: Center(
    //                       child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10),
    //                     child: Row(
    //                       children: [
    //                         Text(
    //                           NumberFormat.currency(
    //                             locale: 'pt_BR',
    //                             symbol: 'R\$',
    //                             decimalDigits: 2,
    //                           ).format(widget.valorPorPessoa),
    //                           style: const TextStyle(
    //                               fontSize: 18, fontWeight: FontWeight.bold),
    //                         ),
    //                       ],
    //                     ),
    //                   )),
    //                 ),
    //               ),
    //               const SizedBox(width: 10),
    //               const SizedBox(width: 10),
    //               const Text(
    //                 "Valor Total:",
    //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //               ),
    //               const SizedBox(width: 10),
    //               Flexible(
    //                 fit: FlexFit.tight,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     color: Cores.branco,
    //                     borderRadius: BorderRadius.circular(10),
    //                     border: Border.all(
    //                       color: Cores.cinzaEscuro,
    //                       width: 1,
    //                     ),
    //                   ),
    //                   height: 45,
    //                   child: Center(
    //                       child: Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 10),
    //                     child: Row(
    //                       children: [
    //                         Text(
    //                           NumberFormat.currency(
    //                             decimalDigits: 2,
    //                             locale: 'pt_BR',
    //                             symbol: 'R\$',
    //                             name: 'R\$',
    //                           ).format(
    //                             calcularValorTotalComunidade(),
    //                           ),
    //                           style: const TextStyle(
    //                               fontSize: 18, fontWeight: FontWeight.bold),
    //                         ),
    //                       ],
    //                     ),
    //                   )),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         // const Padding(
    //         //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    //         //   child: Divider(
    //         //     color: Cores.cinzaEscuro,
    //         //     thickness: 1,
    //         //   ),
    //         // ),
    //         const SizedBox(height: 10),
    //         const Text(
    //           "Despesas/Serviços Adicionais:",
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //         const SizedBox(height: 10),
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10),
    //           child: Row(
    //             children: [
    //               const Text(
    //                 "Nome:",
    //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //               ),
    //               const SizedBox(width: 10),
    //               Expanded(
    //                 child: SizedBox(
    //                   height: 45,
    //                   child: CupertinoTextField(
    //                     placeholder: "Despesa ou Serviço",
    //                     padding: const EdgeInsets.all(5),
    //                     controller: nomeDespesaController,
    //                     decoration: BoxDecoration(
    //                       // color: Cores.cinzaClaro,
    //                       borderRadius: BorderRadius.circular(10),
    //                       border: Border.all(
    //                         color: Cores.cinzaEscuro,
    //                         width: 1,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(width: 10),
    //               const Text(
    //                 "Valor:",
    //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //               ),
    //               const SizedBox(width: 10),
    //               Expanded(
    //                 child: SizedBox(
    //                   height: 45,
    //                   child: CupertinoTextField(
    //                     placeholder: "R\$ 0,00",
    //                     keyboardType: TextInputType.number,
    //                     padding: const EdgeInsets.all(5),
    //                     controller: valorDespesaController,
    //                     decoration: BoxDecoration(
    //                       // color: Cores.cinzaClaro,
    //                       borderRadius: BorderRadius.circular(10),
    //                       border: Border.all(
    //                         color: Cores.cinzaEscuro,
    //                         width: 1,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(width: 10),
    //               CupertinoButton(
    //                 padding: const EdgeInsets.symmetric(
    //                   vertical: 10,
    //                   horizontal: 10,
    //                 ),
    //                 color: Cores.verdeMedio,
    //                 onPressed: () {
    //                   // salvarPessoas();
    //                   setState(() {
    //                     despesasExtra.add({
    //                       nomeDespesaController.text: double.parse(
    //                         valorDespesaController.text.replaceAll(',', '.'),
    //                       ),
    //                     });
    //                     nomeDespesaController.clear();
    //                     valorDespesaController.clear();
    //                   });
    //                 },
    //                 child: const Text("+"),
    //               ),
    //             ],
    //           ),
    //         ),
    //         const Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    //           child: Divider(
    //             color: Cores.cinzaEscuro,
    //             thickness: 1,
    //           ),
    //         ),
    //         Expanded(
    //           child: ListView.builder(
    //             itemCount: despesasExtra.length,
    //             itemBuilder: (context, index) {
    //               return Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                   vertical: 5,
    //                   horizontal: 10,
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     Text(despesasExtra[index].keys.first,
    //                         style: const TextStyle(
    //                             fontSize: 18, fontWeight: FontWeight.bold)),
    //                     const Spacer(),
    //                     Text(
    //                         despesasExtra[index]
    //                             .values
    //                             .first
    //                             .toStringAsFixed(2),
    //                         style: const TextStyle(
    //                             fontSize: 18, fontWeight: FontWeight.bold)),
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

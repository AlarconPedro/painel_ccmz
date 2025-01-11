import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/hospedagem/evento/acerto/acerto_evento_outras_despesas.dart';
import 'package:painel_ccmn/pages/pages.dart';

class AcertoEventoView extends StatefulWidget {
  int codigoEvento;
  String nomeEvento;
  AcertoEventoView({
    super.key,
    required this.codigoEvento,
    required this.nomeEvento,
  });

  @override
  State<AcertoEventoView> createState() => _AcertoEventoViewState();
}

class _AcertoEventoViewState extends State<AcertoEventoView> {
  PageController pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // buscaDadosPrimarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: PageView(
          controller: pageController,
          children: [
            AcertoEvento(
              codigoEvento: widget.codigoEvento,
              nomeEvento: widget.nomeEvento,
              mudarPagina: () {
                pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
            ),
            const AcertoEventoOutrasDespesas(),
          ],
        ),
      ),
    );
    // return Scaffold(
    //     backgroundColor: Colors.transparent,
    //     body: Padding(
    //         padding: const EdgeInsets.all(25),
    //         child: Center(
    //             child: Card(
    //                 color: Cores.cinzaClaro,
    //                 elevation: 10,
    //                 shape: const RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.all(Radius.circular(10))),
    //                 child: SizedBox(
    //                     height: MediaQuery.of(context).size.height / 1,
    //                     width: MediaQuery.of(context).size.width / 1.4,
    //                     child: Column(children: [
    //                       Container(
    //                         decoration: const BoxDecoration(
    //                           borderRadius: BorderRadius.only(
    //                               topLeft: Radius.circular(10),
    //                               topRight: Radius.circular(10)),
    //                           color: Cores.branco,
    //                         ),
    //                         child: carregando
    //                             ? const SizedBox(
    //                                 height: 350,
    //                                 child: Center(child: CarregamentoIOS()))
    //                             : SizedBox(
    //                                 width:
    //                                     MediaQuery.of(context).size.width / 1.4,
    //                                 height: 350,
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(10),
    //                                   child: Column(
    //                                     children: [
    //                                       Row(
    //                                         mainAxisAlignment:
    //                                             MainAxisAlignment.center,
    //                                         children: [
    //                                           Text(
    //                                               "Evento: ${widget.nomeEvento}",
    //                                               style: const TextStyle(
    //                                                   fontSize: 20,
    //                                                   fontWeight:
    //                                                       FontWeight.bold)),
    //                                           const Spacer(),
    //                                           Text("Cobrante: $cobrantesEvento",
    //                                               style: const TextStyle(
    //                                                   fontSize: 20,
    //                                                   fontWeight:
    //                                                       FontWeight.bold)),
    //                                           const SizedBox(width: 10),
    //                                           Text("Pagante: $pagantesEvento",
    //                                               style: const TextStyle(
    //                                                   fontSize: 20,
    //                                                   fontWeight:
    //                                                       FontWeight.bold)),
    //                                           const SizedBox(width: 10)
    //                                         ],
    //                                       ),
    //                                       const SizedBox(height: 10),
    //                                       Row(
    //                                         children: [
    //                                           const Text("Valor Cozinha:",
    //                                               style: TextStyle(
    //                                                   fontSize: 18,
    //                                                   fontWeight:
    //                                                       FontWeight.bold)),
    //                                           const SizedBox(width: 10),
    //                                           Expanded(
    //                                             child: SizedBox(
    //                                               height: 45,
    //                                               child: CupertinoTextField(
    //                                                 placeholder: "R\$ 0,00",
    //                                                 controller:
    //                                                     valorCozinhaController,
    //                                                 keyboardType:
    //                                                     TextInputType.number,
    //                                                 onChanged: (value) {
    //                                                   setState(() {
    //                                                     valorCozinha =
    //                                                         double.parse(
    //                                                       value.replaceAll(
    //                                                           ',', '.'),
    //                                                     );
    //                                                   });
    //                                                 },
    //                                                 inputFormatters: const [],
    //                                                 padding:
    //                                                     const EdgeInsets.all(5),
    //                                                 decoration: BoxDecoration(
    //                                                     border: Border.all(
    //                                                         color: Cores
    //                                                             .cinzaEscuro,
    //                                                         width: 1),
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(10)),
    //                                               ),
    //                                             ),
    //                                           ),
    //                                           const SizedBox(width: 10),
    //                                           CupertinoButton(
    //                                               padding: const EdgeInsets
    //                                                   .symmetric(
    //                                                   vertical: 10,
    //                                                   horizontal: 10),
    //                                               color: Cores.verdeMedio,
    //                                               onPressed: () =>
    //                                                   inserirAtualizarValorCozinha(),
    //                                               child: const Icon(
    //                                                   CupertinoIcons
    //                                                       .check_mark)),
    //                                           const SizedBox(width: 10),
    //                                           const Text("Valor Hostiária:",
    //                                               style: TextStyle(
    //                                                   fontSize: 18,
    //                                                   fontWeight:
    //                                                       FontWeight.bold)),
    //                                           const SizedBox(width: 10),
    //                                           Expanded(
    //                                               child: SizedBox(
    //                                                   height: 45,
    //                                                   child: CupertinoTextField(
    //                                                       placeholder:
    //                                                           "R\$ 0,00",
    //                                                       controller:
    //                                                           valorHostiariaController,
    //                                                       keyboardType:
    //                                                           TextInputType
    //                                                               .number,
    //                                                       padding:
    //                                                           const EdgeInsets
    //                                                               .all(5),
    //                                                       decoration: BoxDecoration(
    //                                                           borderRadius:
    //                                                               BorderRadius
    //                                                                   .circular(
    //                                                                       10),
    //                                                           border: Border.all(
    //                                                               color: Cores
    //                                                                   .cinzaEscuro,
    //                                                               width: 1))))),
    //                                           const SizedBox(width: 10),
    //                                           CupertinoButton(
    //                                               padding: const EdgeInsets
    //                                                   .symmetric(
    //                                                   vertical: 10,
    //                                                   horizontal: 10),
    //                                               color: Cores.verdeMedio,
    //                                               onPressed: () =>
    //                                                   inserirAtualizarValorHostiaria(),
    //                                               child: const Icon(
    //                                                   CupertinoIcons
    //                                                       .check_mark)),
    //                                           const SizedBox(width: 10),
    //                                           const Text(
    //                                               // "Valor Total:",
    //                                               "Valor Hospedagem:",
    //                                               style: TextStyle(
    //                                                   fontSize: 18,
    //                                                   fontWeight:
    //                                                       FontWeight.bold)),
    //                                           const SizedBox(width: 10),
    //                                           Expanded(
    //                                               child: Container(
    //                                                   decoration: BoxDecoration(
    //                                                     color: Cores.branco,
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(10),
    //                                                     border: Border.all(
    //                                                       color:
    //                                                           Cores.cinzaEscuro,
    //                                                       width: 1,
    //                                                     ),
    //                                                   ),
    //                                                   height: 45,
    //                                                   child: Center(
    //                                                       child: Padding(
    //                                                           padding:
    //                                                               const EdgeInsets
    //                                                                   .symmetric(
    //                                                                   horizontal:
    //                                                                       10),
    //                                                           child: Row(
    //                                                               children: [
    //                                                                 Text(
    //                                                                     FuncoesMascara.mascaraDinheiro(
    //                                                                         valorEvento),
    //                                                                     style: const TextStyle(
    //                                                                         fontSize:
    //                                                                             18,
    //                                                                         fontWeight:
    //                                                                             FontWeight.bold))
    //                                                               ])))))
    //                                         ],
    //                                       ),
    //                                       const SizedBox(height: 15),
    //                                       const Text(
    //                                           "Despesas/Serviços Adicionais:",
    //                                           style: TextStyle(
    //                                               fontSize: 18,
    //                                               fontWeight: FontWeight.bold)),
    //                                       const SizedBox(height: 10),
    //                                       Row(
    //                                         children: [
    //                                           Expanded(
    //                                             child: Column(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment.start,
    //                                               children: [
    //                                                 Row(
    //                                                   children: [
    //                                                     const Text("Nome:",
    //                                                         style: TextStyle(
    //                                                             fontSize: 18,
    //                                                             fontWeight:
    //                                                                 FontWeight
    //                                                                     .bold)),
    //                                                     const SizedBox(
    //                                                         width: 10),
    //                                                     Expanded(
    //                                                         child: SizedBox(
    //                                                             height: 45,
    //                                                             child: CupertinoTextField(
    //                                                                 placeholder:
    //                                                                     "Despesa ou Serviço",
    //                                                                 padding:
    //                                                                     const EdgeInsets
    //                                                                         .all(
    //                                                                         5),
    //                                                                 controller:
    //                                                                     nomeDespesaController,
    //                                                                 decoration: BoxDecoration(
    //                                                                     borderRadius:
    //                                                                         BorderRadius.circular(
    //                                                                             10),
    //                                                                     border: Border.all(
    //                                                                         color:
    //                                                                             Cores.cinzaEscuro,
    //                                                                         width: 1)))))
    //                                                   ],
    //                                                 ),
    //                                                 const SizedBox(height: 20),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(width: 10),
    //                                           Expanded(
    //                                             child: Column(
    //                                               children: [
    //                                                 Row(
    //                                                   children: [
    //                                                     const Column(
    //                                                       children: [
    //                                                         Text("Qtd:",
    //                                                             style: TextStyle(
    //                                                                 fontSize:
    //                                                                     18,
    //                                                                 fontWeight:
    //                                                                     FontWeight
    //                                                                         .bold)),
    //                                                         SizedBox(height: 20)
    //                                                       ],
    //                                                     ),
    //                                                     const SizedBox(
    //                                                         width: 10),
    //                                                     Expanded(
    //                                                       child: SizedBox(
    //                                                         height: 65,
    //                                                         child:
    //                                                             TextFormField(
    //                                                           keyboardType:
    //                                                               TextInputType
    //                                                                   .number,
    //                                                           maxLength: 2,
    //                                                           controller:
    //                                                               qtdDespesaController,
    //                                                           decoration: const InputDecoration(
    //                                                               labelText: 'Qtd.',
    //                                                               enabledBorder: OutlineInputBorder(
    //                                                                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                                                                   borderSide: BorderSide(
    //                                                                     color: Cores
    //                                                                         .cinzaEscuro,
    //                                                                   )),
    //                                                               border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
    //                                                           validator:
    //                                                               (value) {
    //                                                             if (value ==
    //                                                                     null ||
    //                                                                 value
    //                                                                     .isEmpty) {
    //                                                               return 'Por favor, digite a quantidade de itens/serviços';
    //                                                             }
    //                                                             return null;
    //                                                           },
    //                                                         ),
    //                                                       ),
    //                                                     ),
    //                                                   ],
    //                                                 ),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(width: 10),
    //                                           Expanded(
    //                                             child: Column(
    //                                               mainAxisAlignment:
    //                                                   MainAxisAlignment.start,
    //                                               children: [
    //                                                 Row(
    //                                                   children: [
    //                                                     const Text(
    //                                                       "Valor:",
    //                                                       style: TextStyle(
    //                                                           fontSize: 18,
    //                                                           fontWeight:
    //                                                               FontWeight
    //                                                                   .bold),
    //                                                     ),
    //                                                     const SizedBox(
    //                                                         width: 10),
    //                                                     Expanded(
    //                                                       child: SizedBox(
    //                                                         height: 45,
    //                                                         child:
    //                                                             CupertinoTextField(
    //                                                           placeholder:
    //                                                               "R\$ 0,00",
    //                                                           keyboardType:
    //                                                               TextInputType
    //                                                                   .number,
    //                                                           padding:
    //                                                               const EdgeInsets
    //                                                                   .all(5),
    //                                                           controller:
    //                                                               valorDespesaController,
    //                                                           decoration:
    //                                                               BoxDecoration(
    //                                                             borderRadius:
    //                                                                 BorderRadius
    //                                                                     .circular(
    //                                                                         10),
    //                                                             border:
    //                                                                 Border.all(
    //                                                               color: Cores
    //                                                                   .cinzaEscuro,
    //                                                               width: 1,
    //                                                             ),
    //                                                           ),
    //                                                         ),
    //                                                       ),
    //                                                     ),
    //                                                   ],
    //                                                 ),
    //                                                 const SizedBox(height: 20),
    //                                               ],
    //                                             ),
    //                                           ),
    //                                           const SizedBox(width: 10),
    //                                           Column(
    //                                             children: [
    //                                               CupertinoButton(
    //                                                 padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                   vertical: 10,
    //                                                   horizontal: 10,
    //                                                 ),
    //                                                 color: Cores.verdeMedio,
    //                                                 onPressed: () {
    //                                                   inserirNovaDespesaEvento();
    //                                                 },
    //                                                 child: const Text("+"),
    //                                               ),
    //                                               const SizedBox(height: 20),
    //                                             ],
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       const Padding(
    //                                         padding: EdgeInsets.symmetric(
    //                                             horizontal: 5, vertical: 5),
    //                                         child: Divider(
    //                                           color: Cores.cinzaEscuro,
    //                                           thickness: 1,
    //                                         ),
    //                                       ),
    //                                       Expanded(
    //                                         child: ListView.builder(
    //                                           itemCount: despesasExtra.length,
    //                                           itemBuilder: (context, index) {
    //                                             return Padding(
    //                                               padding: const EdgeInsets
    //                                                   .symmetric(
    //                                                 vertical: 5,
    //                                                 horizontal: 10,
    //                                               ),
    //                                               child: Row(
    //                                                 children: [
    //                                                   Text(
    //                                                       despesasExtra[index]
    //                                                           .dseNome,
    //                                                       style: const TextStyle(
    //                                                           fontSize: 18,
    //                                                           fontWeight:
    //                                                               FontWeight
    //                                                                   .bold)),
    //                                                   const Spacer(),
    //                                                   Text(
    //                                                       despesasExtra[index]
    //                                                           .dseQuantidade
    //                                                           .toString(),
    //                                                       style: const TextStyle(
    //                                                           fontSize: 18,
    //                                                           fontWeight:
    //                                                               FontWeight
    //                                                                   .bold)),
    //                                                   const Spacer(),
    //                                                   Text(
    //                                                       NumberFormat.currency(
    //                                                         locale: 'pt_BR',
    //                                                         symbol: 'R\$',
    //                                                         decimalDigits: 2,
    //                                                       ).format(
    //                                                           despesasExtra[
    //                                                                   index]
    //                                                               .dseValor),
    //                                                       style: const TextStyle(
    //                                                           fontSize: 18,
    //                                                           fontWeight:
    //                                                               FontWeight
    //                                                                   .bold))
    //                                                 ],
    //                                               ),
    //                                             );
    //                                           },
    //                                         ),
    //                                       )
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ),
    //                       ),
    //                       const SizedBox(height: 10),
    //                       Expanded(
    //                         child: ListView.builder(
    //                           itemCount: comunidadesEvento.length,
    //                           itemBuilder: (context, index) {
    //                             return Padding(
    //                               padding: const EdgeInsets.symmetric(
    //                                   vertical: 5, horizontal: 10),
    //                               child: CardDespesasComunidade(
    //                                 // nomeDespesaController: nomeDespesaController,
    //                                 // valorDespesaController: valorDespesaController,
    //                                 valorPorPessoa: valorPorPessoa,
    //                                 cobrante: comunidadesEvento[index]
    //                                     .pagantesCobrantes
    //                                     .cobrantes,
    //                                 pagante: comunidadesEvento[index]
    //                                     .pagantesCobrantes
    //                                     .pagantes,
    //                                 nomeComunidade:
    //                                     comunidadesEvento[index].comNome,
    //                               ),
    //                             );
    //                           },
    //                         ),
    //                       ),

    //                       // const Spacer(),
    //                       Container(
    //                           decoration: const BoxDecoration(
    //                             color: Cores.branco,
    //                           ),
    //                           child: Padding(
    //                               padding: const EdgeInsets.all(10),
    //                               child: Row(
    //                                 children: [
    //                                   const Text("Total:",
    //                                       style: TextStyle(
    //                                           fontSize: 18,
    //                                           fontWeight: FontWeight.bold)),
    //                                   const Spacer(),
    //                                   Text(
    //                                       NumberFormat.currency(
    //                                         locale: 'pt_BR',
    //                                         symbol: 'R\$',
    //                                         decimalDigits: 2,
    //                                       ).format(calcularValorTotalEvento()),
    //                                       style: const TextStyle(
    //                                           fontSize: 18,
    //                                           fontWeight: FontWeight.bold))
    //                                 ],
    //                               ))),
    //                       Container(
    //                           decoration:
    //                               const BoxDecoration(color: Cores.branco),
    //                           child: const Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   vertical: 5, horizontal: 10),
    //                               child: Divider(
    //                                   color: Cores.cinzaEscuro, thickness: 1))),
    //                       Container(
    //                           decoration: const BoxDecoration(
    //                               borderRadius: BorderRadius.only(
    //                                   bottomLeft: Radius.circular(10),
    //                                   bottomRight: Radius.circular(10)),
    //                               color: Cores.branco),
    //                           child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Padding(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         vertical: 10, horizontal: 10),
    //                                     child: CupertinoButton(
    //                                         padding: const EdgeInsets.symmetric(
    //                                             vertical: 8, horizontal: 40),
    //                                         color: Cores.vermelhoMedio,
    //                                         onPressed: () =>
    //                                             Navigator.pop(context),
    //                                         child: const Text("Fechar"))),
    //                                 Padding(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         vertical: 10, horizontal: 10),
    //                                     child: CupertinoButton(
    //                                         padding: const EdgeInsets.symmetric(
    //                                             vertical: 8, horizontal: 40),
    //                                         color: Cores.verdeMedio,
    //                                         onPressed: () =>
    //                                             // salvarPessoas();
    //                                             criarPaginasPDF(),
    //                                         child: const Row(children: [
    //                                           Icon(CupertinoIcons.printer),
    //                                           SizedBox(width: 10),
    //                                           Text("Gerar")
    //                                         ])))
    //                               ]))
    //                     ]))))));
  }
}

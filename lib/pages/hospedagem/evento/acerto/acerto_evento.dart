import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/funcoes/funcoes_mascara.dart';
import 'package:painel_ccmn/widgets/form/campo_texto.dart';
import 'package:painel_ccmn/widgets/textos/textos.dart';
import '../../../../classes/classes.dart';
import '../../../../widgets/widgets.dart';

class AcertoEvento extends StatefulWidget {
  int codigoEvento;
  String nomeEvento;
  AcertoEvento({
    super.key,
    required this.codigoEvento,
    required this.nomeEvento,
  });

  @override
  State<AcertoEvento> createState() => _AcertoEventoState();
}

class _AcertoEventoState extends State<AcertoEvento> {
  List<EventoDespesasModel> despesasExtra = [];
  List<Map<String, double>> despesasExtraComunidade = [];

  TextEditingController valorCozinhaController = TextEditingController();
  TextEditingController valorHostiariaController = TextEditingController();

  TextEditingController nomeDespesaController = TextEditingController();
  TextEditingController valorDespesaController = TextEditingController();
  TextEditingController qtdDespesaController = TextEditingController();

  List<AcertoModel> comunidadesEvento = [];

  MaskTextInputFormatter valorFormatter = MaskTextInputFormatter(
    mask: '###.###.###.###.###,00',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool carregando = false;
  bool dividirComunidade = false;

  double valorEvento = 0;
  double valorExtraEvento = 0;
  double valorComunidade = 0;
  double valorPorPessoa = 0;
  double valorCozinha = 0;
  double valorHostiaria = 0;

  double alturaFormulario = 530;
  double larguraFormulario = 950;

  String tipoCobrancaEvento = "";

  int pagantesEvento = 0;
  int cobrantesEvento = 0;
  int pagantesComunidade = 0;
  int cobrantesComunidade = 0;

  int codigoComunidade = 0;

  // buscaDadosPrimarios() async {
  //   await buscarCustoEvento();
  //   await buscarCustoCozinha();
  //   await buscarCustoHostiaria();
  //   await buscarPessoasPagantesCobrantesEvento();
  //   await buscarComunidadesEvento();
  // }

  alterarAlturaFormulario() {
    setState(() {
      if (alturaFormulario == 800 && dividirComunidade) {
        alturaFormulario = 530;
      } else {
        alturaFormulario = 800;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // buscaDadosPrimarios();
  }

  calcularValorTotalComunidade() {
    double valorTotal = 0;
    valorTotal += (200 * 10);
    // for (var item in despesasExtra) {
    //   valorTotal += item.values.first;
    // }
    return valorTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Card(
          color: Cores.cinzaClaro,
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: alturaFormulario,
            width: larguraFormulario,
            child: Column(
              children: [
                SizedBox(
                  height: 350,
                  child: Center(
                    child: carregando
                        ? const CarregamentoIOS()
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                color: Cores.branco,
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                // decoration: const BoxDecoration(
                                //     borderRadius: BorderRadius.all(
                                //       Radius.circular(10),
                                //     ),
                                //     boxShadow: [
                                //       BoxShadow(
                                //           color: Cores.cinzaEscuro,
                                //           blurRadius: 5,
                                //           spreadRadius: 1,
                                //           offset: Offset(0, 0))
                                //     ],
                                //     color: Cores.branco),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          color: Cores.azulMedio),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Row(children: [
                                          Textos.textoMedioNormal(
                                              texto:
                                                  "Evento: ${widget.nomeEvento}",
                                              cor: Cores.branco),
                                          const Spacer(),
                                          Textos.textoMedioNormal(
                                              texto:
                                                  "Cobrante: $cobrantesEvento",
                                              cor: Cores.branco),
                                          const SizedBox(width: 10),
                                          Textos.textoMedioNormal(
                                              texto: "Pagante: $pagantesEvento",
                                              cor: Cores.branco),
                                          const SizedBox(width: 10)
                                        ]),
                                      ),
                                    ),
                                    Row(children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            campoTexto(
                                                titulo: "Valor Hospedagem:",
                                                dica: "R\$ 0,00",
                                                icone: CupertinoIcons.house,
                                                temMascara: false,
                                                mascara:
                                                    MaskTextInputFormatter(),
                                                validador: (validador) {
                                                  if (validador == null ||
                                                      validador.isEmpty) {
                                                    return 'Por favor, digite o valor da hospedagem';
                                                  }
                                                  return null;
                                                },
                                                controlador:
                                                    valorDespesaController),
                                            campoTexto(
                                                titulo: "Valor Cozinha:",
                                                dica: "R\$ 0,00",
                                                icone: CupertinoIcons
                                                    .shopping_cart,
                                                temMascara: false,
                                                mascara:
                                                    MaskTextInputFormatter(),
                                                validador: (validador) {
                                                  if (validador == null ||
                                                      validador.isEmpty) {
                                                    return 'Por favor, digite o valor da cozinha';
                                                  }
                                                  return null;
                                                },
                                                controlador:
                                                    valorCozinhaController),
                                            campoTexto(
                                                titulo: "Valor Hostiária:",
                                                dica: "R\$ 0,00",
                                                icone: CupertinoIcons
                                                    .person_3_fill,
                                                temMascara: false,
                                                mascara:
                                                    MaskTextInputFormatter(),
                                                validador: (validador) {
                                                  if (validador == null ||
                                                      validador.isEmpty) {
                                                    return 'Por favor, digite o valor da hostiária';
                                                  }
                                                  return null;
                                                },
                                                controlador:
                                                    valorHostiariaController),
                                          ],
                                        ),
                                      ),
                                      // const Spacer(),
                                      const SizedBox(width: 20),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(
                                              children: [
                                                Textos.textoPequeno(
                                                    texto:
                                                        "Dividir despesas por:",
                                                    cor: Cores.preto),
                                                const SizedBox(width: 10),
                                                Textos.textoPequeno(
                                                    texto: "Pessoa",
                                                    cor: Cores.preto),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: CupertinoSwitch(
                                                      value: dividirComunidade,
                                                      onChanged: (value) {
                                                        alterarAlturaFormulario();
                                                        setState(() =>
                                                            dividirComunidade =
                                                                value);
                                                      }),
                                                ),
                                                Textos.textoPequeno(
                                                    texto: "Comunidade",
                                                    cor: Cores.preto),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 50),
                                          // const Spacer(),
                                          GestureDetector(
                                            onTap: () {},
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Container(
                                                height: 60,
                                                width: 300,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    shape: BoxShape.rectangle,
                                                    color: Cores.azulMedio),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                        Icons.money_off_rounded,
                                                        size: 30,
                                                        color: Cores.branco),
                                                    Textos.textoPequeno(
                                                        texto:
                                                            "Quebras e Outras Despesas",
                                                        cor: Cores.branco),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ]),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Textos.textoMedio(
                                              texto: "Total:",
                                              cor: Cores.preto),
                                          Textos.textoMedio(
                                              texto: "R\$ 0,00",
                                              cor: Cores.preto),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: dividirComunidade
                      ? ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Card(
                                elevation: 5,
                                color: Cores.branco,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
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
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Comunidade: Nome",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.branco,
                                                  )),
                                              Spacer(),
                                              Text("Cobrante: 10",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.branco,
                                                  )),
                                              SizedBox(width: 10),
                                              Text("Pagante: 10",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.branco,
                                                  )),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "Valor por Pessoa:",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'pt_BR',
                                                            symbol: 'R\$',
                                                            decimalDigits: 2)
                                                        .format(200),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            const Text("Valor Total:",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(width: 10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    NumberFormat.currency(
                                                            decimalDigits: 2,
                                                            locale: 'pt_BR',
                                                            symbol: 'R\$',
                                                            name: 'R\$')
                                                        .format(
                                                            calcularValorTotalComunidade()),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Card(
                            elevation: 5,
                            color: Cores.branco,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
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
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("Comunidades: 2",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Cores.branco,
                                              )),
                                          Spacer(),
                                          Text("Cobrante: 30",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Cores.branco,
                                              )),
                                          SizedBox(width: 10),
                                          Text("Pagante: 30",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Cores.branco,
                                              )),
                                          SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Valor por Pessoa:",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                NumberFormat.currency(
                                                        locale: 'pt_BR',
                                                        symbol: 'R\$',
                                                        decimalDigits: 2)
                                                    .format(200),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text("Valor Total:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              Text(
                                                NumberFormat.currency(
                                                        decimalDigits: 2,
                                                        locale: 'pt_BR',
                                                        symbol: 'R\$',
                                                        name: 'R\$')
                                                    .format(
                                                        calcularValorTotalComunidade()),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                          ),
                        ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Cores.branco,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                            onPressed: () {},
                            color: Cores.vermelhoMedio,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Textos.textoPequenoNormal(
                                texto: "Quebras/Outros", cor: Cores.branco)),
                        CupertinoButton(
                            onPressed: () {},
                            color: Cores.verdeMedio,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            child: Row(
                              children: [
                                const Icon(CupertinoIcons.printer,
                                    color: Cores.branco),
                                const SizedBox(width: 10),
                                Textos.textoPequenoNormal(
                                    texto: "Gerar", cor: Cores.branco),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:painel_ccmn/funcoes/funcoes_mascara.dart';

import '../../../classes/classes.dart';
import '../../../data/api/promocao/api_promocao.dart';
import '../../../data/models/web/ganhador_model.dart';

class Sortear extends StatefulWidget {
  int codigoSorteio;
  Sortear({super.key, required this.codigoSorteio});

  @override
  State<Sortear> createState() => _SortearState();
}

class _SortearState extends State<Sortear> {
  String texto = 'Digite o Cupom';

  bool sorteado = false;
  bool carregando = false;

  double largura = 350;
  double altura = 180;

  Color corBackground = Cores.branco;

  final busca = TextEditingController();

  GanhadorModel ganhador = GanhadorModel(
    cupCodigo: 0,
    cupNumero: "",
    cupSorteado: false,
    cupVendido: false,
    parCidade: "",
    parCodigo: 0,
    parFone: "",
    parNome: "",
    parUf: "",
  );

  // final ConfettiController confettiController = ConfettiController();

  double randomInRange(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  limparDados() async {
    setState(() {
      texto = 'Digite o Cupom';
      largura = 350;
      altura = 180;
      corBackground = Cores.branco;
      sorteado = false;
      ganhador = GanhadorModel(
        cupCodigo: 0,
        cupNumero: "",
        cupSorteado: false,
        cupVendido: false,
        parCidade: "",
        parCodigo: 0,
        parFone: "",
        parNome: "",
        parUf: "",
      );
    });
  }

  sortear() async {
    setState(() => carregando = true);
    limparDados();
    var retorno =
        await ApiPromocao().sortearCupom(busca.text, widget.codigoSorteio);
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      setState(() {
        texto = 'Parabéns ';
        sorteado = true;
        largura = 500;
        altura = 300;
        corBackground = Cores.verdeMedio;
        ganhador = GanhadorModel.fromJson(decoded);
      });

      int total = 40;
      int progress = 0;

      Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 350));

        progress++;

        int count = ((1 - progress / total) * 50).toInt();

        Confetti.launch(context,
            options: ConfettiOptions(
              particleCount: count,
              // startVelocity: 5,
              spread: 360,
              scalar: 1.5,
              gravity: 0.5,
              ticks: 350,
              x: randomInRange(0.1, 0.3),
              y: Random().nextDouble() - 0.2,
            ));

        Confetti.launch(context,
            options: ConfettiOptions(
              particleCount: count,
              // startVelocity: 30,
              spread: 360,
              scalar: 1.5,
              gravity: 0.5,
              ticks: 350,
              x: randomInRange(0.7, 0.9),
              y: Random().nextDouble() - 0.2,
            ));

        return progress < total;
      });
    } else if (retorno.statusCode == 404) {
      setState(() {
        texto = 'Nenhum Cupom Encontrado';
        // sorteado = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Nenhum Cupom Encontrado !"),
        ),
      );
    } else if (retorno.statusCode == 405) {
      setState(() {
        texto = 'Nenhum Sorteio Cadastrado';
        // sorteado = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Nenhum Sorteio Cadastrado !"),
        ),
      );
    } else if (retorno.statusCode == 400) {
      setState(() {
        texto = 'Cupom já sorteado';
        // sorteado = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Cupom já sorteado !"),
        ),
      );
    }

    // Confetti.launch(
    //   context,
    //   options: ConfettiOptions(
    //     angle: randomInRange(10, 180),
    //     spread: randomInRange(30, 90),
    //     particleCount: randomInRange(50, 100).toInt(),
    //     y: 0.5,
    //     x: 0.3,
    //   ),
    // );
    // Confetti.launch(
    //   context,
    //   options: ConfettiOptions(
    //     angle: randomInRange(10, 180),
    //     spread: randomInRange(30, 90),
    //     particleCount: randomInRange(50, 100).toInt(),
    //     y: 0.5,
    //     x: 0.7,
    //   ),
    // );

    // Future.doWhile(() async {
    //   await Future.delayed(const Duration(milliseconds: 350));

    //   progress++;

    //   int count = ((1 - progress / total) * 50).toInt();

    //   Confetti.launch(context,
    //       options: ConfettiOptions(
    //         particleCount: count,
    //         // startVelocity: 5,
    //         spread: 360,
    //         scalar: 1.5,
    //         gravity: 0.5,
    //         ticks: 350,
    //         x: randomInRange(0.1, 0.3),
    //         y: Random().nextDouble() - 0.2,
    //       ));

    //   Confetti.launch(context,
    //       options: ConfettiOptions(
    //         particleCount: count,
    //         // startVelocity: 30,
    //         spread: 360,
    //         scalar: 1.5,
    //         gravity: 0.5,
    //         ticks: 350,
    //         x: randomInRange(0.7, 0.9),
    //         y: Random().nextDouble() - 0.2,
    //       ));

    //   return progress < total;
    // });

    // Confetti.launch(
    //   context,
    //   options: ConfettiOptions(
    //     angle: randomInRange(10, 180),
    //     spread: randomInRange(30, 90),
    //     particleCount: randomInRange(50, 100).toInt(),
    //     y: 0.6,
    //     // colors: [
    //     //   Cores.verdeMedio,
    //     //   Cores.verdeClaro,
    //     //   Cores.verdeEscuro,
    //     // ],
    //   ),
    // );
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    // sortear();
    // confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: MouseRegion(
          cursor:
              sorteado ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: GestureDetector(
            onTap: () {
              sorteado ? Navigator.pop(context) : null;
            },
            child: Card(
              color: corBackground,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: largura,
                height: altura,
                decoration: BoxDecoration(
                  color: corBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: sorteado
                    ? Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "$texto ${ganhador.parNome}",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Cores.branco,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cupom: ${ganhador.cupNumero}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Cores.branco,
                                        ),
                                      ),
                                      Text(
                                        "Cidade: ${ganhador.parCidade} - ${ganhador.parUf}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Cores.branco,
                                        ),
                                      ),
                                      Text(
                                        "Telefone: ${FuncoesMascara.mascaraTelefone(ganhador.parFone)}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Cores.branco,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CupertinoButton(
                                  color: Cores.branco,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Fechar",
                                      style:
                                          TextStyle(color: Cores.verdeMedio)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sorteado
                              ? Center(
                                  child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    texto,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                              : const SizedBox(),
                          Stack(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: AbsorbPointer(
                                  absorbing: carregando,
                                  child: Opacity(
                                    opacity: carregando ? 0.5 : 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 55,
                                            child: CupertinoTextField(
                                              controller: busca,
                                              maxLength: 6,
                                              onSubmitted: (value) async {
                                                // if (busca.text.isNotEmpty) {
                                                //   await buscarGanhador("T", cupom: value);
                                                //   busca.clear();
                                                // } else {
                                                //   await buscarGanhador("T");
                                                // }
                                              },
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                  color: Cores.cinzaEscuro,
                                                ),
                                              ),
                                              placeholder: 'Cupon',
                                            ),
                                          ),
                                        ),
                                        // const SizedBox(width: 10),
                                        // CupertinoButton(
                                        //   color: Cores.preto,
                                        //   onPressed: () async {
                                        //     // if (busca.text.isNotEmpty) {
                                        //     //   await buscarGanhador("T", cupom: busca.text);
                                        //     //   busca.clear();
                                        //     // } else {
                                        //     //   await buscarGanhador("T");
                                        //     // }
                                        //   },
                                        //   padding: const EdgeInsets.symmetric(
                                        //     vertical: 16,
                                        //     horizontal: 16,
                                        //   ),
                                        //   child: const Icon(CupertinoIcons.search),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              carregando
                                  ? Positioned(
                                      right: 165,
                                      top: 5,
                                      child: LoadingAnimationWidget
                                          .threeArchedCircle(
                                              color: Cores.cinzaMedio,
                                              size: 40),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 10),
                          carregando || sorteado
                              ? const SizedBox()
                              : CupertinoButton(
                                  color: Cores.verdeMedio,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                  onPressed: () {
                                    sortear();
                                  },
                                  child: const Text("Sortear"),
                                )
                        ],
                      ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(10),
                //     child: Column(
                //       mainAxisAlignment: sorteado
                //           ? MainAxisAlignment.center
                //           : MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           texto,
                //           style: const TextStyle(
                //             color: Cores.branco,
                //             fontSize: 20,
                //           ),
                //         ),
                //         sorteado
                //             ? const Text(
                //                 "Fulano de Tal",
                //                 style: TextStyle(
                //                   color: Cores.branco,
                //                   fontSize: 30,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               )
                //             : Padding(
                //                 padding: const EdgeInsets.only(bottom: 20),
                //                 child: LoadingAnimationWidget.inkDrop(
                //                   color: Cores.branco,
                //                   size: 200,
                //                 ),
                //               ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

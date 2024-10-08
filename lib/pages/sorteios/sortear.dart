import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../classes/classes.dart';

class Sortear extends StatefulWidget {
  const Sortear({super.key});

  @override
  State<Sortear> createState() => _SortearState();
}

class _SortearState extends State<Sortear> {
  String texto = 'Sorteando...';

  bool sorteado = false;

  double largura = 300;
  double altura = 350;

  Color corBackground = Cores.branco;

  final busca = TextEditingController();

  // final ConfettiController confettiController = ConfettiController();

  double randomInRange(double min, double max) {
    return min + Random().nextDouble() * (max - min);
  }

  sortear() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        texto = 'Temos um vencedor!';
      });
    }).then((value) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          texto = 'Parabéns';
          sorteado = true;
          largura = 350;
          altura = 150;
          corBackground = Cores.verdeMedio;
        });

        int total = 60;
        int progress = 0;

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
      });
    });
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
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              sorteado ? Navigator.pop(context) : null;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              width: largura,
              height: altura,
              decoration: BoxDecoration(
                color: corBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              placeholder: 'Pesquisar',
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
    );
  }
}

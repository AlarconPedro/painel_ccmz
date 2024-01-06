import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';

import '../../../classes/classes.dart';

class CardEventoQuarto extends StatefulWidget {
  QuartoModel quarto;
  // PessoaModel pessoa;

  CardEventoQuarto({
    super.key,
    required this.quarto,
    // required this.pessoa,
  });

  @override
  State<CardEventoQuarto> createState() => _CardEventoQuartoState();
}

class _CardEventoQuartoState extends State<CardEventoQuarto> {
  List<Widget> alocacaoQuarto = [];

  int quantidadeCamasOcupadas = 0;

  criarVagas() async {
    await alimentarCamasOcupadas();
    await alimentarCamasVazias();
  }

  alimentarCamasOcupadas() {
    for (var i = 0; i < widget.quarto.pessoas.length; i++) {
      alocacaoQuarto.add(
        Row(
          children: [
            Icon(
              widget.quarto.pessoas[i].pesGenero == "F"
                  ? Icons.female_rounded
                  : Icons.male_rounded,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                // quarto.quaNome,
                widget.quarto.pessoas[i].pesNome,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
      quantidadeCamasOcupadas++;
    }
  }

  alimentarCamasVazias() {
    for (var i = 0;
        i < widget.quarto.quaQtdCamas - quantidadeCamasOcupadas;
        i++) {
      alocacaoQuarto.add(
        const Row(
          children: [
            Icon(CupertinoIcons.person),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Vazio",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    criarVagas();
  }

  @override
  Widget build(BuildContext context) {
    int quatidadeCamas = widget.quarto.quaQtdCamas;
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color: Cores.branco,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          // color: Cores.amareloClaro.withOpacity(0.2),
          color: Cores.branco,
        ),
        width: 300,
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    widget.quarto.quaNome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  ...alocacaoQuarto,
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: quarto.quaQtdCamas,
                  //     itemBuilder: (context, index) {
                  //       return const Row(
                  //         children: [
                  //           Icon(CupertinoIcons.person),
                  //           SizedBox(width: 10),
                  //           Expanded(
                  //             child: Text(
                  //               // quarto.quaNome,
                  //               "Vazio",
                  //               overflow: TextOverflow.ellipsis,
                  //               style: TextStyle(
                  //                 fontSize: 14,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vagas: ${widget.quarto.quaQtdCamaslivres}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

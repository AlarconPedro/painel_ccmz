import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';
import '../../../data/data.dart';

class CardQuartoAlocacao extends StatelessWidget {
  QuartoPessoasModel quarto;
  CardQuartoAlocacao({super.key, required this.quarto});

  carregarPessoas(CheckinModel pessoaChekin) {
    return Row(children: [
      const Icon(CupertinoIcons.person),
      const SizedBox(width: 10),
      Expanded(
        child: Text(
          pessoaChekin.pesNome,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      pessoaChekin.pesCheckin
          ? const Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: Cores.verdeMedio,
            )
          : pessoaChekin.pesNaovem
              ? const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Cores.vermelhoMedio,
                )
              : const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Cores.cinzaMedio,
                ),
      const SizedBox(width: 10),
      pessoaChekin.pesChave
          ? const Icon(
              Icons.vpn_key_rounded,
              color: Cores.amareloMedio,
            )
          : const SizedBox(width: 24),
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
            color: Cores.branco
            // color: quarto.vagas < 1
            //     ? Cores.vermelhoMedio.withOpacity(0.2)
            //     : quarto.vagas < 2
            //         ? Cores.amareloClaro.withOpacity(0.2)
            //         : Cores.branco,
            ),
        width: 290,
        height: 220,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: Text(
                    quarto.quaNome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(
                    quarto.bloNome,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      for (var pessoa in quarto.pessoasQuarto)
                        carregarPessoas(pessoa),
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
                      "Vagas:${quarto.vagas}",
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

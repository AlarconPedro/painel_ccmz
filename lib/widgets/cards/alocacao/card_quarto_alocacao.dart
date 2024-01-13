import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/models/quarto_pessoas_model.dart';

import '../../../classes/classes.dart';
import '../../../data/models/checkin_model.dart';

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
              CupertinoIcons.check_mark_circled,
              color: Cores.verdeMedio,
            )
          : const Icon(
              CupertinoIcons.xmark_circle,
              color: Cores.cinzaMedio,
            ),
      const SizedBox(width: 5),
      pessoaChekin.pesChave
          ? const Icon(
              Icons.vpn_key_rounded,
              color: Cores.amareloMedio,
            )
          : const SizedBox(width: 29),
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
                    quarto.quaNome,
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
                  for (var pessoa in quarto.pessoasQuarto)
                    carregarPessoas(pessoa),
                ],
              ),
            )),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vagas: 2",
                      style: TextStyle(
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

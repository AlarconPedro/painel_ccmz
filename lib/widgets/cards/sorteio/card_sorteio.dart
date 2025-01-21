import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/funcoes/funcoes.dart';

import '../../../classes/classes.dart';
import '../../../data/models/web/sorteios_model.dart';

Widget cardSorteio({
  required BuildContext context,
  required SorteiosModel sorteio,
  required bool sorteado,
  required Function() onTap,
}) {
  return Container(
    color: Colors.transparent,
    child: Row(
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Cores.branco),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.gift),
                    const SizedBox(width: 10),
                    Expanded(flex: 1, child: Text(sorteio.preNome)),
                    Expanded(flex: 2, child: Text(sorteio.parNome)),
                    Expanded(child: Text(sorteio.cupNumero)),
                    Expanded(
                        flex: 2,
                        child:
                            Text(FuncoesData.dataFormatada(sorteio.sorData))),
                    const SizedBox(width: 30),
                    // const Icon(CupertinoIcons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ),
        AbsorbPointer(
          absorbing: sorteio.parNome.isNotEmpty,
          child: Card(
            color: Cores.branco,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: IconButton(
                icon: Icon(
                  size: sorteio.parNome.isEmpty ? 30 : 25,
                  sorteio.parNome.isEmpty
                      // Confetti icon
                      ? Icons.celebration_rounded
                      : CupertinoIcons.gift,
                  color: sorteio.parNome.isEmpty
                      ? Cores.verdeMedio
                      : Cores.cinzaMedio,
                ),
                onPressed: onTap,
              ),
            ),
          ),
        ),
      ],
    ),
  );
  // return Card(
  //   child: InkWell(
  //     onTap: onTap,
  //     child: Column(
  //       children: [
  //         Image.network(
  //           imagem,
  //           fit: BoxFit.cover,
  //           width: double.infinity,
  //           height: 200,
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 titulo,
  //                 style: const TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               Text(
  //                 descricao,
  //                 style: const TextStyle(
  //                   fontSize: 16,
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   const Icon(Icons.calendar_today),
  //                   const SizedBox(width: 5),
  //                   Text(data),
  //                   const SizedBox(width: 10),
  //                   const Icon(Icons.access_time),
  //                   const SizedBox(width: 5),
  //                   Text(hora),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   const Icon(Icons.location_on),
  //                   const SizedBox(width: 5),
  //                   Text(local),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}

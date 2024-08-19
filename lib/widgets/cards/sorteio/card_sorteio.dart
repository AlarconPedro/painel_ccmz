import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/models/sorteios_model.dart';

import '../../../classes/classes.dart';
import '../../../funcoes/funcoes.dart';

Widget cardSorteio({
  required BuildContext context,
  required SorteiosModel sorteio,
  required Function() onTap,
}) {
  return Container(
    color: Colors.transparent,
    child: Row(
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Cores.branco,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.gift),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(sorteio.sorNome),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        sorteio.sorNomeGanhador,
                        // FuncoesData.dataFormatada(sorteio.sorData),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        sorteio.sorData,
                        // FuncoesData.dataFormatada(sorteio.sorData),
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Icon(CupertinoIcons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          child: CupertinoButton(
            child: const Icon(
              CupertinoIcons.person_2_fill,
              color: Cores.preto,
            ),
            onPressed: () {},
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          child: CupertinoButton(
            child: const Icon(
              CupertinoIcons.tags,
              color: Cores.preto,
            ),
            onPressed: () {},
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

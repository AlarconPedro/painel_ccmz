import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';
import '../../../data/models/web/promocoes_model.dart';

Widget cardPromocao({
  required PromocoesModel promocao,
  required Function() onTap,
  required Function() abrirCupons,
  required Function() abrirParticipantes,
  required Function() abrirPremios,
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
                    const Icon(CupertinoIcons.tag),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 2,
                      child: Text(promocao.proNome),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        promocao.proDataInicio,
                        // FuncoesData.dataFormatada(sorteio.sorData),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        promocao.proDataFim,
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
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.gift,
                color: Cores.preto,
              ),
              onPressed: () {
                abrirPremios();
              },
            ),
          ),
        ),
        Card(
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
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.person_2_fill,
                color: Cores.preto,
              ),
              onPressed: () {
                abrirParticipantes();
              },
            ),
          ),
        ),
        Card(
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
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.tickets,
                color: Cores.preto,
              ),
              onPressed: () {
                abrirCupons();
              },
            ),
          ),
        ),
      ],
    ),
  );
}

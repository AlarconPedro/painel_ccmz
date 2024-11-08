import 'package:flutter/material.dart';
import 'package:painel_ccmn/widgets/cards/btn_opcoes_card.dart';

import '../../../classes/cores.dart';

class CardBaseListagem extends StatelessWidget {
  List<BtnOpcoesCard> btnsOpcoes;
  Row camposCard;
  CardBaseListagem(
      {super.key, required this.btnsOpcoes, required this.camposCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Cores.branco),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: camposCard)))),
          ...btnsOpcoes
        ],
      ),
    );
  }
}

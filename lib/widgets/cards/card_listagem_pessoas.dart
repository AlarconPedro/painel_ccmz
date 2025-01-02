import 'package:flutter/material.dart';
import 'package:painel_ccmn/widgets/cards/base/card_base_listagem.dart';

import 'btn_opcoes_card.dart';

class CardListagemPessoas extends CardBaseListagem {
  CardListagemPessoas({
    super.key,
    required List<BtnOpcoesCard> btnsOpcoes,
    required BuildContext context,
    required Row camposCard,
    required IconData icone,
  }) : super(btnsOpcoes: btnsOpcoes, camposCard: camposCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return super.build(context);
  }
}

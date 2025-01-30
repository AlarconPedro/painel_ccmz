import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/servicos_model.dart';
import 'package:painel_ccmn/widgets/cards/btn_opcoes_card.dart';
import 'package:painel_ccmn/widgets/cards/card_listagem_base.dart';
import 'package:painel_ccmn/widgets/dialogs/delete_dialog.dart';

import '../../../classes/classes.dart';

Widget cardServicos({
  Color? cor,
  required BuildContext context,
  required ServicosModel servicos,
  required Function() excluir,
}) {
  return cardListagemBase(
    cor: cor,
    actions: [
      BtnOpcoesCard(
          dialog: () => deleteDialog(
              context: context,
              excluir: () => excluir(),
              titulo: "Excluir Serviço",
              mensagem: "Deseja excluir o serviço?"),
          icone: CupertinoIcons.trash,
          cor: Cores.vermelhoMedio),
    ],
    campos: [
      const Icon(CupertinoIcons.wrench),
      const SizedBox(width: 10),
      Expanded(flex: 4, child: Text(servicos.serNome)),
      const SizedBox(width: 30),
      const Icon(CupertinoIcons.chevron_right),
    ],
  );
}

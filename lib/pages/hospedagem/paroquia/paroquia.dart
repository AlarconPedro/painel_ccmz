import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/paroquia_model.dart';
import 'package:painel_ccmn/pages/hospedagem/paroquia/cadastro_paroquia.dart';
import 'package:painel_ccmn/widgets/cards/base/card_base_listagem.dart';
import 'package:painel_ccmn/widgets/cards/btn_opcoes_card.dart';
import 'package:painel_ccmn/widgets/dialogs/delete_dialog.dart';
import 'package:painel_ccmn/widgets/telas/modelo_listagem_cadastro.dart';

import '../../../classes/classes.dart';
import '../../../data/api/hospedagem/api_paroquia.dart';
import '../../../widgets/textos/textos.dart';

class Paroquia extends StatefulWidget {
  const Paroquia({super.key});

  @override
  State<Paroquia> createState() => _ParoquiaState();
}

class _ParoquiaState extends State<Paroquia> {
  TextEditingController ctlrBusca = TextEditingController();

  bool carregando = false;

  List<ParoquiaModel> listaParoquias = [];

  buscarParoquias() async {
    setState(() => carregando = true);
    var retorno = await ApiParoquia().buscarParoquias();
    if (retorno.statusCode == 200) {
      var dados = json.decode(retorno.body);
      listaParoquias =
          dados.map<ParoquiaModel>((e) => ParoquiaModel.fromJson(e)).toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao carregar as Paróquias!"),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarParoquias();
  }

  @override
  Widget build(BuildContext context) {
    return modeloListagemCadastro(
      fncBusca: () => {},
      fncAbrirCadastro: () => {
        Navigator.push(
          context,
          CupertinoDialogRoute(
              builder: (context) => const CadastroParoquia(), context: context),
        )
      },
      ctlrBusca: ctlrBusca,
      listaDados: listaParoquias,
      cardListagem: (dados) => CardBaseListagem(
        btnsOpcoes: [
          BtnOpcoesCard(
            dialog: () => deleteDialog(
                context: context,
                excluir: () => {},
                titulo: 'Excluir Paróquia',
                mensagem: 'Deseja realmente excluir a Paróquia?'),
            icone: CupertinoIcons.delete,
            cor: Cores.vermelhoMedio,
          )
        ],
        camposCard: Row(
          children: [
            const SizedBox(width: 30),
            Textos.textoPequeno(texto: dados.prqNome),
            const Spacer(),
            Textos.textoPequeno(texto: dados.prqCidade),
            const Spacer(),
            Textos.textoPequeno(texto: dados.prqParoquia),
            const Spacer(),
          ],
        ),
      ),
      tituloColunas: Row(
        children: [
          const SizedBox(width: 30),
          Textos.textoPequeno(texto: 'Nome'),
          const Spacer(),
          Textos.textoPequeno(texto: 'Cidade'),
          const Spacer(),
          Textos.textoPequeno(texto: 'Paróquia'),
          const Spacer(),
          Textos.textoPequeno(texto: 'Excluir'),
          const SizedBox(width: 30),
        ],
      ),
      titulo: "Paróquias",
      btnTitulo: "Nova Paróquia",
      carregando: carregando,
      context: context,
    );
  }
}

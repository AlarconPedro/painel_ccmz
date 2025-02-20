import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/api/hospedagem/api_paroquia.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/paroquia_model.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/form/campo_texto.dart';

class CadastroParoquia extends StatefulWidget {
  const CadastroParoquia({super.key});

  @override
  State<CadastroParoquia> createState() => _CadastroParoquiaState();
}

class _CadastroParoquiaState extends State<CadastroParoquia> {
  TextEditingController ctlrNome = TextEditingController();
  TextEditingController ctlrCidade = TextEditingController();

  bool carregando = false;

  ParoquiaModel preparaDados() {
    return ParoquiaModel(
      prqCodigo: 0,
      prqNome: ctlrNome.text,
      prqCidade: ctlrCidade.text,
    );
  }

  adicionarParoquia() async {
    setState(() => carregando = true);
    var retorno = await ApiParoquia().gravarParoquia(preparaDados().toJson());
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paróquia cadastrada com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao cadastrar a Paróquia!"),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => carregando = false);
    // ParoquiaModel paroquia = preparaDados();
    // print(paroquia.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      largura: 2.5,
      altura: 3,
      formKey: GlobalKey<FormState>(),
      campos: [
        campoTexto(
          titulo: "Nome",
          dica: "Nome da Paróquia",
          icone: Icons.church_rounded,
          temMascara: false,
          mascara: MaskTextInputFormatter(
              mask: "", filter: {"": RegExp(r'[a-zA-Z]')}),
          validador: (String) {},
          controlador: ctlrNome,
        ),
        campoTexto(
          titulo: "Cidade",
          dica: "Cidade da Paróquia",
          icone: CupertinoIcons.location_solid,
          temMascara: false,
          mascara: MaskTextInputFormatter(
              mask: "", filter: {"": RegExp(r'[a-zA-Z]')}),
          validador: (String) {},
          controlador: ctlrCidade,
        ),
      ],
      titulo: "Cadastro de Paróquia",
      gravar: () => adicionarParoquia(),
      cancelar: () => Navigator.pop(context),
    );
  }
}

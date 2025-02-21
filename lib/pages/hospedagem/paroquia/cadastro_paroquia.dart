import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/api/hospedagem/api_paroquia.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/paroquia_model.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/form/campo_texto.dart';

import '../../../classes/classes.dart';

class CadastroParoquia extends StatefulWidget {
  ParoquiaModel? paroquia;
  CadastroParoquia({super.key, this.paroquia});

  @override
  State<CadastroParoquia> createState() => _CadastroParoquiaState();
}

class _CadastroParoquiaState extends State<CadastroParoquia> {
  TextEditingController ctlrNome = TextEditingController();
  TextEditingController ctlrCidade = TextEditingController();
  TextEditingController ctlrUF = TextEditingController();
  int ctlrCodigo = 0;

  bool carregando = false;

  ParoquiaModel preparaDados() {
    if (widget.paroquia != null) {
      return ParoquiaModel(
        prqCodigo: widget.paroquia!.prqCodigo,
        prqNome: ctlrNome.text,
        prqCidade: ctlrCidade.text,
        prqUF: ctlrUF.text,
      );
    }
    return ParoquiaModel(
      prqCodigo: 0,
      prqNome: ctlrNome.text,
      prqCidade: ctlrCidade.text,
      prqUF: ctlrUF.text,
    );
  }

  adicionarParoquia() async {
    setState(() => carregando = true);
    var retorno = await ApiParoquia().gravarParoquia(preparaDados().toJson());
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paróquia cadastrada com sucesso!"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
      Navigator.pop(context);
    } else if (retorno.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paróquia já Cadastrada!"),
          backgroundColor: Cores.amareloEscuro,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao cadastrar a Paróquia!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
    // ParoquiaModel paroquia = preparaDados();
    // print(paroquia.toJson());
  }

  updateParoquia() async {
    setState(() => carregando = true);
    var retorno =
        await ApiParoquia().atualizarParoquia(preparaDados().toJson());
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paróquia atualizada com sucesso!"),
          backgroundColor: Cores.verdeMedio,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao atualizar a Paróquia!"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    if (widget.paroquia != null) {
      ctlrCodigo = widget.paroquia!.prqCodigo;
      ctlrNome.text = widget.paroquia!.prqNome;
      ctlrCidade.text = widget.paroquia!.prqCidade;
      ctlrUF.text = widget.paroquia!.prqUF;
    }
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
        Row(
          children: [
            Expanded(
              child: campoTexto(
                titulo: "Cidade",
                dica: "Cidade da Paróquia",
                icone: CupertinoIcons.location_solid,
                temMascara: false,
                maxLength: 50,
                mascara: MaskTextInputFormatter(
                    mask: "", filter: {"": RegExp(r'[a-zA-Z]')}),
                validador: (dados) {},
                controlador: ctlrCidade,
              ),
            ),
            //Criar mascara q transforma tudo em maiusculo e limita a 2 caracteres
            Expanded(
              child: campoTexto(
                titulo: "UF",
                dica: "UF da Paróquia",
                icone: CupertinoIcons.location_solid,
                temMascara: false,
                maxLength: 2,
                //mascara somente para letras
                tipo: TextInputType.text,
                mascara: MaskTextInputFormatter(
                    mask: "", filter: {"": RegExp(r'[a-zA-Z]')}),
                // mask: "AA",
                // filter: {"": RegExp('[a-zA-Z]')}),
                // mascara: MaskTextInputFormatter(
                //     mask: "##", filter: {"##": RegExp(r'[a-zA-Z]')}),
                validador: (dados) {
                  if (dados.length != 2) {
                    return "UF inválida!";
                  } else {
                    ctlrUF.text = ctlrUF.text.toUpperCase();
                  }
                },
                controlador: ctlrUF,
              ),
            ),
          ],
        ),
      ],
      titulo: "Cadastro de Paróquia",
      gravar: () =>
          widget.paroquia != null ? updateParoquia() : adicionarParoquia(),
      cancelar: () => Navigator.pop(context),
    );
  }
}

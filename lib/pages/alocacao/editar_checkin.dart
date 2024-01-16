import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/pages/esqueleto/cadastro_form.dart';

import '../../data/models/checkin_model.dart';
import '../../data/models/quarto_pessoas_model.dart';

class EditarCheckin extends StatefulWidget {
  QuartoPessoasModel dadosQuarto;

  EditarCheckin({
    super.key,
    required this.dadosQuarto,
  });

  @override
  State<EditarCheckin> createState() => Editar_CheckinState();
}

class Editar_CheckinState extends State<EditarCheckin> {
  final formKey = GlobalKey<FormState>();

  bool checkin = false;

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: formKey,
      campos: [
        for (var pessoas in widget.dadosQuarto.pessoasQuarto)
          campoPessoa(pessoas),
      ],
      titulo: "Checkin",
      gravar: () {},
      cancelar: () {},
    );
  }

  campoPessoa(CheckinModel pessoa) {
    return Row(
      children: [
        const Icon(Icons.person),
        const SizedBox(width: 10),
        Expanded(child: Text(pessoa.pesNome)),
        const SizedBox(width: 10),
        CupertinoCheckbox(
            value: pessoa.pesCheckin,
            onChanged: (value) {
              setState(() {
                pessoa.pesCheckin = value!;
              });
            }),
        CupertinoCheckbox(value: pessoa.pesChave, onChanged: (value) {})
      ],
    );
  }
}

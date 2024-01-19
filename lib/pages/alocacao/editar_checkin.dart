import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/models/quarto_pessoas_model.dart';
import 'package:painel_ccmz/pages/pages.dart';

import '../../classes/classes.dart';
import '../../data/models/checkin_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      titulo: "Checkin",
      altura: 3.5,
      largura: 2,
      gravar: () {},
      cancelar: () {
        for (var element in widget.dadosQuarto.pessoasQuarto) {
          setState(() {
            element.pesCheckin = false;
          });
        }
      },
      formKey: GlobalKey<FormState>(),
      campos: [
        for (var pessoas in widget.dadosQuarto.pessoasQuarto)
          campoPessoa(pessoas),
      ],
    );
  }

  campoPessoa(CheckinModel pessoa) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      child: Expanded(
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Text(pessoa.pesNome),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  const Text(
                    "Compareceu:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                      value: pessoa.pesCheckin,
                      onChanged: (value) {
                        setState(() {
                          pessoa.pesCheckin = value!;
                        });
                      }),
                  const Text(
                    "Chave:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                    value: pessoa.pesChave,
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/models/quarto_pessoas_model.dart';

import '../../classes/classes.dart';
import '../../data/models/checkin_model.dart';

class EditarCheckin extends StatefulWidget {
  QuartoPessoasModel dadosQuarto;

  EditarCheckin({super.key, required this.dadosQuarto});

  @override
  State<EditarCheckin> createState() => Editar_CheckinState();
}

class Editar_CheckinState extends State<EditarCheckin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Cores.branco,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: [
                  for (var pessoas in widget.dadosQuarto.pessoasQuarto)
                    campoPessoa(pessoas),
                ],
              ),
            ),
          ),
        ),
      ),
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

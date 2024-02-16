import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/data/models/quarto_pessoas_model.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../classes/classes.dart';
import '../../data/models/checkin_model.dart';

class EditarCheckin extends StatefulWidget {
  QuartoPessoasModel dadosQuarto;

  Function() refresh;

  EditarCheckin({
    super.key,
    required this.dadosQuarto,
    required this.refresh,
  });

  @override
  State<EditarCheckin> createState() => Editar_CheckinState();
}

class Editar_CheckinState extends State<EditarCheckin> {
  bool carregando = false;

  CheckinModel preparaDados(CheckinModel checkin) {
    return CheckinModel(
      qupCodigo: checkin.qupCodigo,
      pesCodigo: checkin.pesCodigo,
      quaCodigo: checkin.quaCodigo,
      pesChave: checkin.pesChave,
      pesCheckin: checkin.pesCheckin,
      pesNome: checkin.pesNome,
    );
  }

  editarCheckin(CheckinModel checkin) async {
    setState(() => carregando = true);
    var retorno = await ApiCheckin().updateCheckin(preparaDados(checkin));
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeMedio,
          content: Text("Checkin efetuado com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao editar checkin !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      titulo: "Checkin",
      altura: 2.8,
      largura: 2.7,
      gravar: () {
        // for (var element in widget.dadosQuarto.pessoasQuarto) {
        //   setState(() {
        //     element.pesCheckin = true;
        //   });
        // }
        Navigator.pop(context);
      },
      cancelar: () {
        for (var element in widget.dadosQuarto.pessoasQuarto) {
          setState(() {
            element.pesCheckin = false;
          });
        }
      },
      formKey: GlobalKey<FormState>(),
      campos: carregando
          ? [
              const Expanded(
                child: Center(
                  child: CarregamentoIOS(),
                ),
              )
            ]
          : [
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
                      onChanged: (value) async {
                        pessoa.pesCheckin = value!;
                        var retorno = await editarCheckin(pessoa);
                        if (retorno.statusCode == 200) {
                          setState(() => pessoa.pesCheckin = value);
                        }
                        widget.refresh();
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
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

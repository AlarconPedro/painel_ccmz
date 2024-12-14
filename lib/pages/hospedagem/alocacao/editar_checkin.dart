import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../../classes/classes.dart';

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
      eveCodigo: checkin.eveCodigo,
      pesChave: checkin.pesChave,
      pesCheckin: checkin.pesCheckin,
      pesNaovem: checkin.pesNaovem,
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
              const Center(
                child: CarregamentoIOS(),
              ),
            ]
          : [
              for (var pessoas in widget.dadosQuarto.pessoasQuarto)
                campoPessoa(pessoas),
            ],
    );
  }

  campoPessoa(CheckinModel pessoa) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 10),
                    Text(pessoa.pesNome),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
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
                    onChanged: (value) async {
                      pessoa.pesChave = value!;
                      var retorno = await editarCheckin(pessoa);
                      if (retorno.statusCode == 200) {
                        setState(() {
                          pessoa.pesChave = value;
                        });
                      }
                      widget.refresh();
                    },
                  ),
                  const Text(
                    "Não Vem:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                      value: pessoa.pesNaovem,
                      onChanged: (value) async {
                        pessoa.pesNaovem = value!;
                        var retorno = await editarCheckin(pessoa);
                        if (retorno.statusCode == 200) {
                          setState(() {
                            pessoa.pesNaovem = value;
                          });
                        }
                        widget.refresh();
                      }),
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

import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/form/campo_texto.dart';

class NovoServico extends StatefulWidget {
  const NovoServico({super.key});

  @override
  State<NovoServico> createState() => _NovoServicoState();
}

class _NovoServicoState extends State<NovoServico> {
  TextEditingController nomeServico = TextEditingController();

  bool carregando = false;

  adicionarServico() async {
    setState(() => carregando = true);
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: GlobalKey<FormState>(),
      largura: 2,
      altura: 4,
      titulo: "Novo Serviço",
      campos: [
        Row(
          children: [
            Expanded(
              child: campoTexto(
                  titulo: "Nome Serviço",
                  dica: "Nome do Serviço",
                  icone: CupertinoIcons.wrench,
                  temMascara: false,
                  mascara: MaskTextInputFormatter(
                      mask: "", filter: {"": RegExp(r'[a-zA-Z]')}),
                  validador: (value) {
                    if (value.isEmpty) {
                      return "Nome do Serviço não pode ser vazio";
                    }
                    return null;
                  },
                  controlador: nomeServico),
            )
          ],
        ),
      ],
      gravar: () {},
      cancelar: () {
        Navigator.pop(context);
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/api/financeiro/api_servico.dart';
import 'package:painel_ccmn/data/api/hospedagem/api_evento.dart';
import 'package:painel_ccmn/data/api/hospedagem/api_evento_despesa.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/servicos_model.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/form/campo_texto.dart';
import 'package:painel_ccmn/widgets/snack_notification.dart';

import '../../../classes/classes.dart';

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
    var retorno = await ApiServico()
        .postServico(ServicosModel(serCodigo: 0, serNome: nomeServico.text));
    if (retorno.statusCode == 200) {
      if (mounted) {
        snackNotification(
            context: context, mensage: "Serviço Adicionado com Sucesso !");
      }
    } else {
      if (mounted) {
        snackNotification(
            context: context,
            mensage: "Erro ao Adicionar Serviço !",
            cor: Cores.vermelhoMedio);
      }
    }
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
      gravar: () {
        // if (Form.of(context).validate()) {
        if (nomeServico.text.isNotEmpty) adicionarServico();
        // }
      },
      cancelar: () {
        Navigator.pop(context);
      },
    );
  }
}

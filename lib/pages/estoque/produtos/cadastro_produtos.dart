import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../../widgets/form/campo_texto.dart';

class CadastroProdutos extends StatefulWidget {
  const CadastroProdutos({super.key});

  @override
  State<CadastroProdutos> createState() => _CadastroProdutosState();
}

class _CadastroProdutosState extends State<CadastroProdutos> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: _formKey,
      titulo: "Cadastro de Produtos",
      altura: 2,
      largura: 2.5,
      gravar: () {},
      cancelar: () {},
      campos: [
        campoTexto(
          controlador: nomeController,
          titulo: "Nome",
          dica: "Nome do Produto",
          icone: CupertinoIcons.tag,
          validador: (value) {
            if (value.isEmpty) {
              return "Campo Obrigatório";
            }
            return null;
          },
        ),
        campoTexto(
          controlador: descricaoController,
          titulo: "Descrição",
          dica: "Descrição do Produto",
          icone: CupertinoIcons.text_badge_checkmark,
          validador: (value) {
            if (value.isEmpty) {
              return "Campo Obrigatório";
            }
            return null;
          },
        ),
        campoTexto(
          controlador: descricaoController,
          titulo: "Quantidade",
          dica: "Quantidade do Produto",
          icone: CupertinoIcons.number,
          validador: (value) {
            if (value.isEmpty) {
              return "Campo Obrigatório";
            }
            return null;
          },
        ),
        // CampoNumero(
        //   titulo: "Quantidade",
        //   dica: "Quantidade do Produto",
        //   icone: CupertinoIcons.number,
        //   validador: (value) {
        //     if (value.isEmpty) {
        //       return "Campo Obrigatório";
        //     }
        //     return null;
        //   },
        // ),
        // CampoNumero(
        //   titulo: "Valor",
        //   dica: "Valor do Produto",
        //   icone: CupertinoIcons.money_dollar,
        //   validador: (value) {
        //     if (value.isEmpty) {
        //       return "Campo Obrigatório";
        //     }
        //     return null;
        //   },
        // ),
      ],
    );
  }
}

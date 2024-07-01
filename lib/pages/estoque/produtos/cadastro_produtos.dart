import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/pages.dart';

class CadastroProdutos extends StatefulWidget {
  const CadastroProdutos({super.key});

  @override
  State<CadastroProdutos> createState() => _CadastroProdutosState();
}

class _CadastroProdutosState extends State<CadastroProdutos> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: _formKey,
      titulo: "Cadastro de Produtos",
      altura: 4,
      largura: 2.5,
      gravar: () {},
      cancelar: () {},
      campos: [],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/pages.dart';

class CadastroCategorias extends StatefulWidget {
  const CadastroCategorias({super.key});

  @override
  State<CadastroCategorias> createState() => _CadastroCategoriasState();
}

class _CadastroCategoriasState extends State<CadastroCategorias> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      titulo: "Cadastro de Categorias",
      formKey: _formKey,
      altura: 4,
      largura: 2.5,
      cancelar: () {
        // Navigator.pop(context);
      },
      gravar: () {
        Navigator.pop(context);
      },
      campos: [],
    );
  }
}

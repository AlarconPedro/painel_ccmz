import 'package:flutter/material.dart';

import '../pages.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      largura: 2,
      altura: 4.5,
      cancelar: () {
        Navigator.pop(context);
      },
      gravar: () {
        Navigator.pop(context);
      },
      titulo: "Cadastro de usuário",
      formKey: _formKey,
      campos: [
        Row(),
      ],
    );
  }
}

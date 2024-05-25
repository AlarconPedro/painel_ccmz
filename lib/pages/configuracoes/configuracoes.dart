import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages.dart';
import 'cadastro_usuario.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Usuário",
      tituloPagina: "Configurações",
      abrirTelaCadastro: () {
        Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => const CadastroUsuario(),
            context: context,
          ),
        );
      },
      corpo: const [
        Text("Configurações"),
      ],
      buscaNome: (value) {},
    );
  }
}

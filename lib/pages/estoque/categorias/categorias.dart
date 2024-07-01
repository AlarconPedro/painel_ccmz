import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/pages.dart';

class Categorias extends StatefulWidget {
  const Categorias({super.key});

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      label: "Categorias",
      tituloBoto: "Nova Categoria",
      tituloPagina: "Categorias",
      filtro: false,
      buscaNome: (busca) {},
      abrirTelaCadastro: () {
        Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => const CadastroCategorias(),
            context: context,
          ),
        );
      },
      corpo: [],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/esqueleto.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Produto",
      tituloPagina: "Produtos",
      buscaNome: (busca) {},
      abrirTelaCadastro: () {
        // Navigator.push(
        //   context,
        //   CupertinoDialogRoute(
        //     builder: (context) => const CadastroProdutos(),
        //     context: context,
        //   ),
        // );
      },
      corpo: [],
    );
  }
}

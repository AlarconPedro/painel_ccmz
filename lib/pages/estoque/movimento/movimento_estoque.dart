import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/esqueleto.dart';

import '../../../widgets/widgets.dart';

class MovimentoEstoque extends StatefulWidget {
  const MovimentoEstoque({super.key});

  @override
  State<MovimentoEstoque> createState() => _MovimentoEstoqueState();
}

class _MovimentoEstoqueState extends State<MovimentoEstoque> {
  bool carregando = false;

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Movimento",
      tituloPagina: "Movimento de Estoque",
      buscaNome: (busca) {},
      abrirTelaCadastro: () {
        // Navigator.push(
        //   context,
        //   CupertinoDialogRoute(
        //     builder: (context) => const CadastroMovimentoEstoque(),
        //     context: context,
        //   ),
        // );
      },
      corpo: [
        carregando
            ? const Expanded(
                child: Center(
                  child: CarregamentoIOS(),
                ),
              )
            : const Expanded(
                child: Center(
                  child: Text("Movimento de Estoque"),
                ),
              ),
      ],
    );
  }
}

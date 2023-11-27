import 'package:flutter/cupertino.dart';
import 'package:painel_ccmz/estrutura/estrutura.dart';

class PageControl extends StatefulWidget {
  const PageControl({super.key});

  @override
  State<PageControl> createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: Rotas.navController,
      children: [
        // const DashBoard(),
        // const OrdemServico(),
        // const Clientes(),
        // const Produtos(),
        Container(
          color: CupertinoColors.systemBlue,
        ),
        Container(
          color: CupertinoColors.systemRed,
        ),
        Container(
          color: CupertinoColors.systemGreen,
        ),
      ],
    );
  }
}

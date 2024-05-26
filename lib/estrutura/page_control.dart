import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/classes/classes.dart';
import 'package:painel_ccmn/estrutura/estrutura.dart';
import 'package:painel_ccmn/pages/pages.dart';

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
      physics: const NeverScrollableScrollPhysics(),
      children: Globais.isAdmin
          ? [
              const DashBoard(),
              const Pessoas(),
              const Comunidade(),
              const Bloco(),
              const Quartos(),
              const Evento(),
              const Alocacao(),
              const Usuarios(),
            ]
          : [
              const DashBoard(),
              const Pessoas(),
              const Comunidade(),
              const Bloco(),
              const Quartos(),
              const Evento(),
              const Alocacao(),
              // const DashBoard(),
              // const OrdemServico(),
              // const Clientes(),
              // const Produtos(),
              // Container(
              //   color: CupertinoColors.systemBlue,
              // ),
              // Container(
              //   color: CupertinoColors.systemGreen,'
              // ),
              // Container(
              //   color: CupertinoColors.systemYellow,
              // ),
            ],
    );
  }
}

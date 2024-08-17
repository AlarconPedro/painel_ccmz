import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/classes/classes.dart';
import 'package:painel_ccmn/estrutura/estrutura.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../pages/admin/formularios.dart';
import '../pages/admin/sorteios/sorteios.dart';

class PageControl extends StatefulWidget {
  const PageControl({super.key});

  @override
  State<PageControl> createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {
  List<Widget> retornaMenus() {
    switch (Globais.moduloLogado) {
      case 'Hospedagem':
        {
          return [
            const DashBoard(),
            const Pessoas(),
            const Comunidade(),
            const Bloco(),
            const Quartos(),
            const Evento(),
            const Alocacao(),
          ];
        }
      case 'Estoque':
        {
          return [
            const Produtos(),
            const MovimentoEstoque(),
            const Categorias(),
          ];
        }
      case 'Financeiro':
        {
          return [
            const DashBoard(),
            const Pessoas(),
            const Comunidade(),
            const Bloco(),
            const Quartos(),
            const Evento(),
            const Alocacao(),
          ];
        }
      case 'Sorteios':
        {
          return [
            const Sorteios(),
          ];
        }
      case 'Admin':
        {
          return [
            const Usuarios(),
            const Formularios(),
          ];
        }
      default:
        if (Globais.isAdmin) {
          return [
            const Usuarios(),
            const Formularios(),
            const Sorteios(),
          ];
        } else {
          return [
            const DashBoard(),
            const Pessoas(),
            const Comunidade(),
            const Bloco(),
            const Quartos(),
            const Evento(),
            const Alocacao(),
          ];
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: Rotas.navController,
      physics: const NeverScrollableScrollPhysics(),
      children: retornaMenus(),
    );
  }
}

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
  List<Widget> retornaMenus() {
    switch (Globais.moduloLogado) {
      case 'Hospedagem':
        if (Globais.isAdmin) {
          return [
            const DashBoard(),
            const Pessoas(),
            const Comunidade(),
            const Bloco(),
            const Quartos(),
            const Evento(),
            const Alocacao(),
            const Usuarios(),
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
      case 'Estoque':
        if (Globais.isAdmin) {
          return [
            const Produtos(),
            const MovimentoEstoque(),
            const Categorias(),
            // const Usuarios(),
          ];
        } else {
          return [
            const Produtos(),
            const MovimentoEstoque(),
            const Categorias(),
          ];
        }
      case 'Financeiro':
        if (Globais.isAdmin) {
          return [
            const DashBoard(),
            const Pessoas(),
            const Comunidade(),
            const Bloco(),
            const Quartos(),
            const Evento(),
            const Alocacao(),
            const Usuarios(),
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
      default:
        if (Globais.isAdmin) {
          return [
            const DashBoard(),
            const Pessoas(),
            const Comunidade(),
            const Bloco(),
            const Quartos(),
            const Evento(),
            const Alocacao(),
            const Usuarios(),
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

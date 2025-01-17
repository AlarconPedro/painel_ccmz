import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/estrutura/estrutura.dart';
import 'package:painel_ccmn/estrutura/nav/nav_admin.dart';
import 'package:painel_ccmn/estrutura/nav/nav_estoque.dart';
import 'package:painel_ccmn/estrutura/nav/nav_financeiro.dart';
import 'package:painel_ccmn/estrutura/nav/nav_hospedagem.dart';
import 'package:painel_ccmn/estrutura/nav/nav_sorteio.dart';

import '../../classes/classes.dart';

class Nav extends StatefulWidget {
  double widthNav;
  Nav({Key? key, required this.widthNav}) : super(key: key);

  @override
  NavState createState() => NavState();
}

class NavState extends State<Nav> {
  int selectedIndex = 0;
  SideMenuController sideMenu = SideMenuController();

  Color hoverColor = Cores.cinzaClaro;

  int indexProdutos = 3;

  @override
  void initState() {
    sideMenu.addListener((index) {
      Rotas.navController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
    super.initState();
  }

  List<SideMenuItem> gerarMenuLateral() {
    switch (Globais.moduloLogado) {
      case "Hospedagem":
        return navHospedagem();
      case "Estoque":
        return navEstoque();
      case "Financeiro":
        return navFinanceiro();
      case "Sorteios":
        return navSorteios();
      case "Admin":
        return navAdmin();
      default:
        return navAdmin();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<SideMenuItem> items = gerarMenuLateral();
    return SideMenu(
      items: items,
      controller: sideMenu,
      title: Column(
        children: [
          Container(
              width: widget.widthNav,
              height: 100,
              decoration: const BoxDecoration(
                  color: Cores.branco,
                  image: DecorationImage(
                      image: AssetImage("images/logo.png"), fit: BoxFit.cover)),
              margin: const EdgeInsets.only(bottom: 5))
        ],
      ),
      collapseWidth: 56,
      displayModeToggleDuration: const Duration(milliseconds: 200),
      alwaysShowFooter: true,
      showToggle: true,
      footer: Container(
          width: widget.widthNav,
          height: 56,
          color: Cores.branco,
          child: const Center(
              child: Text('Pedro H. Alarcon',
                  style: TextStyle(color: Cores.cinzaEscuro)))),
      style: SideMenuStyle(
        backgroundColor: Cores.branco,
        hoverColor: Cores.cinzaClaro,
        decoration: const BoxDecoration(
            border:
                Border(right: BorderSide(color: Cores.cinzaClaro, width: 1))),
        selectedColor: Cores.cinzaEscuro,
        selectedTitleTextStyle: const TextStyle(color: Cores.branco),
        selectedIconColor: Cores.branco,
        unselectedIconColor: Cores.cinzaEscuro,
        unselectedTitleTextStyle: const TextStyle(color: Cores.cinzaEscuro),
      ),
    );
  }
}

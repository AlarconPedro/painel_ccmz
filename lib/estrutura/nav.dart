import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/estrutura/estrutura.dart';

import '../../classes/cores.dart';
import '../classes/classes.dart';

class Nav extends StatefulWidget {
  double widthNav;
  Nav({
    Key? key,
    required this.widthNav,
  }) : super(key: key);

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
        return [
          SideMenuItem(
            title: 'Dashboard',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.chart_pie_fill),
          ),
          SideMenuItem(
            title: 'Pessoas',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.person),
            // badgeContent: const Text(
            //   '3',
            //   style: TextStyle(color: Colors.white),
            // ),
          ),
          SideMenuItem(
            title: 'Comunidades',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.person_3),
          ),
          SideMenuItem(
            title: 'Bloco',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.building_2_fill),
          ),
          SideMenuItem(
            title: 'Quartos',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.bed_double),
          ),
          SideMenuItem(
            title: 'Eventos',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.calendar),
          ),
          SideMenuItem(
            title: 'Check-In',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            // icon: const Icon(CupertinoIcons.tag_fill),
            icon: const Icon(CupertinoIcons.checkmark_alt_circle),
          ),
        ];
      case "Estoque":
        // return Globais.isAdmin
        //     ?
        return [
          // SideMenuItem(
          //   title: 'Dashboard',
          //   onTap: (index, sideMenu) {
          //     sideMenu.changePage(index);
          //   },
          //   icon: const Icon(CupertinoIcons.chart_pie_fill),
          // ),
          SideMenuItem(
            title: 'Produtos',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.cube_box),
          ),
          SideMenuItem(
            title: 'Movimentos',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.arrow_right_arrow_left),
          ),
          SideMenuItem(
            title: 'Categorias',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.tags),
          ),
          // SideMenuItem(
          //   title: 'Fornecedores',
          //   onTap: (index, sideMenu) {
          //     sideMenu.changePage(index);
          //   },
          //   icon: const Icon(CupertinoIcons.person_2_fill),
          // ),
        ];
      case "Financeiro":
        return [
          SideMenuItem(
            title: 'Dashboard',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.chart_pie_fill),
          ),
          SideMenuItem(
            title: 'Pessoas',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.person),
            // badgeContent: const Text(
            //   '3',
            //   style: TextStyle(color: Colors.white),
            // ),
          ),
          SideMenuItem(
            title: 'Comunidades',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.person_3),
          ),
          SideMenuItem(
            title: 'Bloco',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.building_2_fill),
          ),
          SideMenuItem(
            title: 'Quartos',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.bed_double),
          ),
          SideMenuItem(
            title: 'Eventos',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.calendar),
          ),
          SideMenuItem(
            title: 'Check-In',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            // icon: const Icon(CupertinoIcons.tag_fill),
            icon: const Icon(CupertinoIcons.checkmark_alt_circle),
          ),
        ];
      default:
        return [
          SideMenuItem(
            title: 'Usuários',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.person_2_fill),
          ),
          SideMenuItem(
            title: 'Formulários',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.doc_plaintext),
          ),
          SideMenuItem(
            title: 'Sorteios',
            onTap: (index, sideMenu) {
              sideMenu.changePage(index);
            },
            icon: const Icon(CupertinoIcons.gift),
          )
        ];
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
                image: AssetImage("images/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 5),
          ),
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
          child: Text(
            'Pedro H. Alarcon',
            style: TextStyle(color: Cores.cinzaEscuro),
          ),
        ),
      ),
      style: SideMenuStyle(
        backgroundColor: Cores.branco,
        hoverColor: Cores.cinzaClaro,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Cores.cinzaClaro,
              width: 1,
            ),
          ),
        ),
        selectedColor: Cores.cinzaEscuro,
        selectedTitleTextStyle: const TextStyle(color: Cores.branco),
        selectedIconColor: Cores.branco,
        unselectedIconColor: Cores.cinzaEscuro,
        unselectedTitleTextStyle: const TextStyle(color: Cores.cinzaEscuro),
      ),
    );
  }
}

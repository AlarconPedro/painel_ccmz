import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/estrutura/estrutura.dart';

import '../../classes/cores.dart';

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

  @override
  Widget build(BuildContext context) {
    List<SideMenuItem> items = [
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
      // SideMenuItem(
      //   title: 'Cadastro',

      //   // icon: const Icon(Icons.settings),
      //   builder: (context, displayMode) {
      //     return SideMenuItem(
      //       title: 'Produtos',
      //       onTap: (index, _) {
      //         sideMenu.changePage(index);
      //       },
      //     );
      //     return ExpansionTile(
      //       title: const Text('Cadastro'),
      //       iconColor: Cores.cinzaEscuro,
      //       textColor: Cores.cinzaEscuro,
      //       // leading: const Icon(CupertinoIcons.plus_circle),
      //       children: [
      //         SideMenuItem(
      //           title: 'Produtos',
      //           onTap: (index, sideMenu) {
      //             sideMenu.changePage(index);
      //           },
      //         ),
      //         SideMenuItem(
      //           title: 'Produtos',
      //           onTap: (index, sideMenu) {
      //             sideMenu.changePage(index);
      //           },
      //         ),
      //         SideMenuItem(
      //           title: 'Produtos',
      //           onTap: (index, sideMenu) {
      //             sideMenu.changePage(index);
      //           },
      //         ),
      //       ],
      //     );
      // },
      // ),
    ];

    return SideMenu(
      items: items,
      controller: sideMenu,
      title: Column(
        children: [
          Container(
            width: widget.widthNav,
            height: 100,
            decoration: BoxDecoration(
              color: Cores.branco,
              image: const DecorationImage(
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
        child: Center(
          child: Text(
            'Pedro H. Alarcon',
            style: TextStyle(color: Cores.cinzaEscuro),
          ),
        ),
      ),
      style: SideMenuStyle(
        backgroundColor: Cores.branco,
        hoverColor: Cores.cinzaClaro,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Cores.cinzaClaro,
              width: 1,
            ),
          ),
        ),
        selectedColor: Cores.cinzaEscuro,
        selectedTitleTextStyle: TextStyle(color: Cores.branco),
        selectedIconColor: Cores.branco,
        unselectedIconColor: Cores.cinzaEscuro,
        unselectedTitleTextStyle: TextStyle(color: Cores.cinzaEscuro),
      ),
    );
  }
}

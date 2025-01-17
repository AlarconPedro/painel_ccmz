import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';

List<SideMenuItem> navEstoque() => [
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
      SideMenuItem(
        title: 'Relatórios',
        onTap: (index, sideMenu) {
          sideMenu.changePage(index);
        },
        icon: const Icon(CupertinoIcons.doc_chart),
      ),
    ];

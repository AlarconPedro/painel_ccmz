import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';

List<SideMenuItem> navSorteios() => [
      SideMenuItem(
          title: 'Promoções',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.tag)),
      SideMenuItem(
          title: 'Sorteios',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.gift)),
    ];

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';

List<SideMenuItem> navFinanceiro() {
  return [
    SideMenuItem(
        title: 'Serviços',
        onTap: (index, sideMenu) => sideMenu.changePage(index),
        icon: const Icon(CupertinoIcons.wrench)),
  ];
}

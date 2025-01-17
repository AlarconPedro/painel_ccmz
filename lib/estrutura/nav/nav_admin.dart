import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';

List<SideMenuItem> navAdmin() {
  return [
    SideMenuItem(
      title: 'Usuários',
      onTap: (index, sideMenu) => sideMenu.changePage(index),
      icon: const Icon(CupertinoIcons.person_2_fill),
    ),
    SideMenuItem(
      title: 'Formulários',
      onTap: (index, sideMenu) => sideMenu.changePage(index),
      icon: const Icon(CupertinoIcons.doc_plaintext),
    ),
  ];
}

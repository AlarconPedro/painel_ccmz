import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';

List<SideMenuItem> navHospedagem() => [
      SideMenuItem(
          title: 'Dashboard',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.chart_pie_fill)),
      SideMenuItem(
          title: 'Pessoas',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.person)
          // badgeContent: const Text(
          //   '3',
          //   style: TextStyle(color: Colors.white),
          // ),
          ),
      SideMenuItem(
          title: 'Comunidades',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.person_3)),
      SideMenuItem(
          title: 'Bloco',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.building_2_fill)),
      SideMenuItem(
          title: 'Quartos',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.bed_double)),
      SideMenuItem(
          title: 'Eventos',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          icon: const Icon(CupertinoIcons.calendar)),
      SideMenuItem(
          title: 'Check-In',
          onTap: (index, sideMenu) => sideMenu.changePage(index),
          // icon: const Icon(CupertinoIcons.tag_fill),
          icon: const Icon(CupertinoIcons.checkmark_alt_circle)),
    ];

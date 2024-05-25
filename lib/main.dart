import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:painel_ccmn/estrutura/estrutura_page.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import 'pages/pages.dart';

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      scrollBehavior: ScrollList(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      title: 'Painel CCMN',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      // home: const EstruturaPage(),
    ),
  );
}

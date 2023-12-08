import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:painel_ccmz/estrutura/estrutura_page.dart';
import 'package:painel_ccmz/pages/login/login_page.dart';

void main() {
  runApp(
    MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      title: 'Painel CCMZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginPage(),
      home: EstruturaPage(),
    ),
  );
}

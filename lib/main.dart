import 'package:flutter/material.dart';
import 'package:painel_ccmz/estrutura/estrutura_page.dart';
import 'package:painel_ccmz/pages/login_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Painel CCMZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginPage(),
      home: EstruturaPage(),
    ),
  );
}

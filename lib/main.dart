import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:painel_ccmn/estrutura/estrutura_page.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import 'pages/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBa2-2U7MyULZgTkZECI8v0ZF_VLyv1aas',
      appId: '1:680162896681:android:b249c931904ba00075a538',
      messagingSenderId: '680162896681',
      projectId: 'ccmn-64ac8',
    ),
  );
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

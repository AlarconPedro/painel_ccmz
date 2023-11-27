import 'package:flutter/material.dart';
import 'package:painel_ccmz/estrutura/estrutura.dart';

import '../classes/cores.dart';
import '../pages/pages.dart';

class EstruturaPage extends StatefulWidget {
  const EstruturaPage({super.key});

  @override
  State<EstruturaPage> createState() => _EstruturaPageState();
}

class _EstruturaPageState extends State<EstruturaPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('CCMZ', style: TextStyle(color: Cores.preto)),
        centerTitle: true,
        backgroundColor: Cores.branco,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              icon: Icon(Icons.exit_to_app, color: Cores.preto),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: width,
        height: height - 56,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 15,
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    width: 250,
                    height: height - 56,
                    color: Cores.cinzaEscuro,
                    child: Nav(
                      widthNav: 250,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: width - 250,
              child: const PageControl(),
            ),
          ],
        ),
      ),
    );
  }
}

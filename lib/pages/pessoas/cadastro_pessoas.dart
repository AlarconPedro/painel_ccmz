import 'package:flutter/material.dart';

import '../../classes/cores.dart';

class CadastroPessoas extends StatefulWidget {
  const CadastroPessoas({super.key});

  @override
  State<CadastroPessoas> createState() => _CadastroPessoasState();
}

class _CadastroPessoasState extends State<CadastroPessoas> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Expanded(
            child: Card(
              elevation: 10,
              child: Material(
                color: Cores.branco,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

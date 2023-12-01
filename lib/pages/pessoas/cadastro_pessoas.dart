import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class CadastroPessoas extends StatefulWidget {
  const CadastroPessoas({super.key});

  @override
  State<CadastroPessoas> createState() => _CadastroPessoasState();
}

class _CadastroPessoasState extends State<CadastroPessoas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Cores.branco,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
        ),
      ),
    );
  }
}

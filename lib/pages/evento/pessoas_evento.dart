import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class PessoasEvento extends StatefulWidget {
  const PessoasEvento({super.key});

  @override
  State<PessoasEvento> createState() => _PessoasEventoState();
}

class _PessoasEventoState extends State<PessoasEvento> {
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
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width / 1.5,
              child: const Column(
                children: [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

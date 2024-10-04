import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';

class Relatorios extends StatefulWidget {
  const Relatorios({super.key});

  @override
  State<Relatorios> createState() => _RelatoriosState();
}

class _RelatoriosState extends State<Relatorios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
            color: Cores.branco,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Cores.branco,
              ),
              child: const Center(
                child: Text('Relatórios'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

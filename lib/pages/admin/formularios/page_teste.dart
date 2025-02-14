import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/admin/formularios/formulario_cadastro.dart';

import '../../../classes/classes.dart';
import '../../../estrutura/estrutura.dart';

class PageTeste extends StatefulWidget {
  const PageTeste({super.key});

  @override
  State<PageTeste> createState() => _PageTesteState();
}

class _PageTesteState extends State<PageTeste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const Text("Teste"),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Globais.rotas.addAll({
                    '/formulario': (context) => const FormularioCadastro(),
                    '/estrutura': (context) => const EstruturaPage(),
                  });
                },
                child: const Text("Add Rotas"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/estrutura');
                },
                child: const Text("Ir para Estrutura"),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

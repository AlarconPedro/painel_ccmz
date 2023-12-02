import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class Comunidade extends StatefulWidget {
  const Comunidade({super.key});

  @override
  State<Comunidade> createState() => _ComunidadeState();
}

class _ComunidadeState extends State<Comunidade> {
  List<Comunidade> comunidades = [];

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Nova Comunidade",
      tituloPagina: "Comunidade",
      abrirTelaCadastro: () {
        Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) {
              return const CadastroComunidade();
            },
            context: context,
          ),
        );
      },
      corpo: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Cidade", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("UF", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Qtd. Pessoas",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: comunidades.length,
              itemBuilder: (context, index) {
                return CardComunidade(
                  comunidade: comunidades[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

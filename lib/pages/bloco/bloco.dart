import 'package:flutter/cupertino.dart';
import 'package:painel_ccmz/pages/pages.dart';

class Bloco extends StatefulWidget {
  const Bloco({super.key});

  @override
  State<Bloco> createState() => _BlocoState();
}

class _BlocoState extends State<Bloco> {
  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Bloco",
      tituloPagina: "Blocos",
      abrirTelaCadastro: () {},
      corpo: [
        Container(
          color: CupertinoColors.systemBlue,
        ),
        Container(
          color: CupertinoColors.systemGreen,
        ),
        Container(
          color: CupertinoColors.systemYellow,
        ),
      ],
    );
  }
}

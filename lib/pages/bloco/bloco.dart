import 'package:flutter/cupertino.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../data/data.dart';

class Bloco extends StatefulWidget {
  const Bloco({super.key});

  @override
  State<Bloco> createState() => _BlocoState();
}

class _BlocoState extends State<Bloco> {
  bool carregando = false;

  List<BlocoModel> blocos = [];

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Bloco",
      tituloPagina: "Blocos",
      abrirTelaCadastro: () {},
      corpo: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Qtd. Quartos",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Qtd. Livres",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Qtd. Ocupados",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        carregando
            ? const Expanded(child: Center(child: CarregamentoIOS()))
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: blocos.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {},
                          child: CardBloco(
                            bloco: blocos[index],
                            excluir: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/models/sorteios_model.dart';
import 'package:painel_ccmn/pages/admin/sorteios/sortear.dart';
import 'package:painel_ccmn/pages/pages.dart';

import 'cadastro_sorteios.dart';

class Sorteios extends StatefulWidget {
  const Sorteios({super.key});

  @override
  State<Sorteios> createState() => _SorteiosState();
}

class _SorteiosState extends State<Sorteios> {
  List<SorteiosModel> sorteios = [];

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
        abrirTelaCadastro: () async {
          var retorno = await Navigator.push(
            context,
            CupertinoDialogRoute(
              builder: (context) => CadastroSorteio(),
              context: context,
            ),
          );
          if (retorno != null) {
            setState(() {
              sorteios.add(retorno);
            });
          }
        },
        buscaNome: (value) {},
        tituloBoto: 'Novo Sorteio',
        tituloPagina: 'Sorteios',
        filtro: false,
        itens: [],
        label: 'Sorteios',
        onChange: () {},
        selecionado: 0,
        corpo: [
          Expanded(
            child: ListView.builder(
              // itemCount: sorteios.length,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  // title: Text(sorteios[index].sorNome),
                  title: Text("Sorteio $index"),
                  // subtitle: Text(sorteios[index].sorData),
                  subtitle: Text("Data $index"),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoDialogRoute(
                          builder: (context) => const Sortear(),
                          context: context,
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   CupertinoDialogRoute(
                    //     builder: (context) => CadastroSorteio(
                    //       sorteio: sorteios[index],
                    //     ),
                    //     context: context,
                    //   ),
                    // );
                  },
                );
              },
            ),
          ),
        ]);
  }
}

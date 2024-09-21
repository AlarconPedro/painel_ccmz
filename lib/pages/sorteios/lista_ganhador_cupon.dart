import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';
import '../../models/ganhador_model.dart';

class ListaGanhadorCupon extends StatefulWidget {
  const ListaGanhadorCupon({super.key});

  @override
  State<ListaGanhadorCupon> createState() => _ListaGanhadorCuponState();
}

class _ListaGanhadorCuponState extends State<ListaGanhadorCupon> {
  List<GanhadorModel> ganhador = [];

  final TextEditingController busca = TextEditingController();

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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          "Buscar: ",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: CupertinoTextField(
                              controller: busca,
                              onSubmitted: (value) async {
                                if (busca.text.isNotEmpty) {
                                  // await buscaNome(value);
                                  busca.clear();
                                }
                              },
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              placeholder: 'Pesquisar',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        CupertinoButton(
                          color: Cores.preto,
                          onPressed: () async {
                            if (busca.text.isNotEmpty) {
                              // await buscaNome(busca.text);
                              busca.clear();
                            }
                          },
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          child: const Icon(CupertinoIcons.search),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Text(
                        "Ganhadores",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Cores.preto,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ganhador.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(ganhador[index].parNome),
                          subtitle: Text(ganhador[index].cupNumero),
                          trailing: IconButton(
                            icon: const Icon(CupertinoIcons.delete),
                            onPressed: () async {
                              // await deletarCupon(cupons[index].id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

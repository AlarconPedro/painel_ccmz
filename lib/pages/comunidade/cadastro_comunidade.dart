import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class CadastroComunidade extends StatefulWidget {
  const CadastroComunidade({super.key});

  @override
  State<CadastroComunidade> createState() => _CadastroComunidadeState();
}

class _CadastroComunidadeState extends State<CadastroComunidade> {
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
              height: MediaQuery.of(context).size.height / 4.5,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cadastro de comunidade:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nome da comunidade',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, digite o nome da comunidade';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Cidade',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, digite o nome da cidade da comunidade';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'UF',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: Cores.cinzaEscuro,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, digite o UF comunidade';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     TextFormField(
                  //       decoration: const InputDecoration(
                  //         labelText: 'Nome da comunidade',
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(10),
                  //           ),
                  //         ),
                  //       ),
                  //       validator: (value) {
                  //         if (value == null || value.isEmpty) {
                  //           return 'Por favor, digite o nome da comunidade';
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ],
                  // ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        CupertinoButton(
                          onPressed: () {},
                          color: Cores.vermelhoMedio,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30,
                          ),
                          child: const Text("Cancelar"),
                        ),
                        const Spacer(),
                        CupertinoButton(
                          onPressed: () {},
                          color: Cores.verdeMedio,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30,
                          ),
                          child: const Text("Salvar"),
                        ),
                      ],
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

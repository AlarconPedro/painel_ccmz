import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/pages/pages.dart';

import '../classes/classes.dart';

class Esqueleto extends StatelessWidget {
  String tituloPagina;
  String tituloBoto;

  Function() abrirTelaCadastro;

  List<Widget> corpo;

  Esqueleto({
    super.key,
    required this.tituloBoto,
    required this.tituloPagina,
    required this.abrirTelaCadastro,
    required this.corpo,
  });

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
            child: Expanded(
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
                            onPressed: () {},
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text(
                          tituloPagina,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        CupertinoButton(
                          color: Cores.verdeMedio,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30,
                          ),
                          onPressed: () {
                            abrirTelaCadastro();
                            // Navigator.push(
                            //   context,
                            //   CupertinoDialogRoute(
                            //     builder: (context) {
                            //       return const CadastroPessoas();
                            //     },
                            //     context: context,
                            //   ),
                            // );
                          },
                          child: Text(tituloBoto),
                        ),
                      ]),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 1,
                        color: Cores.preto,
                      ),
                    ),
                    ...corpo,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class CustoEvento extends StatefulWidget {
  const CustoEvento({super.key});

  @override
  State<CustoEvento> createState() => _CustoEventoState();
}

class _CustoEventoState extends State<CustoEvento> {
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
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Custo do Evento",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    child: Divider(
                      color: Cores.cinzaEscuro,
                      thickness: 1,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 40,
                          ),
                          color: Cores.vermelhoMedio,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Fechar"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 40,
                          ),
                          color: Cores.verdeMedio,
                          onPressed: () {
                            // salvarPessoas();
                          },
                          child: const Row(
                            children: [
                              Icon(CupertinoIcons.printer),
                              SizedBox(width: 10),
                              Text("Gerar"),
                            ],
                          ),
                        ),
                      ),
                    ],
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

import 'package:flutter/cupertino.dart';

import '../../classes/classes.dart';

class AlocacaoEventoPessoas extends StatelessWidget {
  const AlocacaoEventoPessoas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Cores.branco,
        boxShadow: const [
          BoxShadow(
            color: Cores.cinzaMedio,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Quarto 1",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Expanded(
                      child: Container(
                        child: const Row(
                          children: [
                            Icon(CupertinoIcons.add, color: Cores.verdeEscuro),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Pessoa 1",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(CupertinoIcons.trash,
                                color: Cores.vermelhoMedio),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Expanded(
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.add, color: Cores.verdeEscuro),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Pessoa 1",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(CupertinoIcons.trash,
                              color: Cores.vermelhoMedio),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Expanded(
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.add,
                            color: Cores.verdeEscuro,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Pessoa 1",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(CupertinoIcons.trash,
                              color: Cores.vermelhoMedio),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

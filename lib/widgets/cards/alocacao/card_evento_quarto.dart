import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';

class CardEventoQuarto extends StatelessWidget {
  const CardEventoQuarto({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color: Cores.branco,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          // color: Cores.amareloClaro.withOpacity(0.2),
          color: Cores.branco,
        ),
        width: 300,
        height: 200,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    "Quarto 1",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.person),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Sabrina Eduarda Pistori Lumardoni",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.person),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Vazio",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(CupertinoIcons.person),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Vazio",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vagas: 2",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

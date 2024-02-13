import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/models/dashboard_pessoas_model.dart';

import '../../../classes/classes.dart';

class CardPessoaChegar extends StatelessWidget {
  DashboardPessoasModel pessoas;
  CardPessoaChegar({super.key, required this.pessoas});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 5,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Cores.branco,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                children: [
                  Icon(
                    pessoas.pesGenero == "M" ? Icons.male : Icons.female,
                    color: pessoas.pesGenero == "M"
                        ? Cores.azulMedio
                        : Cores.rosaEscuro,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    pessoas.pesNome,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Cores.preto,
                    ),
                  ),
                  Expanded(child: Container()),
                  const VerticalDivider(
                    color: Cores.preto,
                    thickness: 1,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    pessoas.comNome,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Cores.preto,
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

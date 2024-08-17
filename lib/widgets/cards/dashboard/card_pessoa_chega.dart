import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';
import '../../../data/models/web/dashboard_pessoas_model.dart';

class CardPessoaChega extends StatelessWidget {
  DashboardPessoasModel pessoas;
  Function() click;
  CardPessoaChega({super.key, required this.pessoas, required this.click});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        click();
      },
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
                  const Icon(
                    CupertinoIcons.checkmark_circle,
                    color: Cores.verdeMedio,
                    size: 35,
                  ),
                  const VerticalDivider(
                    color: Cores.preto,
                    thickness: 1,
                  ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../classes/classes.dart';
import '../../estrutura/estrutura.dart';

class SeletorModulo extends StatefulWidget {
  const SeletorModulo({super.key});

  @override
  State<SeletorModulo> createState() => _SeletorModuloState();
}

class _SeletorModuloState extends State<SeletorModulo> {
  List<Widget> criarModulos() {
    List<Widget> modulos = [];
    if (Globais.modulosPermitidos.moduloHospedagem) {
      modulos.add(
        CupertinoButton(
          onPressed: () {
            Globais.moduloLogado = "Hospedagem";
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const EstruturaPage(),
                    type: PageTransitionType.rightToLeft),
                (route) => false);
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Cores.azulMedio,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.bed_double_fill,
                  size: 50,
                  color: Cores.branco,
                ),
                Text(
                  "Hospedagem",
                  style: TextStyle(
                    color: Cores.branco,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (Globais.modulosPermitidos.moduloControleEstoque) {
      modulos.add(
        CupertinoButton(
          onPressed: () {
            Globais.moduloLogado = "Estoque";
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const EstruturaPage(),
                    type: PageTransitionType.rightToLeft),
                (route) => false);
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
                color: Cores.azulMedio,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.cube_box_fill,
                  size: 50,
                  color: Cores.branco,
                ),
                Text(
                  "Controle Estoque",
                  style: TextStyle(
                    color: Cores.branco,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (Globais.modulosPermitidos.moduloFinanceiro) {
      modulos.add(
        CupertinoButton(
          onPressed: () {
            Globais.moduloLogado = "Financeiro";
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const EstruturaPage(),
                    type: PageTransitionType.rightToLeft),
                (route) => false);
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Cores.azulMedio,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.money_dollar,
                  size: 50,
                  color: Cores.branco,
                ),
                Text(
                  "Financeiro",
                  style: TextStyle(
                    color: Cores.branco,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (Globais.modulosPermitidos.moduloSorteios) {
      modulos.add(
        CupertinoButton(
          onPressed: () {
            Globais.moduloLogado = "Sorteios";
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const EstruturaPage(),
                    type: PageTransitionType.rightToLeft),
                (route) => false);
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Cores.azulMedio,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.gift_fill,
                  size: 50,
                  color: Cores.branco,
                ),
                Text(
                  "Sorteios",
                  style: TextStyle(
                    color: Cores.branco,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (Globais.modulosPermitidos.moduloAdmin) {
      modulos.add(
        CupertinoButton(
          onPressed: () {
            Globais.moduloLogado = "Admin";
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                    child: const EstruturaPage(),
                    type: PageTransitionType.rightToLeft),
                (route) => false);
          },
          child: Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              color: Cores.azulMedio,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.settings,
                  size: 50,
                  color: Cores.branco,
                ),
                Text(
                  "Admin",
                  style: TextStyle(
                    color: Cores.branco,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return modulos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 180),
          height: 280,
          decoration: const BoxDecoration(
            color: Cores.branco,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Selecione o módulo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...criarModulos(),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

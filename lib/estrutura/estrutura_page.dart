import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/estrutura/estrutura.dart';
import 'package:painel_ccmn/pages/login/seletor_modulo.dart';

import '../classes/classes.dart';
import '../pages/pages.dart';

class EstruturaPage extends StatefulWidget {
  const EstruturaPage({super.key});

  @override
  State<EstruturaPage> createState() => _EstruturaPageState();
}

class _EstruturaPageState extends State<EstruturaPage> {
  Color cor = Colors.red;

  deslogar() {
    // FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.push(
      context,
      CupertinoDialogRoute(
        builder: (context) {
          return const CupertinoAlertDialog(
            title: Text('Saindo'),
            content: Text('Saindo do sistema...'),
            insetAnimationCurve: Curves.easeInOut,
            insetAnimationDuration: Duration(seconds: 1),
          );
        },
        context: context,
      ),
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    });
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('CCMN: ${Globais.moduloLogado}',
            style: const TextStyle(color: Cores.preto)),
        centerTitle: true,
        backgroundColor: Cores.branco,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              style: const TextStyle(color: Cores.cinzaEscuro),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 10),
                elevation: 5,
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                // WidgetStatePropertyAll(Colors.transparent),
              ),
              isExpanded: false,
              dropdownStyleData: DropdownStyleData(
                elevation: 5,
                decoration: BoxDecoration(
                  color: Cores.branco,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Cores.preto.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                maxHeight: 200,
                offset: const Offset(-10, -4),
              ),
              onChanged: (value) {
                if (value == 2) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text('Sair'),
                        content: const Text('Deseja sair do sistema ?'),
                        insetAnimationCurve: Curves.easeInOut,
                        insetAnimationDuration: const Duration(seconds: 1),
                        actions: [
                          CupertinoDialogAction(
                            textStyle: const TextStyle(color: Cores.preto),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Não'),
                          ),
                          CupertinoDialogAction(
                            textStyle:
                                const TextStyle(color: Cores.vermelhoMedio),
                            isDefaultAction: true,
                            onPressed: () {
                              deslogar();
                            },
                            child: const Text('Sim'),
                          ),
                        ],
                      );
                    },
                  );
                } else if (value == 1) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SeletorModulo()),
                    (route) => false,
                  );
                  // print('Perfil');
                } else {
                  Navigator.push(
                    context,
                    CupertinoDialogRoute(
                      builder: (context) {
                        // return Perfil();
                        return CupertinoAlertDialog(
                          title: const Text('Perfil'),
                          content: const Text('Perfil do usuário'),
                          insetAnimationCurve: Curves.easeInOut,
                          insetAnimationDuration: const Duration(seconds: 1),
                          actions: [
                            CupertinoDialogAction(
                              textStyle: const TextStyle(color: Cores.preto),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Fechar'),
                            ),
                          ],
                        );
                      },
                      context: context,
                    ),
                  );
                }
              },
              customButton: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      color: Cores.branco,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 180,
                        width: 200,
                        margin:
                            const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              CupertinoIcons.person_fill,
                              color: Cores.preto,
                            ),
                            Text(
                              Globais.nomePessoa,
                              style: const TextStyle(
                                color: Cores.preto,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                    value: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Perfil'),
                        SizedBox(width: 10),
                        Icon(
                          CupertinoIcons.gear,
                          color: Cores.cinzaEscuro,
                        ),
                      ],
                    )),
                // DropdownMenuItem(enabled: false, child: Divider()),
                DropdownMenuItem(
                  value: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trocar de Modulo'),
                      SizedBox(width: 10),
                      Icon(
                        CupertinoIcons.arrow_2_squarepath,
                        color: Cores.cinzaEscuro,
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                    value: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sair'),
                        SizedBox(width: 10),
                        Icon(
                          CupertinoIcons.arrow_right,
                          color: Cores.cinzaEscuro,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10),
        //     child: IconButton(
        //       icon: const Icon(Icons.exit_to_app, color: Cores.preto),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const LoginPage()),
        //         );
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: SizedBox(
        width: width,
        height: height - 56,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 15,
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    width: 250,
                    height: height - 56,
                    color: Cores.cinzaEscuro,
                    child: Nav(
                      widthNav: 250,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: width - 250,
              child: const PageControl(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/cadastro_form.dart';
import 'package:painel_ccmn/widgets/form/campo_texto.dart';

import '../../classes/classes.dart';

class Participantes extends StatefulWidget {
  const Participantes({super.key});

  @override
  State<Participantes> createState() => _ParticipantesState();
}

class _ParticipantesState extends State<Participantes> {
  String titulo = "Participantes";

  TextEditingController controlador = TextEditingController();

  PageController pageController = PageController();

  buscarParticipantes() async {}

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
              width: 700,
              height: 850,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Participantes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 10, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: campoTexto(
                            titulo: titulo,
                            dica: "Nome",
                            icone: Icons.person,
                            validador: (value) {
                              // if (value.isEmpty) {
                              //   return "Campo Obrigatório";
                              // }
                              return null;
                            },
                            controlador: controlador,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CupertinoButton(
                          color: Cores.preto,
                          padding: const EdgeInsets.all(13),
                          onPressed: () {},
                          child: const Icon(
                            CupertinoIcons.search,
                            color: Cores.branco,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CupertinoButton(
                          color: Cores.verdeMedio,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: 30,
                          ),
                          onPressed: () {
                            pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                "Adicionar",
                                style: TextStyle(
                                  color: Cores.branco,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                CupertinoIcons.add,
                                color: Cores.branco,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 5,
                                  child: ListTile(
                                    title: Text("Participante $index"),
                                    subtitle: const Text("CPF: 000.000.000-00"),
                                    trailing: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          CupertinoIcons.delete,
                                          color: Cores.vermelhoMedio,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        CadastroForm(
                          formKey: GlobalKey<FormState>(),
                          campos: [],
                          titulo: "Cadastro de Participantes",
                          gravar: () {},
                          cancelar: () {
                            pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
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

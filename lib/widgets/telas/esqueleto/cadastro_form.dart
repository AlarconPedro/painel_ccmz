import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';

class CadastroForm extends StatelessWidget {
  GlobalKey<FormState> formKey;
  List<Widget> campos;

  String titulo;

  Function() gravar;
  Function() cancelar;

  double? largura;
  double? altura;

  CadastroForm({
    super.key,
    required this.formKey,
    required this.campos,
    required this.titulo,
    required this.gravar,
    required this.cancelar,
    this.largura,
    this.altura,
  });

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
              height: altura == null
                  ? MediaQuery.of(context).size.height / 2
                  : MediaQuery.of(context).size.height / altura!,
              width: largura == null
                  ? MediaQuery.of(context).size.width / 4.5
                  : MediaQuery.of(context).size.width / largura!,
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            titulo,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    ...campos,
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              cancelar();
                              Navigator.pop(context);
                            },
                            color: Cores.vermelhoMedio,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 30,
                            ),
                            child: const Text("Cancelar"),
                          ),
                          const Spacer(),
                          CupertinoButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                gravar();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Cores.vermelhoMedio,
                                    content: Text(
                                      'Preencha os campos corretamente',
                                    ),
                                  ),
                                );
                              }
                            },
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
      ),
    );
  }
}

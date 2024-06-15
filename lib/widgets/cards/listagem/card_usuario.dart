import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/models/usuario_model.dart';

import '../../../classes/classes.dart';

class CardUsuario extends StatelessWidget {
  UsuarioModel usuario;
  Function excluir;

  CardUsuario({super.key, required this.usuario, required this.excluir});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Cores.branco,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.person),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Text(usuario.usuNome),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(usuario.usuEmail),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(usuario.usuSenha),
                      ),
                      Expanded(
                        flex: 2,
                        child: CupertinoCheckbox(
                            value: usuario.usuAcessoFinanceiro,
                            onChanged: (value) {}),
                      ),
                      Expanded(
                        flex: 2,
                        child: CupertinoCheckbox(
                            value: usuario.usuAcessoEstoque,
                            onChanged: (value) {}),
                      ),
                      Expanded(
                        flex: 2,
                        child: CupertinoCheckbox(
                          value: usuario.usuAcessoHospede,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 30),
                      const Icon(CupertinoIcons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: CupertinoButton(
              child:
                  const Icon(CupertinoIcons.trash, color: Cores.vermelhoMedio),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Excluir Pessoa"),
                      content:
                          const Text("Deseja realmente excluir esta pessoa ?"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Não",
                              style: TextStyle(color: Cores.vermelhoMedio)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text("Sim",
                              style: TextStyle(color: Cores.verdeMedio)),
                          onPressed: () {
                            Navigator.pop(context);
                            excluir();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

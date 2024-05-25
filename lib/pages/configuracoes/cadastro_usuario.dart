import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';
import '../pages.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController senhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool hospedagem = false;
  bool financeiro = false;
  bool estoque = false;
  bool carregando = false;

  cadastroUsuario() async {}

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      largura: 2,
      altura: 3.5,
      cancelar: () {
        // Navigator.pop(context);
      },
      gravar: () {
        // Navigator.pop(context);
      },
      titulo: "Cadastro de usuário",
      formKey: _formKey,
      campos: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Cores.cinzaEscuro,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o Email do Usuário';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Cores.cinzaEscuro,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a Senha do Usuário';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Hospedagem",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                    value: hospedagem,
                    onChanged: (value) {
                      setState(() => hospedagem = value!);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Financeiro",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                    value: financeiro,
                    onChanged: (value) {
                      setState(() => financeiro = value!);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Estoque",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                    value: estoque,
                    onChanged: (value) {
                      setState(() => estoque = value!);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

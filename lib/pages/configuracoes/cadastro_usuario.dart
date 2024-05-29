import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/models/usuario_model.dart';

import '../../classes/classes.dart';
import '../../data/api/api_usuario.dart';
import '../pages.dart';

class CadastroUsuario extends StatefulWidget {
  UsuarioModel? usuario;
  CadastroUsuario({super.key, this.usuario});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController senhaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomeController = TextEditingController();

  bool hospedagem = false;
  bool financeiro = false;
  bool estoque = false;
  bool carregando = false;

  UsuarioModel usuario = UsuarioModel(
    usuCodigo: 0,
    usuNome: "",
    usuEmail: "",
    usuSenha: "",
    usuCodigoFirebase: "",
    usuAcessoHospede: false,
    usuACessoFinanceiro: false,
    usuAcessoEstoque: false,
  );

  alimentarCampos() {
    if (widget.usuario != null) {
      usuario = widget.usuario!;
      nomeController.text = usuario.usuNome;
      emailController.text = usuario.usuEmail;
      senhaController.text = usuario.usuSenha;
      hospedagem = usuario.usuAcessoHospede;
      financeiro = usuario.usuACessoFinanceiro;
      estoque = usuario.usuAcessoEstoque;
    }
  }

  cadastroUsuario() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: senhaController.text)
          .then((value) async {
        usuario.usuCodigoFirebase = value.user!.uid;
        usuario.usuNome = nomeController.text;
        usuario.usuEmail = emailController.text;
        usuario.usuSenha = senhaController.text;
        usuario.usuAcessoHospede = hospedagem;
        usuario.usuACessoFinanceiro = financeiro;
        usuario.usuAcessoEstoque = estoque;
        await gravarUsuario(usuario);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Usuário criado com sucesso!"),
          backgroundColor: Cores.verdeMedio,
        ));
        Navigator.pop(context);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Erro ao criar usuário!"),
        backgroundColor: Cores.vermelhoMedio,
      ));
      await FirebaseAuth.instance.currentUser!.delete();
      Navigator.pop(context);
    }
  }

  gravarUsuario(UsuarioModel usuarioModel) async {
    setState(() => carregando = true);
    var retorno = await ApiUsuario().gravarUsuario(usuarioModel);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário gravado com sucesso!"),
        backgroundColor: Cores.verdeMedio,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Erro ao gravar usuário!"),
        backgroundColor: Cores.vermelhoMedio,
      ));
    }
    setState(() => carregando = false);
  }

  updateUsuario() async {
    setState(() => carregando = true);
    var retorno = await ApiUsuario().atualizarUsuario(UsuarioModel(
      usuCodigo: usuario.usuCodigo,
      usuNome: nomeController.text,
      usuEmail: emailController.text,
      usuSenha: senhaController.text,
      usuCodigoFirebase: usuario.usuCodigoFirebase,
      usuAcessoHospede: hospedagem,
      usuACessoFinanceiro: financeiro,
      usuAcessoEstoque: estoque,
    ));
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Usuário atualizado com sucesso!"),
        backgroundColor: Cores.verdeMedio,
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Erro ao atualizar usuário!"),
        backgroundColor: Cores.vermelhoMedio,
      ));
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alimentarCampos();
  }

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
        if (widget.usuario != null) {
          updateUsuario();
        } else {
          cadastroUsuario();
        }
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
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
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
                      return 'Por favor, digite o Nome do Usuário';
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

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:painel_ccmn/data/models/web/usuario_model.dart';
import 'package:painel_ccmn/pages/login/seletor_modulo.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../classes/classes.dart';
import '../../classes/cores.dart';
import '../../data/api/api_usuario.dart';
import '../../estrutura/estrutura.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final PageController _pageController = PageController();

  String _errorMessage = '';
  String _suceessMessage = '';

  bool carregando = false;

  logarUsuario(String usuario, String senha) {
    setState(() {
      _errorMessage = '';
      _suceessMessage = '';
    });
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: usuario, password: senha)
        .then(
      (value) async {
        setState(() {
          _suceessMessage = 'Buscando dados do usuário...';
        });
        var retorno = await buscarDadosUsuario(value.user!.uid);
        if (retorno) {
          logarModulo();
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     PageTransition(
          //         child: const EstruturaPage(),
          //         type: PageTransitionType.rightToLeft),
          //     (route) => false);
        } else {
          setState(() {
            carregando = false;
            _errorMessage = 'Erro ao buscar dados do usuário';
            _suceessMessage = '';
          });
        }
      },
    ).catchError((error) {
      setState(() {
        carregando = false;
        _errorMessage =
            'Erro ao autenticar usuário, verifique e-mail e senha e tente novamente';
      });
    });
  }

  logarModulo() {
    // List<bool> modulosPermitidos = [
    //   Globais.moduloHospedagem,
    //   Globais.moduloControleEstoque,
    //   Globais.moduloFinanceiro,
    //   Globais.moduloSorteios,
    //   Globais.moduloAdmin,
    // ];
    // for (var modulo in modulosPermitidos) {
    //   if (modulo) Globais.modulosPermitidos.add(modulo);
    // }

    //verificar se existe mais de um modulo permitido
    //se sim, exibir tela de seleção de modulo
    //se não, logar no modulo permitido
    int qtdModulos = Globais.modulosPermitidos.getModulosPermitidos();
    if (qtdModulos > 1) {
      _pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    } else {
      if (Globais.moduloHospedagem) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const EstruturaPage(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      } else if (Globais.moduloControleEstoque) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const EstruturaPage(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      } else if (Globais.moduloFinanceiro) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: const EstruturaPage(),
                type: PageTransitionType.rightToLeft),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário sem acesso ao sistema"),
            backgroundColor: Cores.vermelhoMedio,
          ),
        );
        setState(() {
          _errorMessage = 'Sem Permissão !';
          _suceessMessage = '';
        });
      }
    }
  }

  Future<bool> buscarDadosUsuario(String idFirebase) async {
    var response = await ApiUsuario().loginSistema(idFirebase);
    if (response.statusCode == 200) {
      var decoded = UsuarioModel.fromJson(json.decode(response.body));
      setState(() {
        Globais.nomePessoa = decoded.usuNome;
        Globais.codigoUsuario = decoded.usuCodigo;
        Globais.moduloHospedagem = decoded.usuAcessoHospede;
        Globais.moduloControleEstoque = decoded.usuAcessoEstoque;
        Globais.moduloFinanceiro = decoded.usuAcessoFinanceiro;
      });
      if (decoded.usuAcessoHospede) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário sem acesso ao sistema"),
            backgroundColor: Cores.vermelhoMedio,
          ),
        );
        setState(() {
          _errorMessage = 'Sem Permissão !';
          _suceessMessage = '';
        });
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar dados do usuário"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Cores.branco,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 180),
              width: 550,
              height: 500,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: largura,
                    height: 100,
                    child: const Text(
                      // 'Painel CCMN',
                      'CCMN Manager',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Cores.cinzaEscuro,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // decoration: const BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage('images/logo.png'),
                    //   ),
                    // ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: largura / 30, vertical: altura / 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: true,
                                autofillHints: const [AutofillHints.email],
                                decoration: const InputDecoration(
                                  labelText: 'E-mail',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Cores.cinzaEscuro,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Cores.cinzaEscuro,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Cores.cinzaEscuro,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Cores.cinzaEscuro,
                                    ),
                                  ),
                                  focusColor: Cores.cinzaEscuro,
                                  hintStyle: TextStyle(
                                    color: Cores.cinzaEscuro,
                                  ),
                                  hintText: 'Digite seu e-mail',
                                  counterStyle: TextStyle(
                                    color: Cores.cinzaEscuro,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Cores.cinzaEscuro,
                                  ),
                                ),
                                validator: (value) {
                                  if (value != "Administrador") {
                                    if (value == null ||
                                        value.isEmpty ||
                                        !value.contains('@') ||
                                        !value.contains('.') ||
                                        !value.contains('com') ||
                                        value.length < 10) {
                                      return 'Por favor, digite seu e-mail';
                                    }
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                enableSuggestions: true,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Cores.cinzaEscuro,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Cores.cinzaEscuro,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Cores.cinzaEscuro,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Cores.cinzaEscuro,
                                    ),
                                  ),
                                  focusColor: Cores.cinzaEscuro,
                                  hintStyle: TextStyle(
                                    color: Cores.cinzaEscuro,
                                  ),
                                  hintText: 'Digite sua senha',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Cores.cinzaEscuro,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 6) {
                                    return 'Por favor, digite sua senha';
                                  }
                                  // setState(() {
                                  //   _errorMessage = '';
                                  //   _suceessMessage = '';
                                  // });
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          _suceessMessage,
                          style: const TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => carregando = true);
                          if (_emailController.text == "Administrador" &&
                              _passwordController.text == "P807265@") {
                            setState(() {
                              Globais.isAdmin = true;
                              Globais.nomePessoa = "Administrador";
                              Globais.moduloLogado = "Admin";
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageTransition(
                                    child: const EstruturaPage(),
                                    type: PageTransitionType.rightToLeft),
                                (route) => false);
                          } else {
                            logarUsuario(_emailController.text,
                                _passwordController.text);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Cores.verdeEscuro,
                        fixedSize: const Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: carregando
                          ? const CupertinoActivityIndicator(
                              color: Cores.branco,
                            )
                          : const Text('Logar'),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Cores.cinzaEscuro,
                    ),
                    onPressed: () {},
                    onHover: (value) {},
                    child: const Text('Esqueceu a senha?'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SeletorModulo(),
        ],
      ),
    );
  }
}

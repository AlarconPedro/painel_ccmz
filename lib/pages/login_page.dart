import 'package:flutter/material.dart';

import '../classes/cores.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _errorMessage = '';
  String _suceessMessage = '';

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Cores.branco,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(bottom: 180),
          width: largura / 3,
          height: altura / 2,
          decoration: BoxDecoration(
            color: Cores.branco,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: const [
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
                child: Text(
                  'Painel CCMZ',
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
                            decoration: InputDecoration(
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
                              errorBorder: const OutlineInputBorder(
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
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@') ||
                                  !value.contains('.') ||
                                  !value.contains('com') ||
                                  value.length < 10) {
                                return 'Por favor, digite seu e-mail';
                              }
                              return null;
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
                            decoration: InputDecoration(
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
                              errorBorder: const OutlineInputBorder(
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
                      // bool retorno = await verificaLogin();
                      // if (retorno) {
                      // FirebaseAuth.instance
                      //     .signInWithEmailAndPassword(
                      //         email: _emailController.text,
                      //         password: _passwordController.text)
                      //     .then(
                      //   (value) {
                      //     Navigator.pop(context);
                      //     Navigator.push(
                      //         context,
                      //         PageTransition(
                      //             child: const EstruturaPage(),
                      //             type: PageTransitionType.rightToLeft));
                      //     setState(() {
                      //       Globais.logado = true;
                      //     });
                      //   },
                      // ).catchError((error) {
                      //   setState(() {
                      //     _errorMessage =
                      //         'Erro ao autenticar usuário, verifique e-mail e senha e tente novamente';
                      //   });
                      // });
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
                  child: const Text('Logar'),
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
    );
  }
}

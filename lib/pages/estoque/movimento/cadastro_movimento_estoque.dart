import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/estoque/produtos/produtos.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/cadastro_form.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/classes.dart';
import '../../../widgets/form/campo_texto.dart';

class CadastroMovimentoEstoque extends StatefulWidget {
  const CadastroMovimentoEstoque({super.key});

  @override
  State<CadastroMovimentoEstoque> createState() =>
      _CadastroMovimentoEstoqueState();
}

class _CadastroMovimentoEstoqueState extends State<CadastroMovimentoEstoque> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final PageController pageController = PageController();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController codigoBarrasController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  double altura = 2.5;
  double largura = 3;

  int tipoSelecionado = 1;

  atualizarTamanho() {
    setState(() {
      altura = pageController.page == 0 ? 2.5 : 1.5;
      largura = pageController.page == 0 ? 3 : 1.5;
    });
  }

  @override
  initState() {
    super.initState();
    pageController.addListener(atualizarTamanho);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Colors.white,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: MediaQuery.of(context).size.height / altura,
              width: MediaQuery.of(context).size.width / largura,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Movimento de Estoque",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: campoTexto(
                                      controlador: nomeController,
                                      titulo: "Nome do Produto",
                                      dica: "Nome do Produto",
                                      icone: CupertinoIcons.cube_box,
                                      validador: (value) {
                                        if (value.isEmpty) {
                                          return "Campo Obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: CupertinoButton(
                                      color: Cores.cinzaEscuro,
                                      padding: const EdgeInsets.all(12),
                                      child: const Icon(CupertinoIcons.search),
                                      onPressed: () {
                                        pageController.animateToPage(
                                          1,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: campoTexto(
                                      controlador: nomeController,
                                      titulo: "Quantidade",
                                      dica: "Quantiade do Produto",
                                      icone: CupertinoIcons.number,
                                      validador: (value) {
                                        if (value.isEmpty) {
                                          return "Campo Obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: DropDownForm(
                                        label: "Tipo",
                                        itens: const [
                                          DropdownMenuItem(
                                              value: 1, child: Text("Entrada")),
                                          DropdownMenuItem(
                                              value: 2, child: Text("Saída"))
                                        ],
                                        selecionado: tipoSelecionado,
                                        onChange: (value) {
                                          tipoSelecionado = value;
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Descrição',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 10,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                maxHeight: 100,
                                              ),
                                              child: Focus(
                                                child: CupertinoTextField(
                                                  controller:
                                                      descricaoController,
                                                  expands: true,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  focusNode: FocusNode(),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  placeholder: "Digite aqui...",
                                                  decoration: BoxDecoration(
                                                    color: Cores.cinzaClaro,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                    border: Border.all(
                                                      color: Cores.cinzaEscuro,
                                                      width: 1,
                                                    ),
                                                    backgroundBlendMode:
                                                        BlendMode.color,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Produtos(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              if (pageController.page == 0) {
                                Navigator.pop(context);
                              } else {
                                pageController.animateToPage(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              }
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
                              if (_formKey.currentState!.validate()) {
                                // gravar();
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
                            child: const Text("Gravar"),
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
    // return CadastroForm(
    //   formKey: _formKey,
    //   titulo: "Movimento de Estoque",
    //   altura: 2.5,
    //   largura: 3,
    //   gravar: () {},
    //   cancelar: () {},
    //   campos: [
    //     Expanded(
    //       child: PageView(
    //         controller: pageController,
    //         physics: const NeverScrollableScrollPhysics(),
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Expanded(
    //                 child: campoTexto(
    //                   controlador: nomeController,
    //                   titulo: "Nome",
    //                   dica: "Nome do Produto",
    //                   icone: CupertinoIcons.cube_box,
    //                   validador: (value) {
    //                     if (value.isEmpty) {
    //                       return "Campo Obrigatório";
    //                     }
    //                     return null;
    //                   },
    //                 ),
    //               ),
    //               CupertinoButton(
    //                 child: Icon(CupertinoIcons.search),
    //                 onPressed: () {
    //                   pageController.animateToPage(
    //                     1,
    //                     duration: const Duration(milliseconds: 300),
    //                     curve: Curves.easeIn,
    //                   );
    //                 },
    //               )
    //             ],
    //           ),
    //           Produtos(),
    //           // Column(
    //           //   children: [
    //           //     TextFormField(
    //           //       decoration: const InputDecoration(labelText: "Produto"),
    //           //     ),
    //           //     TextFormField(
    //           //       decoration: const InputDecoration(labelText: "Quantidade"),
    //           //     ),
    //           //     TextFormField(
    //           //       decoration: const InputDecoration(labelText: "Valor"),
    //           //     ),
    //           //   ],
    //           // ),
    //           // Column(
    //           //   children: [
    //           //     TextFormField(
    //           //       decoration: const InputDecoration(labelText: "Produto"),
    //           //     ),
    //           //     TextFormField(
    //           //       decoration: const InputDecoration(labelText: "Quantidade"),
    //           //     ),
    //           //     TextFormField(
    //           //       decoration: const InputDecoration(labelText: "Valor"),
    //           //     ),
    //           //   ],
    //           // ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}

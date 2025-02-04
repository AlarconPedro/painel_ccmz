import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/pages/estoque/produtos/produtos.dart';
import 'package:painel_ccmn/widgets/botoes/btn_primario.dart';
import 'package:painel_ccmn/widgets/botoes/btn_secundario.dart';

import '../../../../classes/classes.dart';
import '../../../../data/data.dart';
import '../../../../widgets/form/campo_texto.dart';
import '../../../../widgets/separador.dart';
import '../../../../widgets/widgets.dart';
import '../../../pages.dart';

class AcertoEventoProdutos extends StatefulWidget {
  List<AcertoModel> comunidades;
  Function voltarTela;
  AcertoEventoProdutos({
    super.key,
    required this.comunidades,
    required this.voltarTela,
  });

  @override
  State<AcertoEventoProdutos> createState() => _AcertoEventoProdutosState();
}

class _AcertoEventoProdutosState extends State<AcertoEventoProdutos> {
  final controlador = TextEditingController();
  final quantidadeController = TextEditingController();

  PageController pageController = PageController();

  bool carregando = false;

  int comunidadeSelecionada = 0;
  (int, String) produtoSelecionado = (0, "");

  List<String> produtos = [];
  List<DropdownMenuItem> comunidades = [];

  // double altura = 350;
  // double largura = 600;

  buscarComunidadesEvento() async {
    setState(() => carregando = true);
    comunidades.clear();
    comunidades.add(const DropdownMenuItem(value: 0, child: Text("Todos")));
    for (var comunidade in widget.comunidades) {
      comunidades.add(DropdownMenuItem(
          value: comunidade.comCodigo, child: Text(comunidade.comNome)));
    }
    setState(() => carregando = false);
  }

  // abrirTelaProdutos() {
  //   if (largura == 1000) {
  //     setState(() {
  //       altura = 350;
  //       largura = 600;
  //     });
  //   } else {
  //     setState(() {
  //       altura = 600;
  //       largura = 1000;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: GlobalKey<FormState>(),
      altura: 2.5,
      largura: 1.5,
      titulo: "Produtos do Evento",
      campos: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: Cores.cinzaClaro,
                      borderRadius: BorderRadius.circular(10)),
                  child: Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoDialogRoute(
                                      builder: (context) => selecionarProduto(),
                                      // builder: (context) {
                                      //   return Servicos();
                                      //   // return Servicos(
                                      //   //     servicoSelecionado:
                                      //   //         servicoSelecionado,
                                      //   //     onChange: (servico) => setState(
                                      //   //         () => servicoSelecionado =
                                      //   //             servico),
                                      //   //     context: context);
                                      // },
                                      context: context)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Cores.cinzaClaro, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(produtoSelecionado.$2.isEmpty
                                          ? "Selecione o Produto"
                                          : produtoSelecionado.$2)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: DropDownForm(
                              label: "Comunidade",
                              itens: comunidades,
                              selecionado: comunidadeSelecionada,
                              onChange: (valor) =>
                                  setState(() => comunidadeSelecionada = valor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Cores.cinzaClaro,
                        borderRadius: BorderRadius.circular(10)),
                    child: Expanded(
                      child: produtos.isEmpty
                          ? const Center(child: Text("Nenhum Produto"))
                          : ListView.builder(
                              itemCount: produtos.length,
                              itemBuilder: (context, index) =>
                                  ListTile(title: Text(produtos[index]))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      gravar: () => Navigator.pop(context),
      cancelar: () => widget.voltarTela(),
    );
  }

  selecionarProduto() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 800,
          height: 600,
          decoration: BoxDecoration(
            color: Cores.branco,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              Expanded(child: Produtos()),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    btnSecundario(
                        texto: "Fechar",
                        onPressed: () => Navigator.pop(context)),
                    separador(),
                    btnPrimario(
                      texto: "Selecionar",
                      onPressed: () =>
                          Navigator.pop(context, produtoSelecionado),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //   return Scaffold(
  //     backgroundColor: Colors.transparent,
  //     body: Center(
  //       child: Card(
  //         color: Cores.branco,
  //         elevation: 10,
  //         shape: const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10))),
  //         child: SizedBox(
  //           height: altura,
  //           width: largura,
  //           child: PageView(
  //             controller: pageController,
  //             physics: const NeverScrollableScrollPhysics(),
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.all(10),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: MouseRegion(
  //                             cursor: SystemMouseCursors.click,
  //                             child: GestureDetector(
  //                               onTap: () {
  //                                 abrirTelaProdutos();
  //                                 pageController.animateToPage(1,
  //                                     duration:
  //                                         const Duration(milliseconds: 300),
  //                                     curve: Curves.easeInOut);
  //                               },
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     vertical: 5, horizontal: 10),
  //                                 child: Container(
  //                                   height: 50,
  //                                   decoration: BoxDecoration(
  //                                     border: Border.all(
  //                                       color: Cores.cinzaEscuro,
  //                                       width: 1,
  //                                     ),
  //                                     borderRadius: BorderRadius.circular(10),
  //                                   ),
  //                                   child: Center(
  //                                     child: Text(controlador.text.isEmpty
  //                                         ? "Selecione o Produto"
  //                                         : controlador.text),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       children: [
  //                         // Expanded(
  //                         //   child: DropDownForm(
  //                         //       label: "Comunidade",
  //                         //       itens: widget.comunidades
  //                         //           .map((e) => e.comNome)
  //                         //           .toList(),
  //                         //       selecionado: comunidadeSelecionada,
  //                         //       onChange: (valor) {
  //                         //         setState(() => comunidadeSelecionada = valor);
  //                         //       }),
  //                         // ),
  //                         const SizedBox(width: 10),
  //                         Expanded(
  //                           child: campoTexto(
  //                             controlador: quantidadeController,
  //                             titulo: "Quantidade",
  //                             dica: "Quantidade do Produto",
  //                             tipo: TextInputType.number,
  //                             icone: CupertinoIcons.number,
  //                             mascara: MaskTextInputFormatter(),
  //                             temMascara: false,
  //                             validador: (value) {
  //                               if (value.isEmpty) {
  //                                 return "Campo Obrigatório";
  //                               }
  //                               return null;
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               AnimatedContainer(
  //                 duration: const Duration(milliseconds: 300),
  //                 curve: Curves.easeInOut,
  //                 width: largura,
  //                 height: altura,
  //                 decoration: BoxDecoration(
  //                     color: Cores.branco,
  //                     borderRadius: BorderRadius.circular(10)),
  //                 child: SizedBox(
  //                   child: Column(
  //                     children: [
  //                       Expanded(
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(8.0),
  //                           child: Produtos(
  //                             selecionar: (produto) => setState(
  //                                 () => controlador.text = produto.proNome),
  //                             selecionarProduto: true,
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8),
  //                         child: Row(
  //                           children: [
  //                             btnSecundario(
  //                               texto: "Voltar",
  //                               onPressed: () {
  //                                 abrirTelaProdutos();
  //                                 controlador.clear();
  //                                 pageController.animateToPage(0,
  //                                     duration:
  //                                         const Duration(milliseconds: 300),
  //                                     curve: Curves.easeInOut);
  //                               },
  //                             ),
  //                             const Spacer(),
  //                             btnPrimario(
  //                               texto: "Selecionar",
  //                               onPressed: () {
  //                                 abrirTelaProdutos();
  //                                 pageController.animateToPage(0,
  //                                     duration:
  //                                         const Duration(milliseconds: 300),
  //                                     curve: Curves.easeInOut);
  //                               },
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

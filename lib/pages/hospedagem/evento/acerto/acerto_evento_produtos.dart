import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:painel_ccmn/pages/hospedagem/evento/acerto/acerto_evento_data.dart';
import 'package:painel_ccmn/widgets/botoes/btn_primario.dart';
import 'package:painel_ccmn/widgets/botoes/btn_secundario.dart';

import '../../../../classes/classes.dart';
import '../../../../data/data.dart';
import '../../../../data/models/web/hospedagem/evento_despesas_model.dart';
import '../../../../data/models/web/hospedagem/servico_evento_model.dart';
import '../../../../funcoes/funcoes_mascara.dart';
import '../../../../widgets/separador.dart';
import '../../../../widgets/snack_notification.dart';
import '../../../../widgets/widgets.dart';
import '../../../pages.dart';

class AcertoEventoProdutos extends StatefulWidget {
  List<AcertoModel> comunidades;
  Function voltarTela;
  int codigoEvento;
  AcertoEventoProdutos({
    super.key,
    required this.comunidades,
    required this.voltarTela,
    required this.codigoEvento,
  });

  @override
  State<AcertoEventoProdutos> createState() => _AcertoEventoProdutosState();
}

class _AcertoEventoProdutosState extends State<AcertoEventoProdutos> {
  final controlador = TextEditingController();
  final quantidadeController = TextEditingController();

  List<ServicoEventoModel> produtos = [];

  TextEditingController quantidadeProduto = TextEditingController();

  PageController pageController = PageController();

  bool carregando = false;

  int comunidadeSelecionada = 0;
  (int, String, double) produtoSelecionado = (0, "", 0.0);

  List<DropdownMenuItem> comunidadesListar = [];
  List<Map<int, String>> comunidades = [];

  AcertoEventoData acertoEventoData = AcertoEventoData();

  // double altura = 350;
  // double largura = 600;

  listarComunidadesEvento() async {
    setState(() => carregando = true);
    comunidadesListar.clear();
    comunidadesListar
        .add(const DropdownMenuItem(value: 0, child: Text("Todos")));
    for (var i = 0; i <= widget.comunidades.length; i++) {
      comunidades.add({0: "Todos"});
      comunidades.add(
          {widget.comunidades[i].comCodigo: widget.comunidades[i].comNome});
      comunidadesListar.add(DropdownMenuItem(
          value: i + 1, child: Text(widget.comunidades[i].comNome)));
    }
    setState(() => carregando = false);
  }

  buscarProdutosEvento() async {
    setState(() => carregando = true);
    await acertoEventoData.buscarProdutosEvento(
      codigoEvento: widget.codigoEvento,
      dadosRetorno: (dados) {
        produtos.clear();
        for (var servico in dados) {
          produtos.add(ServicoEventoModel.fromJson(servico));
        }
      },
      erro: () {
        snackNotification(
            context: context,
            mensage: "Erro ao buscar serviços",
            cor: Cores.vermelhoMedio);
      },
    );
    setState(() => carregando = false);
  }

  gravarProdutosEvento() async {
    setState(() => carregando = true);
    await acertoEventoData.inserirDespesaEvento(
      despesa: EventoDespesasModel(
        edpCodigo: 0,
        eveCodigo: widget.codigoEvento,
        edpCodigoDespesa: produtoSelecionado.$1,
        edpQuantidade: int.parse(quantidadeProduto.text),
        edpComunidade: comunidadeSelecionada == 0
            ? 0
            : comunidades[comunidadeSelecionada].keys.first,
        edpTipoDespesa: true,
        edpValor: produtoSelecionado.$3,
      ),
      dadosRetorno: (dados) {
        snackNotification(
            context: context,
            mensage: "Despesa inserida com sucesso !",
            cor: Cores.verdeMedio);
        buscarProdutosEvento();
      },
      erro: () {
        snackNotification(
            context: context, mensage: "Erro ao inserir despesa !");
      },
    );
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
    buscarProdutosEvento();
    listarComunidadesEvento();
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
          flex: 12,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MouseRegion(
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
                                color: produtoSelecionado.$2.isNotEmpty
                                    ? Cores.verdeMedio
                                    : Cores.cinzaClaro,
                                border: Border.all(
                                    color: Cores.cinzaMedio, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  produtoSelecionado.$2.isEmpty
                                      ? "Selecione o Produto"
                                      : produtoSelecionado.$2,
                                  style: TextStyle(
                                      color: produtoSelecionado.$2.isEmpty
                                          ? Cores.preto
                                          : Cores.branco),
                                ),
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
                            itens: comunidadesListar,
                            selecionado: comunidadeSelecionada,
                            onChange: (valor) =>
                                setState(() => comunidadeSelecionada = valor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: quantidadeProduto,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: "Quantidade",
                            prefixIcon: const Icon(CupertinoIcons.number),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value!.isEmpty ? "Informe a quantidade" : null,
                        ),
                      ),
                    ],
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
                              itemBuilder: (context, index) => ListTile(
                                title: Text(produtos[index].serNome),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "Valor: ${FuncoesMascara.mascaraDinheiro(produtos[index].serValor)}"),
                                    Text(
                                        "Quantidade: ${produtos[index].serQuantidade}"),
                                    Text(
                                        "Total: ${FuncoesMascara.mascaraDinheiro((produtos[index].serValor * produtos[index].serQuantidade))}"),
                                    const SizedBox()
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(CupertinoIcons.delete,
                                      color: Cores.vermelhoMedio),
                                  onPressed: () =>
                                      acertoEventoData.excluirDespesaEvento(
                                          codigoDespesa:
                                              produtos[index].serCodigo,
                                          dadosRetorno: (dados) {
                                            snackNotification(
                                                context: context,
                                                mensage:
                                                    "Despesa excluída com sucesso !",
                                                cor: Cores.verdeMedio);
                                            buscarProdutosEvento();
                                          },
                                          erro: () {
                                            snackNotification(
                                                context: context,
                                                mensage:
                                                    "Erro ao excluir despesa !");
                                          }),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      gravar: () => gravarProdutosEvento(),
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
            color: Cores.cinzaClaro,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
            ],
          ),
          child: Column(
            children: [
              Expanded(
                  child: Produtos(
                selecionado: true,
                selecionarProduto: (codigo, nome, valor) =>
                    setState(() => produtoSelecionado = (codigo, nome, valor)),
              )),
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

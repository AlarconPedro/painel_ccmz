import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/pages/estoque/produtos/produtos.dart';
import 'package:painel_ccmn/widgets/botoes/btn_primario.dart';
import 'package:painel_ccmn/widgets/botoes/btn_secundario.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';

import '../../../../classes/classes.dart';
import '../../../../widgets/form/campo_texto.dart';

class AcertoEventoOutrasDespesas extends StatefulWidget {
  const AcertoEventoOutrasDespesas({super.key});

  @override
  State<AcertoEventoOutrasDespesas> createState() =>
      _AcertoEventoOutrasDespesasState();
}

class _AcertoEventoOutrasDespesasState
    extends State<AcertoEventoOutrasDespesas> {
  final controlador = TextEditingController();
  final quantidadeController = TextEditingController();

  PageController pageController = PageController();

  int comunidadeSelecionada = 0;

  double altura = 350;
  double largura = 600;

  abrirTelaProdutos() {
    if (largura == 1000) {
      setState(() {
        altura = 350;
        largura = 600;
      });
    } else {
      setState(() {
        altura = 600;
        largura = 1000;
      });
    }
  }

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Card(
          color: Cores.branco,
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: SizedBox(
            height: altura,
            width: largura,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  abrirTelaProdutos();
                                  pageController.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Cores.cinzaEscuro,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(controlador.text.isEmpty
                                          ? "Selecione o Produto"
                                          : controlador.text),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DropDownForm(
                                label: "Comunidade",
                                itens: [],
                                selecionado: comunidadeSelecionada,
                                onChange: (valor) {
                                  setState(() => comunidadeSelecionada = valor);
                                }),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: campoTexto(
                              controlador: quantidadeController,
                              titulo: "Quantidade",
                              dica: "Quantidade do Produto",
                              tipo: TextInputType.number,
                              icone: CupertinoIcons.number,
                              mascara: MaskTextInputFormatter(),
                              temMascara: false,
                              validador: (value) {
                                if (value.isEmpty) {
                                  return "Campo Obrigatório";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: largura,
                  height: altura,
                  decoration: BoxDecoration(
                      color: Cores.branco,
                      borderRadius: BorderRadius.circular(10)),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Produtos(
                                selecionar: (produto) => setState(
                                    () => controlador.text = produto.proNome),
                                selecionarProduto: true),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              btnSecundario(
                                texto: "Voltar",
                                onPressed: () {
                                  abrirTelaProdutos();
                                  controlador.clear();
                                  pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                              ),
                              Spacer(),
                              btnPrimario(
                                texto: "Selecionar",
                                onPressed: () {
                                  abrirTelaProdutos();
                                  pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

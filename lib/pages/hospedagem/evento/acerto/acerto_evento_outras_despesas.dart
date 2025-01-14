import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/pages/estoque/produtos/produtos.dart';
import 'package:painel_ccmn/widgets/form/campo_busca.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';

import '../../../../classes/classes.dart';
import '../../../../widgets/form/campo_texto.dart';

class AcertoEventoOutrasDespesas extends StatefulWidget {
  const AcertoEventoOutrasDespesas({super.key});

  @override
  State<AcertoEventoOutrasDespesas> createState() =>
      _AcertoEventoOutrasDespesasState();
}

class _AcertoEventoOutrasDespesasState extends State<AcertoEventoOutrasDespesas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final controlador = TextEditingController();
  final quantidadeController = TextEditingController();

  int comunidadeSelecionada = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SizedBox(
                height: 350,
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: campoBusca(
                              controlador: controlador,
                              icone: CupertinoIcons.cube_box,
                              titulo: "Buscar Nome Produto",
                              busca: () async {
                                // (int, String) produtoSelecionado =
                                await Navigator.push(
                                    context,
                                    CupertinoDialogRoute(
                                        builder: (context) => Produtos(),
                                        context: context));
                                // if (produtoSelecionado.$1 != 0) {
                                //   setState(() =>
                                //       controlador.text = produtoSelecionado.$2);
                                // }
                              },
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
                ))),
      ),
    );
  }
}

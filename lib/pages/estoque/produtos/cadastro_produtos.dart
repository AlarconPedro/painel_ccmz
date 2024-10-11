import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../../classes/classes.dart';
import '../../../data/api/hospedagem/api_produtos.dart';
import '../../../data/data.dart';
import '../../../data/models/web/hospedagem/produto_model.dart';
import '../../../widgets/form/campo_texto.dart';

class CadastroProdutos extends StatefulWidget {
  const CadastroProdutos({super.key});

  @override
  State<CadastroProdutos> createState() => _CadastroProdutosState();
}

class _CadastroProdutosState extends State<CadastroProdutos> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController quantidadeMinimaController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  TextEditingController codigoBarrasController = TextEditingController();

  int categoriaSelecionada = 0;
  int medidaSelecionada = 0;

  List<DropdownMenuItem> categorias = [];
  List<DropdownMenuItem> medidas = [
    const DropdownMenuItem(
      value: 1,
      child: Text("Uni"),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text("Kg"),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text("Ltr"),
    ),
  ];

  bool carregando = false;

  buscarCategorias() async {
    setState(() => carregando = true);
    var response = await ApiCategoria().getCategorias();
    if (response.statusCode == 200) {
      print(response.body);
      categorias.clear();
      var decoded = json.decode(response.body);
      for (var item in decoded) {
        categorias.add(DropdownMenuItem(
          value: item['catCodigo'],
          child: Text(item['catNome']),
        ));
      }
    }
    setState(() => carregando = false);
  }

  // buscarMedidas() async {
  //   setState(() => carregando = true);
  //   var response = await ApiMedida().getMedidas();
  //   if (response.statusCode == 200) {
  //     medidas.clear();
  //     var decoded = json.decode(response.body);
  //     for (var item in decoded) {
  //       medidas.add(DropdownMenuItem(
  //         value: item['medCodigo'],
  //         child: Text(item['medNome']),
  //       ));
  //     }
  //   }
  //   setState(() => carregando = false);
  // }

  gravarProduto() async {
    setState(() => carregando = true);
    var produto = ProdutoModel(
      proNome: nomeController.text,
      proDescricao: descricaoController.text,
      proQuantidade: int.parse(quantidadeController.text),
      proValor: double.parse(valorController.text),
      // proMedida: medidas[medidaSelecionada].value,i
      proMedida: "Uni",
      proCodigo: 0,
      proCodBarras: codigoBarrasController.text,
      proQuantidadeMinima: int.parse(quantidadeMinimaController.text),
      proImagem: "",
      // proUniMedida: medidas[medidaSelecionada].value,
      proUniMedida: "Un",
      catCodigo: categoriaSelecionada,
    );
    var response = await ApiProdutos().addProduto(produto);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Produto Cadastrado com Sucesso"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao Cadastrar Produto"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    buscarCategorias();
    // buscarMedidas();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: _formKey,
      titulo: "Cadastro de Produtos",
      altura: 2,
      largura: 2.5,
      gravar: () {
        gravarProduto();
      },
      cancelar: () {},
      campos: carregando
          ? [const Expanded(child: Center(child: CarregamentoIOS()))]
          : [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: campoTexto(
                      controlador: nomeController,
                      titulo: "Nome",
                      dica: "Nome do Produto",
                      icone: CupertinoIcons.cube_box,
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
                  Expanded(
                    child: campoTexto(
                      controlador: codigoBarrasController,
                      titulo: "Código de Barras",
                      dica: "Código de Barras",
                      // icone: CupertinoIcons.barcode_viewfinder,
                      icone: CupertinoIcons.barcode,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: DropDownForm(
                        label: "Categoria",
                        itens: categorias,
                        selecionado: 0,
                        onChange: (value) {
                          categoriaSelecionada = value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: DropDownForm(
                        label: "Unidade de Medida",
                        itens: medidas,
                        selecionado: 0,
                        onChange: (value) {
                          medidaSelecionada = value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              Row(
                children: [
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
                  Expanded(
                    child: campoTexto(
                      controlador: quantidadeMinimaController,
                      titulo: "Quantidade Minima",
                      dica: "Quantidade Minima Produto",
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
                  Expanded(
                    flex: 2,
                    child: campoTexto(
                      controlador: valorController,
                      titulo: "Valor",
                      dica: "Valor do Produto",
                      tipo: TextInputType.number,
                      icone: CupertinoIcons.money_dollar,
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
              campoTexto(
                controlador: descricaoController,
                titulo: "Descrição",
                dica: "Descrição do Produto",
                mascara: MaskTextInputFormatter(),
                temMascara: false,
                icone: CupertinoIcons.text_badge_checkmark,
                validador: (value) {
                  // if (value.isEmpty) {
                  //   return "Campo Obrigatório";
                  // }
                  return null;
                },
              ),

              // CampoNumero(
              //   titulo: "Quantidade",
              //   dica: "Quantidade do Produto",
              //   icone: CupertinoIcons.number,
              //   validador: (value) {
              //     if (value.isEmpty) {
              //       return "Campo Obrigatório";
              //     }
              //     return null;
              //   },
              // ),
              // CampoNumero(
              //   titulo: "Valor",
              //   dica: "Valor do Produto",
              //   icone: CupertinoIcons.money_dollar,
              //   validador: (value) {
              //     if (value.isEmpty) {
              //       return "Campo Obrigatório";
              //     }
              //     return null;
              //   },
              // ),
            ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/models/web/promocoes/premios_mode.dart';
import 'package:painel_ccmn/widgets/dialogs/delete_dialog.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../../classes/classes.dart';
import '../../../data/api/promocao/api_promocao.dart';
import '../../../widgets/form/campo_texto.dart';

class Premios extends StatefulWidget {
  int codigoPromocao;
  Premios({super.key, required this.codigoPromocao});

  @override
  State<Premios> createState() => _PremiosState();
}

class _PremiosState extends State<Premios> {
  PageController pageController = PageController();

  final controlador = TextEditingController();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();

  bool carregando = false;

  List<PremiosModel> premios = [];

  buscarPremios(int codigoPromocao) async {
    setState(() => carregando = true);
    var retorno = await ApiPromocao().getPremiosPromocao(codigoPromocao);
    if (retorno.statusCode == 200) {
      premios.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        premios.add(PremiosModel.fromJson(item));
      }
    }
    setState(() => carregando = false);
  }

  PremiosModel preparaDados() {
    return PremiosModel(
      preNome: nomeController.text,
      preDescricao: descricaoController.text,
      proCodigo: widget.codigoPromocao,
      preCodigo: 0,
      proNome: '',
    );
  }

  cadastrarPremios() async {
    setState(() => carregando = true);
    var retorno = await ApiPromocao().addPremioPromocao(preparaDados());
    if (retorno.statusCode == 200) {
      nomeController.clear();
      descricaoController.clear();
      buscarPremios(widget.codigoPromocao);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao cadastrar prêmio'),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  deletarPremio(int codigo) async {
    setState(() => carregando = true);
    var retorno = await ApiPromocao().deletePremioPromocao(codigo);
    if (retorno.statusCode == 200) {
      buscarPremios(widget.codigoPromocao);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Prêmio deletado com sucesso'),
          backgroundColor: Cores.verdeMedio,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao deletar prêmio'),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  initState() {
    super.initState();
    buscarPremios(widget.codigoPromocao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Cores.branco,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Container(
              width: 700,
              height: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Cores.branco),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Prêmios",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 10, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: campoTexto(
                            titulo: "Prêmio",
                            dica: "Nome",
                            icone: Icons.person,
                            tipo: TextInputType.text,
                            temMascara: false,
                            mascara: MaskTextInputFormatter(
                                mask: "", filter: {"": RegExp(r'[a-zA-Z]')}),
                            validador: (value) {
                              // if (value.isEmpty) {
                              //   return "Campo Obrigatório";
                              // }
                              return null;
                            },
                            controlador: controlador,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CupertinoButton(
                          color: Cores.preto,
                          padding: const EdgeInsets.all(13),
                          onPressed: () {},
                          child: const Icon(
                            CupertinoIcons.search,
                            color: Cores.branco,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CupertinoButton(
                          color: Cores.verdeMedio,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: 30,
                          ),
                          onPressed: () {
                            pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Row(
                            children: [
                              Text(
                                "Adicionar",
                                style: TextStyle(
                                  color: Cores.branco,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                CupertinoIcons.add,
                                color: Cores.branco,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: carregando
                        ? const Center(child: CarregamentoIOS())
                        : PageView(
                            controller: pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              premios.isEmpty
                                  ? const Center(
                                      child: Text("Nenhum Prêmio Cadastrado !"))
                                  : Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: premios.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(
                                                      premios[index].preNome),
                                                  subtitle: Text(
                                                      premios[index].proNome),
                                                  trailing: IconButton(
                                                    icon: const Icon(
                                                      CupertinoIcons.delete,
                                                      color:
                                                          Cores.vermelhoMedio,
                                                    ),
                                                    onPressed: () async {
                                                      deleteDialog(
                                                        context: context,
                                                        excluir: () {
                                                          deletarPremio(
                                                              premios[index]
                                                                  .preCodigo);
                                                        },
                                                        titulo:
                                                            "Deletar Prêmio",
                                                        mensagem:
                                                            "Deseja deletar o prêmio ${premios[index].preNome} ?",
                                                      );
                                                    },
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      nomeController.text =
                                                          premios[index]
                                                              .preNome;
                                                      descricaoController.text =
                                                          premios[index]
                                                              .preDescricao;
                                                    });
                                                    pageController
                                                        .animateToPage(
                                                      1,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeIn,
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              CupertinoButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 30),
                                                color: Cores.vermelhoMedio,
                                                child: const Text(
                                                  'Fechar',
                                                  style: TextStyle(
                                                    color: Cores.branco,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 20,
                                    ),
                                    child: Text(
                                      'Cadastro de Prêmios',
                                      style: TextStyle(
                                        color: Cores.preto,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: campoTexto(
                                              titulo: 'Nome *',
                                              dica: 'Nome *',
                                              icone: CupertinoIcons.gift,
                                              temMascara: true,
                                              mascara: MaskTextInputFormatter(),
                                              validador: (value) {
                                                if (value.isEmpty) {
                                                  return 'Campo obrigatório';
                                                }
                                                return null;
                                              },
                                              controlador: nomeController,
                                            ),
                                          ),
                                          Expanded(
                                            child: campoTexto(
                                              titulo: 'Descrição',
                                              dica: 'Descrição',
                                              icone: Icons.person,
                                              temMascara: false,
                                              validador: (value) {
                                                return null;
                                              },
                                              controlador: descricaoController,
                                              mascara: MaskTextInputFormatter(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CupertinoButton(
                                          onPressed: () {
                                            setState(() {
                                              nomeController.clear();
                                              descricaoController.clear();
                                            });
                                            pageController.animateToPage(
                                              0,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn,
                                            );
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 30),
                                          color: Cores.vermelhoMedio,
                                          child: const Text(
                                            'Voltar',
                                            style: TextStyle(
                                              color: Cores.branco,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        CupertinoButton(
                                          onPressed: () {
                                            if (nomeController.text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Preencha os campos marcos com (*)'),
                                                  backgroundColor:
                                                      Cores.vermelhoMedio,
                                                ),
                                              );
                                              return;
                                            } else {
                                              cadastrarPremios();
                                            }
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          color: Cores.verdeMedio,
                                          child: carregando
                                              ? const CarregamentoIOS()
                                              : const Text(
                                                  'Cadastrar',
                                                  style: TextStyle(
                                                    color: Cores.branco,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
    );
  }
}

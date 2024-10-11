import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/data/api/promocao/api_promocao.dart';
import 'package:painel_ccmn/data/models/web/promocoes/participante_model.dart';
import 'package:painel_ccmn/funcoes/funcoes_mascara.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/cadastro_form.dart';
import 'package:painel_ccmn/pages/promocoes/promocoes/participantes/cadastro_participantes.dart';
import 'package:painel_ccmn/widgets/dialogs/delete_dialog.dart';
import 'package:painel_ccmn/widgets/form/campo_texto.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../../classes/classes.dart';

class Participantes extends StatefulWidget {
  int codigoPromocao;
  Participantes({super.key, required this.codigoPromocao});

  @override
  State<Participantes> createState() => _ParticipantesState();
}

class _ParticipantesState extends State<Participantes> {
  String titulo = "Participantes";

  TextEditingController controlador = TextEditingController();

  PageController pageController = PageController();

  List<ParticipanteModel> participantes = [];

  bool carregando = false;

  buscarParticipantes() async {
    setState(() => carregando = true);
    var retorno =
        await ApiPromocao().getParticipantesPromocao(widget.codigoPromocao);
    if (retorno.statusCode == 200) {
      participantes.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          participantes.add(ParticipanteModel.fromJson(item));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar participantes"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  deleteParticipante(int codigo) async {
    setState(() => carregando = true);
    var retorno = await ApiPromocao().deleteParticipantePromocao(codigo);
    if (retorno.statusCode == 200) {
      buscarParticipantes();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao deletar participante"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarParticipantes();
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
              height: 850,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Cores.branco),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Participantes",
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
                            titulo: titulo,
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
                        : Column(
                            children: [
                              Expanded(
                                child: PageView(
                                  controller: pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    participantes.isEmpty
                                        ? const Center(
                                            child: Text(
                                                "Nenhum Participante Encontrado !"))
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                  itemCount:
                                                      participantes.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      color: Cores.branco,
                                                      elevation: 5,
                                                      child: ListTile(
                                                        title: Text(
                                                            participantes[index]
                                                                .nome),
                                                        subtitle: Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  "CPF: ${FuncoesMascara.mascaraCpf(participantes[index].cpf)}"),
                                                              Text(
                                                                FuncoesMascara.mascaraTelefone(
                                                                    participantes[
                                                                            index]
                                                                        .telefone),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        trailing: MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors
                                                                  .click,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              deleteDialog(
                                                                  context:
                                                                      context,
                                                                  excluir: () {
                                                                    deleteParticipante(
                                                                        participantes[index]
                                                                            .codigo);
                                                                  },
                                                                  titulo:
                                                                      "Excluir",
                                                                  mensagem:
                                                                      "Deseja excluir o participante ${participantes[index].nome} ?");
                                                            },
                                                            child: const Icon(
                                                              CupertinoIcons
                                                                  .delete,
                                                              color: Cores
                                                                  .vermelhoMedio,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                    CadastroParticipantes(
                                      codigoPromocao: widget.codigoPromocao,
                                      listarParticipantes: () {
                                        pageController.animateToPage(
                                          0,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn,
                                        );
                                        buscarParticipantes();
                                      },
                                    ),
                                    // CadastroForm(
                                    //   formKey: GlobalKey<FormState>(),
                                    //   campos: const [],
                                    //   titulo: "Cadastro de Participantes",
                                    //   gravar: () {},
                                    //   cancelar: () {
                                    //     pageController.animateToPage(
                                    //       0,
                                    //       duration: const Duration(milliseconds: 300),
                                    //       curve: Curves.easeIn,
                                    //     );
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CupertinoButton(
                                      color: Cores.vermelhoMedio,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 30),
                                      onPressed: () {
                                        // pageController.page == 0
                                        // ?
                                        Navigator.pop(context);
                                        // : pageController.animateToPage(
                                        //     0,
                                        //     duration: const Duration(
                                        //         milliseconds: 300),
                                        //     curve: Curves.easeIn,
                                        //   );
                                      },
                                      child: const Text("Voltar"),
                                    ),
                                  ],
                                ),
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

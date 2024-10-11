import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../classes/classes.dart';
import '../../../data/api/promocao/api_promocao.dart';
import '../../../data/models/web/promocoes/participante_model.dart';
import '../../../funcoes/funcoes.dart';
import '../../../widgets/form/campo_texto.dart';

class CadastroParticipantes extends StatefulWidget {
  int codigoPromocao;
  Function() listarParticipantes;
  CadastroParticipantes(
      {super.key,
      required this.codigoPromocao,
      required this.listarParticipantes});

  @override
  State<CadastroParticipantes> createState() => _CadastroParticipantesState();
}

class _CadastroParticipantesState extends State<CadastroParticipantes> {
  ParticipanteModel participante = ParticipanteModel(
    parCidade: '',
    parCpf: '',
    parEmail: '',
    parEndereco: '',
    parNome: '',
    parCodigo: 0,
    parDataNasc: '',
    parFone: '',
    parUF: '',
    proCodigo: 0,
    codigo: 0,
    nome: '',
    telefone: '',
    cpf: '',
  );

  bool participanteCadastrado = false;
  bool carregando = false;

  MaskTextInputFormatter cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  MaskTextInputFormatter telefoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  TextEditingController cpfController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  TextEditingController cupomController = TextEditingController();

  ParticipanteModel alimentarCampos() {
    return ParticipanteModel(
      parCidade: cidadeController.text,
      parCpf: cpfController.text,
      parEmail: emailController.text,
      parEndereco: enderecoController.text,
      parNome: nomeController.text,
      parCodigo: 0,
      parDataNasc: FuncoesData.stringToDateTime(dataNascimentoController.text),
      parFone: telefoneController.text.replaceAll(RegExp(r'[^\d]'), ''),
      parUF: ufController.text,
      proCodigo: widget.codigoPromocao,
      codigo: 0,
      nome: nomeController.text,
      telefone: telefoneController.text.replaceAll(RegExp(r'[^\d]'), ''),
      cpf: cpfController.text,
    );
  }

  cadastrarParticipante() async {
    setState(() => carregando = true);
    var retorno =
        await ApiPromocao().addParticipantePromocao(alimentarCampos());
    if (retorno.statusCode == 200) {
      // setState(() => participanteCadastrado = true);
      widget.listarParticipantes();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao cadastrar participante"),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.branco,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            participanteCadastrado
                ? carregando
                    ? const Expanded(child: Center(child: CarregamentoIOS()))
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            const Text(
                              'Participante Cadastrado',
                              style: TextStyle(
                                color: Cores.preto,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    'CPF: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cpfFormatter.maskText(cpfController.text),
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    'Nome: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    nomeController.text,
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    'Data Nascimento: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    FuncoesData.dataFormatada(
                                        dataNascimentoController.text),
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    'Endereço: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    enderecoController.text,
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'E-mail: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    emailController.text,
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    'Telefone: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    telefoneFormatter
                                        .maskText(telefoneController.text),
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    'Cidade: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    cidadeController.text,
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    'UF: ',
                                    style: TextStyle(
                                      color: Cores.preto,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    ufController.text,
                                    style: const TextStyle(
                                      color: Cores.preto,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                : Expanded(
                    child: carregando
                        ? const Center(child: CarregamentoIOS())
                        : Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 20,
                                ),
                                child: Text(
                                  'Cadastro de Participantes',
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
                                        child:
                                            // Opacity(
                                            //   opacity: 0.5,
                                            //   child: AbsorbPointer(
                                            //     absorbing: true,
                                            //     child:
                                            campoTexto(
                                          titulo: 'CPF *',
                                          dica: 'CPF *',
                                          icone: Icons.person,
                                          temMascara: true,
                                          mascara: cpfFormatter,
                                          validador: (value) {
                                            if (value.isEmpty) {
                                              return 'Campo obrigatório';
                                            }
                                            return null;
                                          },
                                          controlador: cpfController,
                                        ),
                                        // ),
                                        // ),
                                      ),
                                      Expanded(
                                        child: campoTexto(
                                          titulo: 'Nome *',
                                          dica: 'Nome *',
                                          icone: Icons.person,
                                          temMascara: false,
                                          validador: (value) {
                                            if (value.isEmpty) {
                                              return 'Campo obrigatório';
                                            }
                                            return null;
                                          },
                                          controlador: nomeController,
                                          mascara: MaskTextInputFormatter(),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: campoTexto(
                                          titulo: 'Data Nascimento *',
                                          dica: 'Data Nascimento *',
                                          icone: Icons.calendar_today,
                                          temMascara: true,
                                          mascara: MaskTextInputFormatter(
                                            mask: '##/##/####',
                                            filter: {'#': RegExp(r'[0-9]')},
                                          ),
                                          validador: (value) {
                                            if (value.isEmpty) {
                                              return 'Campo obrigatório';
                                            }
                                            return null;
                                          },
                                          controlador: dataNascimentoController,
                                        ),
                                      ),
                                      Expanded(
                                        child: campoTexto(
                                          titulo: 'Telefone *',
                                          dica: 'Telefone *',
                                          icone: Icons.phone,
                                          temMascara: true,
                                          mascara: telefoneFormatter,
                                          validador: (value) {
                                            if (value.isEmpty) {
                                              return 'Campo obrigatório';
                                            }
                                            return null;
                                          },
                                          controlador: telefoneController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  campoTexto(
                                    titulo: 'Endereço',
                                    dica: 'Endereço',
                                    icone: Icons.location_on,
                                    temMascara: false,
                                    mascara: MaskTextInputFormatter(),
                                    validador: (value) {
                                      // if (value.isEmpty) {
                                      //   return 'Campo obrigatório';
                                      // }
                                      return null;
                                    },
                                    controlador: enderecoController,
                                  ),
                                  // CampoFormulario(
                                  //   label: 'Endereço',
                                  //   controller: enderecoController,
                                  //   mask: MaskTextInputFormatter(),
                                  // ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: campoTexto(
                                          titulo: 'Cidade *',
                                          dica: 'Cidade *',
                                          icone: Icons.location_city,
                                          temMascara: false,
                                          mascara: MaskTextInputFormatter(),
                                          validador: (value) {
                                            if (value.isEmpty) {
                                              return 'Campo obrigatório';
                                            }
                                            return null;
                                          },
                                          controlador: cidadeController,
                                        ),
                                      ),
                                      Expanded(
                                        child: campoTexto(
                                          titulo: 'UF *',
                                          dica: 'UF *',
                                          icone: Icons.location_city,
                                          temMascara: true,
                                          mascara: MaskTextInputFormatter(
                                            mask: '##',
                                            filter: {'#': RegExp(r'[a-z]')},
                                          ),
                                          validador: (value) {
                                            if (value.isEmpty) {
                                              return 'Campo obrigatório';
                                            }
                                            return null;
                                          },
                                          controlador: ufController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  campoTexto(
                                      titulo: 'E-mail',
                                      dica: 'E-mail',
                                      icone: Icons.email,
                                      temMascara: false,
                                      mascara: MaskTextInputFormatter(),
                                      validador: (value) {
                                        // if (value.isEmpty) {
                                        //   return 'Campo obrigatório';
                                        // }
                                        return null;
                                      },
                                      controlador: emailController),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: CupertinoButton(
                                  onPressed: () {
                                    // widget.onClique();
                                    cadastrarParticipante();
                                    if (nomeController.text.isEmpty ||
                                        cpfController.text.isEmpty ||
                                        dataNascimentoController.text.isEmpty ||
                                        // enderecoController.text.isEmpty ||
                                        // emailController.text.isEmpty ||
                                        telefoneController.text.isEmpty ||
                                        cidadeController.text.isEmpty ||
                                        ufController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Preencha os campos marcos com (*)'),
                                          backgroundColor: Cores.vermelhoMedio,
                                        ),
                                      );
                                      return;
                                    } else {
                                      // cadastrarParticipante();
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
                              ),
                            ],
                          ),
                  ),
            // SizedBox(height: 5),
            // widget.participante != null
            //     ? AbsorbPointer(
            //         absorbing: !participanteCadastrado,
            //         child: Opacity(
            //           opacity: !participanteCadastrado ? 0.5 : 1,
            //           child: Column(
            //             children: [
            //               const Padding(
            //                 padding: EdgeInsets.symmetric(
            //                     vertical: 5, horizontal: 10),
            //                 child: Text(
            //                   'Cadastro de Cupons',
            //                   style: TextStyle(
            //                     color: Cores.preto,
            //                     fontSize: 24,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     //Definir texto como sempre Maiusculo quando digitado
            //                     Expanded(
            //                       child: SizedBox(
            //                         height: 50,
            //                         child: TextField(
            //                           inputFormatters: [FormatarTexto()],
            //                           controller: cupomController,
            //                           decoration: InputDecoration(
            //                             labelText: "Cupom",
            //                             labelStyle: const TextStyle(
            //                               color: Cores.preto,
            //                               fontSize: 18,
            //                             ),
            //                             border: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(10),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: CupertinoButton(
            //                         onPressed: () {
            //                           cadastrarCupon();
            //                         },
            //                         padding: const EdgeInsets.symmetric(
            //                             vertical: 15, horizontal: 30),
            //                         color: Cores.verde,
            //                         child: const Text(
            //                           'Adicionar',
            //                           style: TextStyle(
            //                             color: Cores.branco,
            //                             fontSize: 18,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Row(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                       horizontal: 10,
            //                       vertical: 10,
            //                     ),
            //                     child: TextButton(
            //                       onPressed: () {
            //                         widget.listarCupons();
            //                       },
            //                       child: const Text(
            //                         "Meus Cupons >",
            //                         style: TextStyle(color: Cores.preto),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     : const SizedBox(),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 10,
            //         vertical: 10,
            //       ),
            //       child: CupertinoButton(
            //         color: Cores.vermelho,
            //         padding: const EdgeInsets.symmetric(
            //           vertical: 5,
            //           horizontal: 30,
            //         ),
            //         onPressed: () {
            //           widget.onClique();
            //         },
            //         child: const Text(
            //           "Voltar",
            //           style: TextStyle(color: Cores.branco),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

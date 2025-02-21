import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/models/web/hospedagem/paroquia_model.dart';
import 'package:painel_ccmn/pages/hospedagem/paroquia/cadastro_paroquia.dart';
import 'package:painel_ccmn/widgets/cards/base/card_base_listagem.dart';
import 'package:painel_ccmn/widgets/cards/btn_opcoes_card.dart';
import 'package:painel_ccmn/widgets/dialogs/delete_dialog.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';
import 'package:painel_ccmn/widgets/telas/modelo_listagem_cadastro.dart';

import '../../../classes/classes.dart';
import '../../../data/api/hospedagem/api_paroquia.dart';
import '../../../data/data.dart';
import '../../../widgets/textos/textos.dart';

class Paroquia extends StatefulWidget {
  bool selecionado;
  Function(int, String, String)? selecionarparoquia;
  Paroquia({super.key, this.selecionado = false, this.selecionarparoquia});

  @override
  State<Paroquia> createState() => _ParoquiaState();
}

class _ParoquiaState extends State<Paroquia> {
  TextEditingController ctlrBusca = TextEditingController();

  bool carregando = false;

  List<ParoquiaModel> listaParoquias = [];

  List<DropdownMenuItem> listaUfs = [];
  List<DropdownMenuItem> cidades = [];

  List<Map<int, String>> cidadesList = [];

  int paroquiaSelecionada = 0;
  int ufSelecinado = 0;

  buscarParoquias() async {
    setState(() => carregando = true);
    var retorno = await ApiParoquia()
        .buscarParoquias(ctlrBusca.text.isEmpty ? "Todos" : ctlrBusca.text);
    if (retorno.statusCode == 200) {
      var dados = json.decode(retorno.body);
      listaParoquias =
          dados.map<ParoquiaModel>((e) => ParoquiaModel.fromJson(e)).toList();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao carregar as Paróquias!"),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => carregando = false);
  }

  buscarCidades() async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiComunidade().getCidades();
    if (retorno.statusCode == 200) {
      cidades.clear();
      cidades.add(const DropdownMenuItem(value: 0, child: Text("Todos")));
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          cidades.add(DropdownMenuItem(
              value: decoded.indexOf(item) + 1, child: Text(item)));
          cidadesList.add({decoded.indexOf(item) + 1: item});
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer cidades !"),
        ),
      );
    }
    setState(() {
      carregando = false;
    });
  }

  excluirParoquia(int codigoParoquia) async {
    setState(() => carregando = true);
    var retorno = await ApiParoquia().excluirParoquia(codigoParoquia);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Paróquia excluída com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
      buscarParoquias();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao excluir a Paróquia!"),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarParoquias();
  }

  @override
  Widget build(BuildContext context) {
    return modeloListagemCadastro(
      fncBusca: () => buscarParoquias(),
      fncAbrirCadastro: () async => {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
              builder: (context) => CadastroParoquia(paroquia: null),
              context: context),
        ),
        buscarParoquias()
      },
      ctlrBusca: ctlrBusca,
      listaDados: listaParoquias,
      filtros: SizedBox(
        width: double.infinity,
        height: 50,
        child: SizedBox(
          width: 100,
          child: DropDownForm(
            label: "UF",
            itens: listaUfs,
            selecionado: ufSelecinado,
            onChange: (value) {
              setState(() {
                ufSelecinado = value;
                buscarCidades();
                buscarParoquias();
              });
            },
          ),
        ),
      ),
      // filtros: SizedBox(
      //   height: 50,
      //   width: double.infinity,
      //   child: Row(
      //     children: [
      //       DropDownForm(
      //         label: "UF",
      //         itens: listaUfs,
      //         selecionado: ufSelecinado,
      //         onChange: (value) {
      //           setState(() {
      //             ufSelecinado = value;
      //             buscarCidades();
      //             buscarParoquias();
      //           });
      //         },
      //       )
      //     ],
      //   ),
      // ),
      cardListagem: (dados) => widget.selecionado
          ? MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    paroquiaSelecionada = dados.prqCodigo;
                    widget.selecionarparoquia!(dados.prqCodigo, dados.prqNome,
                        "${dados.prqCidade} - ${dados.prqUF}");
                  });
                  // await Navigator.push(
                  //   context,
                  //   CupertinoDialogRoute(
                  //       builder: (context) => CadastroParoquia(
                  //             paroquia: dados,
                  //           ),
                  //       context: context),
                  // );
                  // buscarParoquias();
                },
                child: CardBaseListagem(
                  cor: paroquiaSelecionada == dados.prqCodigo
                      ? Cores.verdeMedio
                      : null,
                  btnsOpcoes: [
                    BtnOpcoesCard(
                      dialog: () => deleteDialog(
                          context: context,
                          excluir: () => excluirParoquia(dados.prqCodigo),
                          titulo: 'Excluir Paróquia',
                          mensagem: 'Deseja realmente excluir a Paróquia?'),
                      icone: CupertinoIcons.delete,
                      cor: Cores.vermelhoMedio,
                    )
                  ],
                  camposCard: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                          child: Textos.textoPequeno(texto: dados.prqNome)),
                      Expanded(
                          child: Textos.textoPequeno(texto: dados.prqCidade)),
                      Expanded(child: Textos.textoPequeno(texto: dados.prqUF)),
                    ],
                  ),
                ),
              ),
            )
          : MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    CupertinoDialogRoute(
                        builder: (context) => CadastroParoquia(paroquia: dados),
                        context: context),
                  );
                  buscarParoquias();
                },
                child: CardBaseListagem(
                  btnsOpcoes: [
                    BtnOpcoesCard(
                      dialog: () => deleteDialog(
                          context: context,
                          excluir: () => excluirParoquia(dados.prqCodigo),
                          titulo: 'Excluir Paróquia',
                          mensagem: 'Deseja realmente excluir a Paróquia?'),
                      icone: CupertinoIcons.delete,
                      cor: Cores.vermelhoMedio,
                    )
                  ],
                  camposCard: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                          child: Textos.textoPequeno(texto: dados.prqNome)),
                      Expanded(
                          child: Textos.textoPequeno(texto: dados.prqCidade)),
                      Expanded(child: Textos.textoPequeno(texto: dados.prqUF)),
                    ],
                  ),
                ),
              ),
            ),
      tituloColunas: Row(
        children: [
          const SizedBox(width: 30),
          Expanded(child: Textos.textoPequeno(texto: 'Nome')),
          Expanded(child: Textos.textoPequeno(texto: 'Cidade')),
          Expanded(child: Textos.textoPequeno(texto: 'UF')),
          Textos.textoPequeno(texto: 'Excluir'),
          const SizedBox(width: 20),
        ],
      ),
      titulo: "Paróquias",
      btnTitulo: "Nova Paróquia",
      carregando: carregando,
      context: context,
    );
  }
}

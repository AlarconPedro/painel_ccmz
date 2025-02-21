import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/hospedagem/paroquia/paroquia.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/form/dropdown_form.dart';

import '../../../classes/classes.dart';
import '../../../widgets/botoes/btn_primario.dart';
import '../../../widgets/botoes/btn_secundario.dart';
import '../../../widgets/separador.dart';

class CadastroComunidade extends StatefulWidget {
  ComunidadeModel? comunidade;

  CadastroComunidade({super.key, this.comunidade});

  @override
  State<CadastroComunidade> createState() => _CadastroComunidadeState();
}

class _CadastroComunidadeState extends State<CadastroComunidade> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController ufController = TextEditingController();

  bool carregando = false;

  List<DropdownMenuItem<dynamic>> paroquiaListar = [];

  int codigoParoquiaSelecionada = 0;

  (int, String, String) paroquiaSelecionada = (0, "", "");

  preparaDados() {
    if (widget.comunidade != null) {
      return ComunidadeModel(
        comCodigo: widget.comunidade!.comCodigo,
        comNome: nomeController.text,
        prqCodigo: paroquiaSelecionada.$1,
        comCidade: paroquiaSelecionada.$3,
        comUF: ufController.text,
        qtdPessoas: widget.comunidade!.qtdPessoas,
      );
    }

    return ComunidadeModel(
      comCodigo: 0,
      comNome: nomeController.text,
      prqCodigo: codigoParoquiaSelecionada,
      comCidade: paroquiaSelecionada.$3,
      comUF: ufController.text,
      qtdPessoas: 0,
    );
  }

  gravarComunidade() async {
    setState(() => carregando = true);
    var retorno = await ApiComunidade().addComunidade(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Comunidade cadastrada com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao cadastrar comunidade !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  atualizarComunidade() async {
    setState(() => carregando = true);
    var retorno = await ApiComunidade().updateComunidade(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Comunidade atualizada com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao atualizar comunidade !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  alimentaCampos() {
    setState(() {
      nomeController.text = widget.comunidade!.comNome;
      codigoParoquiaSelecionada = widget.comunidade!.prqCodigo;
      paroquiaSelecionada = (
        widget.comunidade!.prqCodigo,
        widget.comunidade!.comNome,
        widget.comunidade!.comCidade
      );
      // cidadeController.text = widget.comunidade!.comCidade;
      // ufController.text = widget.comunidade!.comUF;
    });
  }

  selecionarParoquia() {
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
          child: Column(children: [
            Expanded(
              child: Paroquia(
                  selecionado: true,
                  selecionarparoquia: (codigo, nome, cidade) {
                    setState(
                        () => paroquiaSelecionada = (codigo, nome, cidade));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  btnSecundario(
                      texto: "Fechar", onPressed: () => Navigator.pop(context)),
                  separador(),
                  btnPrimario(
                    texto: "Selecionar",
                    onPressed: () =>
                        Navigator.pop(context, codigoParoquiaSelecionada),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.comunidade != null) alimentaCampos();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: _formKey,
      titulo: "Cadastro de comunidade",
      altura: 4.3,
      largura: 2,
      campos: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: nomeController,
                  // maxLength: 255,
                  decoration: const InputDecoration(
                    labelText: 'Nome da comunidade',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Cores.cinzaEscuro,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o nome da comunidade';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Container(
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
                          builder: (context) => selecionarParoquia(),
                          context: context,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: paroquiaSelecionada.$2.isNotEmpty
                                  ? Cores.verdeMedio
                                  : Cores.cinzaClaro,
                              border:
                                  Border.all(color: Cores.cinzaMedio, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: paroquiaSelecionada.$2.isEmpty
                                ? Center(
                                    child: Text(
                                      "Selecione a Paróquia",
                                      style: TextStyle(
                                          color: paroquiaSelecionada.$2.isEmpty
                                              ? Cores.preto
                                              : Cores.branco),
                                    ),
                                  )
                                : Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          paroquiaSelecionada.$2,
                                          style: TextStyle(
                                              color:
                                                  paroquiaSelecionada.$2.isEmpty
                                                      ? Cores.preto
                                                      : Cores.branco),
                                        ),
                                        Text(
                                          paroquiaSelecionada.$3,
                                          style: TextStyle(
                                              color:
                                                  paroquiaSelecionada.$2.isEmpty
                                                      ? Cores.preto
                                                      : Cores.branco),
                                        ),
                                      ],
                                    ),
                                  )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      gravar: () {
        widget.comunidade == null ? gravarComunidade() : atualizarComunidade();
      },
      cancelar: () {
        Navigator.pop(context);
      },
    );
  }
}

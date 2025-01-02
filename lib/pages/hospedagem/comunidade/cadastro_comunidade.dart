import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../../classes/classes.dart';

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

  preparaDados() {
    if (widget.comunidade != null) {
      return ComunidadeModel(
        comCodigo: widget.comunidade!.comCodigo,
        comNome: nomeController.text,
        comCidade: cidadeController.text,
        comUF: ufController.text,
        qtdPessoas: widget.comunidade!.qtdPessoas,
      );
    }

    return ComunidadeModel(
      comCodigo: 0,
      comNome: nomeController.text,
      comCidade: cidadeController.text,
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
      cidadeController.text = widget.comunidade!.comCidade;
      ufController.text = widget.comunidade!.comUF;
    });
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
      altura: 4.5,
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
                  maxLength: 255,
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
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: cidadeController,
                  maxLength: 255,
                  decoration: const InputDecoration(
                    labelText: 'Cidade',
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
                      return 'Por favor, digite o nome da cidade da comunidade';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: TextFormField(
                  controller: ufController,
                  maxLength: 2,
                  decoration: const InputDecoration(
                    labelText: 'UF',
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
                      return 'Por favor, digite o UF comunidade';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ],
      gravar: () {
        widget.comunidade == null ? gravarComunidade() : atualizarComunidade();
      },
      cancelar: () {
        // Navigator.pop(context);
      },
    );
  }
}

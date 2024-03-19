import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/esqueleto/cadastro_form.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';

class CadastroPessoas extends StatefulWidget {
  PessoaModel? pessoa;

  CadastroPessoas({super.key, this.pessoa});

  @override
  State<CadastroPessoas> createState() => _CadastroPessoasState();
}

class _CadastroPessoasState extends State<CadastroPessoas> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nomeController = TextEditingController();

  int comunidadeSelecionada = 0;
  int sexoSelecionado = 0;

  bool catequista = false;
  bool responsavel = false;
  bool salmista = false;

  List<DropdownMenuItem> listaSexo = [
    const DropdownMenuItem(
      value: 1,
      child: Text("Masculino"),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text("Feminino"),
    ),
  ];

  List<DropdownMenuItem> listaComunidade = [];

  bool carregando = false;

  preparaDados() {
    if (widget.pessoa != null) {
      return PessoaModel(
        pesCodigo: widget.pessoa!.pesCodigo,
        pesNome: nomeController.text,
        comCodigo: comunidadeSelecionada,
        pesGenero: sexoSelecionado == 1 ? "M" : "F",
        comunidade: "",
        pesCatequista: catequista ? "S" : "N",
        pesResponsavel: responsavel ? "S" : "N",
        pesSalmista: salmista ? "S" : "N",
        pesObservacao: "",
      );
    } else {
      return PessoaModel(
        pesCodigo: 0,
        pesNome: nomeController.text,
        comCodigo: comunidadeSelecionada,
        pesGenero: sexoSelecionado == 1 ? "M" : "F",
        comunidade: "",
        pesCatequista: catequista ? "S" : "N",
        pesResponsavel: responsavel ? "S" : "N",
        pesSalmista: salmista ? "S" : "N",
        pesObservacao: "",
      );
    }
  }

  alimentaCampos() {
    setState(() => carregando = true);
    nomeController.text = widget.pessoa!.pesNome;
    comunidadeSelecionada = widget.pessoa!.comCodigo;
    sexoSelecionado = widget.pessoa!.pesGenero == "M" ? 1 : 2;
    catequista = widget.pessoa!.pesCatequista == "S" ? true : false;
    responsavel = widget.pessoa!.pesResponsavel == "S" ? true : false;
    salmista = widget.pessoa!.pesSalmista == "S" ? true : false;
    setState(() => carregando = false);
  }

  buscarComunidade() async {
    setState(() => carregando = true);
    var retorno = await ApiComunidade().getComunidades("Todos");
    if (retorno.statusCode == 200) {
      listaComunidade.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          listaComunidade.add(
            DropdownMenuItem(
              value: item['comCodigo'],
              child: Text(item['comNome'] +
                  " - " +
                  item['comCidade'] +
                  " - " +
                  item['comUf']),
            ),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer comunidades !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  gravarPessoa() async {
    setState(() => carregando = true);
    var retorno = await ApiPessoas().addPessoa(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Pessoa cadastrada com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao cadastrar pessoa !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  atualizarPessoa() async {
    setState(() => carregando = true);
    var retorno = await ApiPessoas().updatePessoa(preparaDados());
    if (retorno.statusCode == 200) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Pessoa atualizada com sucesso !"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao atualizar pessoa !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarComunidade();
    if (widget.pessoa != null) alimentaCampos();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: _formKey,
      titulo: "Cadastro de Pessoas",
      altura: 3.7,
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
                  decoration: const InputDecoration(
                    labelText: 'Nome',
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
                      return 'Por favor, digite o nome da pessoa';
                    }
                    return null;
                  },
                ),
              ),
            ),
            carregando
                ? const Expanded(
                    flex: 4,
                    child: Center(child: CarregamentoIOS()),
                  )
                : Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonFormField(
                        value: widget.pessoa != null &&
                                widget.pessoa!.comCodigo != 0
                            ? widget.pessoa!.comCodigo
                            : comunidadeSelecionada,
                        decoration: const InputDecoration(
                          labelText: 'Comunidade',
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
                        items: listaComunidade,
                        onChanged: (value) {
                          setState(() {
                            comunidadeSelecionada = value;
                          });
                        },
                      ),
                    ),
                  ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Sexo',
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
                  items: listaSexo,
                  onChanged: (value) {
                    setState(() {
                      sexoSelecionado = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Catequista",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                    value: catequista,
                    onChanged: (value) {
                      setState(() => catequista = value!);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Responsável",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                    value: responsavel,
                    onChanged: (value) {
                      setState(() => responsavel = value!);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Salmista",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  CupertinoCheckbox(
                    value: salmista,
                    onChanged: (value) {
                      setState(() => salmista = value!);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
      gravar: () {
        if (_formKey.currentState!.validate()) {
          if (widget.pessoa != null) {
            atualizarPessoa();
          } else {
            gravarPessoa();
          }
        }
/*         gravarPessoa();
 */
      },
      cancelar: () {
        // Navigator.pop(context);
      },
    );
  }
}

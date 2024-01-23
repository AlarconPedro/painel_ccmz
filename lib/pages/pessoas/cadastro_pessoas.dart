import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/pages/esqueleto/cadastro_form.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class CadastroPessoas extends StatefulWidget {
  const CadastroPessoas({super.key});

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
    return PessoaModel(
      pesCodigo: 0,
      pesNome: nomeController.text,
      comCodigo: comunidadeSelecionada,
      pesGenero: sexoSelecionado == 1 ? "M" : "F",
      comunidade: "",
      pesCatequista: false ? "S" : "N",
      pesResponsavel: false ? "S" : "N",
      pesSalmista: false ? "S" : "N",
      pesObservacao: "",
    );
  }

  buscarComunidade() async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiComunidade().getComunidades();
    if (retorno.statusCode == 200) {
      listaComunidade.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          listaComunidade.add(
            DropdownMenuItem(
              value: item['comCodigo'],
              child: Text(item['comNome']),
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
    setState(() {
      carregando = false;
    });
  }

  gravarPessoa() async {
    setState(() {
      carregando = true;
    });
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
    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarComunidade();
  }

  @override
  Widget build(BuildContext context) {
    return CadastroForm(
      formKey: _formKey,
      titulo: "Cadastro de Pessoas",
      altura: 4,
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
              flex: 3,
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
        gravarPessoa();
      },
      cancelar: () {
        // Navigator.pop(context);
      },
    );
  }
}

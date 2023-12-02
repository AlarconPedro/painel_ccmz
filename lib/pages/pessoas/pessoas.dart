import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/cores.dart';
import '../../data/data.dart';

class Pessoas extends StatefulWidget {
  const Pessoas({super.key});

  @override
  State<Pessoas> createState() => _PessoasState();
}

class _PessoasState extends State<Pessoas> {
  bool carregando = false;

  List<PessoaModel> pessoas = [];

  buscarPessoas() async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiPessoas().getPessoas();
    if (retorno.statusCode == 200) {
      pessoas.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          pessoas.add(PessoaModel.fromJson(item));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer pessoas !"),
        ),
      );
    }
    setState(() {
      carregando = false;
    });
  }

  excluirPessoa(int codigoPessoa) async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiPessoas().deletePessoa(codigoPessoa);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Pessoa excluída com sucesso !"),
        ),
      );
      buscarPessoas();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao excluir pessoa !"),
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
    buscarPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 10,
            color: Cores.branco,
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Cores.branco,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          const Text(
                            "Buscar: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 55,
                              child: CupertinoTextField(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  border: Border.all(
                                    color: Cores.cinzaEscuro,
                                  ),
                                ),
                                placeholder: 'Pesquisar',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CupertinoButton(
                            color: Cores.preto,
                            onPressed: () {},
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            child: const Icon(CupertinoIcons.search),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        const Text(
                          'Pessoas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        CupertinoButton(
                          color: Cores.verdeMedio,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 30,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              CupertinoDialogRoute(
                                builder: (context) {
                                  return const CadastroPessoas();
                                },
                                context: context,
                              ),
                            );
                            buscarPessoas();
                          },
                          child: const Text("Nova Pessoa"),
                        ),
                      ]),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        thickness: 1,
                        color: Cores.preto,
                      ),
                    ),
                    const Row(children: [
                      SizedBox(width: 55),
                      Expanded(
                        flex: 4,
                        child: Text("Nome",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Sexo",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        flex: 2,
                        child: Text("Comuniade",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 50),
                      Expanded(
                        flex: 2,
                        child: Text("Responsável",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Catequista",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("Salmista",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Text("Excluir",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 25),
                    ]),
                    carregando
                        ? const Expanded(
                            child: Center(child: CarregamentoIOS()))
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: ListView.builder(
                                itemCount: pessoas.length,
                                itemBuilder: (context, index) {
                                  return MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: CardPessoa(
                                        pessoa: pessoas[index],
                                        excluir: () {
                                          excluirPessoa(
                                              pessoas[index].pesCodigo);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

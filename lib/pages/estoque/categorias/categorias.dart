import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/pages.dart';

import '../../../classes/classes.dart';
import '../../../data/data.dart';

class Categorias extends StatefulWidget {
  const Categorias({super.key});

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  bool carregando = false;

  List<CategoriaModel> categorias = [];

  buscarCategorias() async {
    setState(() => carregando = true);
    var retorno = await ApiCategoria().getCategorias();
    if (retorno.statusCode == 200) {
      categorias.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => categorias.add(CategoriaModel.fromJson(item)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer categorias !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      label: "Categorias",
      tituloBoto: "Nova Categoria",
      tituloPagina: "Categorias",
      filtro: false,
      buscaNome: (busca) {},
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => CadastroCategorias(),
            context: context,
          ),
        );
      },
      corpo: [
        if (carregando)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          DataTable(
            columns: const [
              DataColumn(label: Text("Código")),
              DataColumn(label: Text("Nome")),
              DataColumn(label: Text("Ações")),
            ],
            rows: categorias
                .map(
                  (categoria) => DataRow(
                    cells: [
                      DataCell(Text(categoria.catCodigo.toString())),
                      DataCell(Text(categoria.catNome)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  CupertinoDialogRoute(
                                    builder: (context) => CadastroCategorias(
                                      categoria: categoria,
                                    ),
                                    context: context,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                // var retorno = await ApiCategoria()
                                //     .deleteCategoria(categoria.catCodigo);
                                // if (retorno.statusCode == 200) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       backgroundColor: Cores.verdeEscuro,
                                //       content: Text(
                                //           "Categoria excluida com sucesso !"),
                                //     ),
                                //   );
                                buscarCategorias();
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       backgroundColor: Cores.vermelhoMedio,
                                //       content:
                                //           Text("Erro ao excluir categoria !"),
                                //     ),
                                //   );
                                // }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

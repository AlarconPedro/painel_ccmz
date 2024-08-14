import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/models/produto_model.dart';
import 'package:painel_ccmn/pages/hospedagem/esqueleto/esqueleto.dart';

import '../../../data/api/api_produtos.dart';

class Produtos extends StatefulWidget {
  const Produtos({super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
  List<ProdutoModel> produtos = [];

  bool carregando = false;

  buscarProdutos() async {
    setState(() => carregando = true);
    var retorno = await ApiProdutos().getProdutos();
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.data);
      produtos.add(ProdutoModel.fromJson(decoded));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erro ao buscar produtos"),
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
    buscarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Produto",
      tituloPagina: "Produtos",
      buscaNome: (busca) {},
      abrirTelaCadastro: () {
        // Navigator.push(
        //   context,
        //   CupertinoDialogRoute(
        //     builder: (context) => const CadastroProdutos(),
        //     context: context,
        //   ),
        // );
      },
      corpo: [
        carregando
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: produtos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(produtos[index].proNome),
                    subtitle: Text(produtos[index].proDescricao),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   CupertinoDialogRoute(
                        //     builder: (context) => CadastroProdutos(
                        //       produto: produtos[index],
                        //     ),
                        //     context: context,
                        //   ),
                        // );
                      },
                    ),
                  );
                },
              ),
      ],
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/api/api_relatorio.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../../classes/classes.dart';
import '../../../data/models/web/relatorios/produtos_acabando_model.dart';

class Relatorios extends StatefulWidget {
  const Relatorios({super.key});

  @override
  State<Relatorios> createState() => _RelatoriosState();
}

class _RelatoriosState extends State<Relatorios> {
  List<ProdutosAcabandoModel> produtosAcabando = [];

  bool carregando = false;

  buscarRelatorioProdutosAcabando() async {
    setState(() => carregando = true);
    var retorno = await ApiRelatorio().getRelatorioProdutosAcabando();
    if (retorno.statusCode == 200) {
      produtosAcabando.clear();
      for (var item in json.decode(retorno.body)) {
        produtosAcabando.add(ProdutosAcabandoModel.fromJson(item));
        // }
        // produtosAcabando = (json.decode(retorno.body))
        //     .map((e) => ProdutosAcabandoModel.fromJson(e))
        //     .toList();
      }
    } else {
      produtosAcabando.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao buscar produtos acabando'),
          backgroundColor: Cores.vermelhoMedio,
        ),
      );
    }
    setState(() => carregando = false);
    // produtosAcabando = [
    //   ProdutosAcabandoModel(
    //     proCodigo: 1,
    //     proNome: 'Produto 1',
    //     proImagem: 'imagem1.jpg',
    //     proValor: 10.0,
    //     proMedida: 'Medida 1',
    //     proUniMedida: 'Unidade 1',
    //     proQuantidade: 10,
    //     proDescricao: 'Descrição 1',
    //   ),
    //   ProdutosAcabandoModel(
    //     proCodigo: 2,
    //     proNome: 'Produto 2',
    //     proImagem: 'imagem2.jpg',
    //     proValor: 20.0,
    //     proMedida: 'Medida 2',
    //     proUniMedida: 'Unidade 2',
    //     proQuantidade: 20,
    //     proDescricao: 'Descrição 2',
    //   ),
    //   ProdutosAcabandoModel(
    //     proCodigo: 3,
    //     proNome: 'Produto 3',
    //     proImagem: 'imagem3.jpg',
    //     proValor: 30.0,
    //     proMedida: 'Medida 3',
    //     proUniMedida: 'Unidade 3',
    //     proQuantidade: 30,
    //     proDescricao: 'Descrição 3',
    //   ),
    // ];
  }

  @override
  initState() {
    super.initState();
    buscarRelatorioProdutosAcabando();
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Cores.branco,
              ),
              child: carregando
                  ? const Center(child: CarregamentoIOS())
                  : Column(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Produtos Acabando',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: DataTable(
                            dataTextStyle: const TextStyle(fontSize: 14),
                            headingTextStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            columns: const [
                              DataColumn(label: Text('Código')),
                              DataColumn(label: Text('Nome')),
                              // DataColumn(label: Text('Imagem')),
                              DataColumn(label: Text('Quantidade')),
                              DataColumn(label: Text('Valor')),
                              DataColumn(label: Text('Medida')),
                              DataColumn(label: Text('Unidade')),
                              DataColumn(label: Text('Descrição')),
                            ],
                            rows: produtosAcabando
                                .map(
                                  (e) => DataRow(
                                    cells: [
                                      DataCell(Text(e.proCodigo.toString())),
                                      DataCell(Text(e.proNome)),
                                      // DataCell(Text(e.proImagem)),
                                      DataCell(
                                          Text(e.proQuantidade.toString())),
                                      DataCell(Text(e.proValor.toString())),
                                      DataCell(Text(e.proMedida)),
                                      DataCell(Text(e.proUniMedida)),

                                      DataCell(Text(e.proDescricao)),
                                    ],
                                  ),
                                )
                                .toList(),
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

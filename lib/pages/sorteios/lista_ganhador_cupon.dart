import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/widgets/cards/sorteio/card_cupons.dart';
import 'package:painel_ccmn/widgets/cards/sorteio/card_promocao.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../classes/classes.dart';
import '../../data/api/promocao/api_promocao.dart';
import '../../models/ganhador_model.dart';

class ListaGanhadorCupon extends StatefulWidget {
  const ListaGanhadorCupon({super.key});

  @override
  State<ListaGanhadorCupon> createState() => _ListaGanhadorCuponState();
}

class _ListaGanhadorCuponState extends State<ListaGanhadorCupon> {
  List<GanhadorModel> ganhador = [];

  final TextEditingController busca = TextEditingController();

  bool carregando = false;

  buscarGanhador(String filtro,
      {String? cupom, int? skip = 0, int? take = 30}) async {
    setState(() => carregando = true);
    var response = await ApiPromocao()
        .getGanhadorCupom(filtro, cupom: cupom, skip: skip, take: take);
    if (response.statusCode == 200) {
      for (var item in json.decode(response.body)) {
        ganhador.add(GanhadorModel.fromJson(item));
      }
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarGanhador('T');
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
                              controller: busca,
                              onSubmitted: (value) async {
                                if (busca.text.isNotEmpty) {
                                  await buscarGanhador(value);
                                  busca.clear();
                                }
                              },
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
                          onPressed: () async {
                            if (busca.text.isNotEmpty) {
                              await buscarGanhador(busca.text);
                              busca.clear();
                            }
                          },
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      Text(
                        "Cupons",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                    ]),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 1,
                      color: Cores.preto,
                    ),
                  ),
                  Expanded(
                    child: carregando
                        ? const Center(child: CarregamentoIOS())
                        : ganhador.isEmpty
                            ? const Center(
                                child: Text("Nenhum Cupom Encontrado !"))
                            : ListView.builder(
                                itemCount: ganhador.length,
                                itemBuilder: (context, index) {
                                  return cardCupons(
                                    onTap: () {},
                                    context: context,
                                    nome: ganhador[index].parNome,
                                    ganhador: ganhador[index].cupNumero,
                                    data: ganhador[index].parCidade,
                                    // abrirCupons: () {},
                                    // abrirParticipantes: () {},
                                  );
                                  // return ListTile(
                                  //   title: Text(ganhador[index].parNome),
                                  //   subtitle: Text(ganhador[index].cupNumero),
                                  //   trailing: IconButton(
                                  //     icon: const Icon(CupertinoIcons.delete),
                                  //     onPressed: () async {
                                  //       // await deletarCupon(cupons[index].id);
                                  //     },
                                  //   ),
                                  // );
                                },
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

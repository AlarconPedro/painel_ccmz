import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../classes/classes.dart';
import '../../../../data/api/promocao/api_promocao.dart';
import '../../../../data/models/web/promocoes/ganhador_cupom_model.dart';
import '../../../../widgets/cards/sorteio/card_cupons.dart';
import '../../../../widgets/widgets.dart';

class Cupons extends StatefulWidget {
  const Cupons({super.key});

  @override
  State<Cupons> createState() => _CuponsState();
}

class _CuponsState extends State<Cupons> {
  List<GanhadorCupomModel> ganhador = [];

  final TextEditingController busca = TextEditingController();

  bool carregando = false;

  buscarGanhador(String filtro,
      {String? cupom, int? skip = 0, int? take = 30}) async {
    setState(() => carregando = true);
    var response = await ApiPromocao()
        .getGanhadorCupom(filtro, cupom: cupom, skip: skip, take: take);
    if (response.statusCode == 200) {
      ganhador.clear();
      for (var item in json.decode(response.body)) {
        ganhador.add(GanhadorCupomModel.fromJson(item));
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
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Cores.branco,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Expanded(
                    child: carregando
                        ? const Center(child: CarregamentoIOS())
                        : ganhador.isEmpty
                            ? const Center(
                                child: Text("Nenhum Cupom Encontrado !"))
                            : Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListView.builder(
                                  itemCount: ganhador.length,
                                  itemBuilder: (context, index) {
                                    return cardCupons(
                                      onTap: () {},
                                      context: context,
                                      nome: ganhador[index].parNome,
                                      telefone: ganhador[index].parFone,
                                      ganhador: ganhador[index].cupNumero,
                                      data: ganhador[index].parCidade,
                                    );
                                  },
                                ),
                              ),
                  ),
                  SizedBox(
                    height: 65,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            color: Cores.vermelhoMedio,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Voltar"),
                          ),
                          Text(
                            "Total de Cupons: ${ganhador.isNotEmpty ? ganhador[0].qtdCupons : 0}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ), // Text("Total de Cupons: ${cupons.length}"),
                        ],
                      ),
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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../classes/classes.dart';
import '../../../../data/api/promocao/api_promocao.dart';
import '../../../../data/models/web/promocoes/ganhador_cupom_model.dart';
import '../../../../widgets/cards/sorteio/card_cupons.dart';
import '../../../../widgets/form/campo_texto.dart';
import '../../../../widgets/widgets.dart';

class Cupons extends StatefulWidget {
  const Cupons({super.key});

  @override
  State<Cupons> createState() => _CuponsState();
}

class _CuponsState extends State<Cupons> {
  List<GanhadorCupomModel> ganhador = [];

  final TextEditingController busca = TextEditingController();
  final TextEditingController buscaController = TextEditingController();

  bool carregando = false;

  int filtroSelecionado = 1;

  List<DropdownMenuItem> itensFiltro = [
    const DropdownMenuItem(
      value: 1,
      child: Text("Todos"),
    ),
    const DropdownMenuItem(
      value: 2,
      child: Text("Vendidos"),
    ),
    const DropdownMenuItem(
      value: 3,
      child: Text("Sorteados"),
    ),
    const DropdownMenuItem(
      value: 4,
      child: Text("Cadastrados"),
    ),
  ];

  buscarCupons({String? busca, int? skip = 0, int? take = 30}) async {
    String filtroBusca = filtroSelecionado == 1 || filtroSelecionado == 0
        ? "T"
        : filtroSelecionado == 2
            ? "V"
            : filtroSelecionado == 3
                ? "S"
                : filtroSelecionado == 4
                    ? "C"
                    : "T";
    setState(() => carregando = true);
    var response = await ApiPromocao()
        .getCupons(filtroBusca, busca: busca, skip: skip, take: take);
    if (response.statusCode == 200) {
      ganhador.clear();
      buscaController.clear();
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
    buscarCupons();
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 10, top: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: campoTexto(
                            titulo: "Buscar",
                            dica: "Buscar",
                            icone: Icons.person,
                            tipo: TextInputType.text,
                            temMascara: false,
                            mascara: MaskTextInputFormatter(
                                mask: "", filter: {"": RegExp(r'[a-zA-Z]')}),
                            validador: (value) {
                              return null;
                            },
                            controlador: buscaController,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CupertinoButton(
                          color: Cores.preto,
                          padding: const EdgeInsets.all(13),
                          onPressed: () {
                            buscarCupons(busca: buscaController.text);
                          },
                          child: const Icon(
                            CupertinoIcons.search,
                            color: Cores.branco,
                          ),
                        ),
                        const SizedBox(width: 5),
                        CupertinoButton(
                          color: Cores.verdeMedio,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: 30,
                          ),
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Adicionar",
                                style: TextStyle(
                                  color: Cores.branco,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                CupertinoIcons.add,
                                color: Cores.branco,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropDownForm(
                            label: "Filtro",
                            itens: itensFiltro,
                            selecionado: filtroSelecionado,
                            onChange: (value) {
                              setState(() {
                                filtroSelecionado = value;
                              });
                              if (buscaController.text.isNotEmpty) {
                                buscarCupons(busca: buscaController.text);
                              } else {
                                buscarCupons();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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

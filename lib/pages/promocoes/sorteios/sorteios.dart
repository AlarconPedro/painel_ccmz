import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/data/api/promocao/api_promocao.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/cards/sorteio/card_cupons.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../../data/models/web/sorteios_model.dart';
import '../../../widgets/cards/sorteio/card_sorteio.dart';
import 'cadastro_sorteios.dart';
import '../promocoes/sortear.dart';

class Sorteios extends StatefulWidget {
  const Sorteios({super.key});

  @override
  State<Sorteios> createState() => _SorteiosState();
}

class _SorteiosState extends State<Sorteios> {
  bool carregando = false;

  List<SorteiosModel> sorteios = [
    // SorteiosModel(
    //   sorCodigo: 0,
    //   sorNome: 'Teste 1',
    //   sorData: '20/08/2024',
    //   sorNomeGanhador: 'Ganhador 1',
    // ),
    // SorteiosModel(
    //   sorCodigo: 1,
    //   sorNome: 'Teste 2',
    //   sorData: '20/08/2024',
    //   sorNomeGanhador: 'Ganhador 2',
    // ),
  ];

  buscarSorteios() async {
    setState(() => carregando = true);
    var response = await ApiPromocao().getSorteiosPromocao();
    if (response.statusCode == 200) {
      sorteios.clear();
      var decoded = json.decode(response.body);
      for (var item in decoded) {
        sorteios.add(SorteiosModel.fromJson(item));
      }
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarSorteios();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Esqueleto(
          abrirTelaCadastro: () async {
            await Navigator.push(
              context,
              CupertinoDialogRoute(
                builder: (context) => CadastroSorteio(),
                context: context,
              ),
            );
            buscarSorteios();
            // if (retorno != null) {
            //   setState(() {
            //     sorteios.add(retorno);
            //   });
            // }
          },
          buscaNome: (value) {},
          tituloBoto: 'Novo Sorteio',
          tituloPagina: 'Sorteios',
          filtro: false,
          itens: const [],
          label: 'Sorteios',
          onChange: () {},
          selecionado: 0,
          corpo: [
            Expanded(
              child: carregando
                  ? const Center(child: CarregamentoIOS())
                  : sorteios.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: ListView.builder(
                            // itemCount: sorteios.length,
                            itemCount: sorteios.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    CupertinoDialogRoute(
                                      builder: (context) => CadastroSorteio(
                                        codigoSorteio:
                                            sorteios[index].sorCodigo,
                                      ),
                                      context: context,
                                    ),
                                  );
                                  buscarSorteios();
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: cardSorteio(
                                    context: context,
                                    sorteado: index.isEven ? true : false,
                                    sorteio: sorteios[index],
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        CupertinoDialogRoute(
                                          builder: (context) => Sortear(
                                            // Compare this line from lib/pages/promocoes/sorteios/sorteios.dart
                                            codigoSorteio:
                                                sorteios[index].sorCodigo,
                                          ),
                                          context: context,
                                        ),
                                      );
                                      buscarSorteios();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text('Nenhum sorteio cadastrado !'),
                        ),
            ),
          ],
        ),
        Esqueleto(
          abrirTelaCadastro: () async {
            var retorno = await Navigator.push(
              context,
              CupertinoDialogRoute(
                builder: (context) => CadastroSorteio(),
                context: context,
              ),
            );
            if (retorno != null) {
              setState(() {
                sorteios.add(retorno);
              });
            }
          },
          buscaNome: (value) {},
          tituloBoto: 'Novo Cupom',
          tituloPagina: 'Cupons',
          filtro: false,
          itens: const [],
          label: 'Cupons',
          onChange: () {},
          selecionado: 0,
          corpo: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListView.builder(
                  // itemCount: sorteios.length,
                  itemCount: sorteios.length,
                  itemBuilder: (context, index) {
                    return cardCupons(
                      context: context,
                      data: sorteios[index].sorData,
                      ganhador: sorteios[index].parNome,
                      nome: sorteios[index].preNome,
                      telefone: sorteios[index].cupNumero,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoDialogRoute(
                            builder: (context) => Sortear(
                                codigoSorteio: sorteios[index].sorCodigo),
                            context: context,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

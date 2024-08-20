import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/models/sorteios_model.dart';
import 'package:painel_ccmn/pages/sorteios/sortear.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/cards/sorteio/card_cupons.dart';

import '../../widgets/cards/sorteio/card_sorteio.dart';
import 'cadastro_sorteios.dart';

class Sorteios extends StatefulWidget {
  const Sorteios({super.key});

  @override
  State<Sorteios> createState() => _SorteiosState();
}

class _SorteiosState extends State<Sorteios> {
  List<SorteiosModel> sorteios = [
    SorteiosModel(
      sorCodigo: 0,
      sorNome: 'Teste 1',
      sorData: '20/08/2024',
      sorNomeGanhador: 'Ganhador 1',
    ),
    SorteiosModel(
      sorCodigo: 1,
      sorNome: 'Teste 2',
      sorData: '20/08/2024',
      sorNomeGanhador: 'Ganhador 2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        children: [
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
            tituloBoto: 'Novo Sorteio',
            tituloPagina: 'Sorteios',
            filtro: false,
            itens: [],
            label: 'Sorteios',
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
                      return cardSorteio(
                        context: context,
                        sorteado: index.isEven ? true : false,
                        sorteio: sorteios[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoDialogRoute(
                              builder: (context) => const Sortear(),
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
            itens: [],
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
                        ganhador: sorteios[index].sorNomeGanhador,
                        nome: sorteios[index].sorNome,
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoDialogRoute(
                              builder: (context) => const Sortear(),
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
      ),
    );
  }
}

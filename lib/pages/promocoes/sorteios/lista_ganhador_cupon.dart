import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/data/models/web/promocoes/ganhador_cupom_model.dart';
import 'package:painel_ccmn/widgets/telas/esqueleto/esqueleto.dart';
import 'package:painel_ccmn/widgets/cards/sorteio/card_cupons.dart';
import 'package:painel_ccmn/widgets/loading/carregamento_ios.dart';

import '../../../data/api/promocao/api_promocao.dart';
import '../promocoes/sortear.dart';

class ListaGanhadorCupon extends StatefulWidget {
  const ListaGanhadorCupon({super.key});

  @override
  State<ListaGanhadorCupon> createState() => _ListaGanhadorCuponState();
}

class _ListaGanhadorCuponState extends State<ListaGanhadorCupon> {
  List<GanhadorCupomModel> ganhador = [];

  final TextEditingController busca = TextEditingController();

  bool carregando = false;

  buscarGanhador(String filtro,
      {String? cupom, int? skip = 0, int? take = 30}) async {
    setState(() => carregando = true);
    var response = await ApiPromocao()
        .getCupons(filtro, busca: cupom, skip: skip, take: take);
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
    return Esqueleto(
      tituloBoto: "Sortear Cupon",
      tituloPagina: "Cupons",
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => Sortear(codigoSorteio: 0),
            context: context,
          ),
        );
        buscarGanhador('T');
      },
      buscaNome: (value) {
        if (value.isNotEmpty) {
          buscarGanhador("T", cupom: value);
        } else {
          buscarGanhador("T");
        }
      },
      corpo: [
        Expanded(
          child: carregando
              ? const Center(child: CarregamentoIOS())
              : ganhador.isEmpty
                  ? const Center(child: Text("Nenhum Cupom Encontrado !"))
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
          height: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Total de Cupons: ${ganhador.isNotEmpty ? ganhador[0].qtdCupons : 0}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ), // Text("Total de Cupons: ${cupons.length}"),
              ],
            ),
          ),
        ),
      ],
    );
    // return Scaffold(
    //   backgroundColor: Cores.cinzaClaro,
    //   body: Padding(
    //     padding: const EdgeInsets.all(10),
    //     child: Center(
    //       child: Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         elevation: 10,
    //         color: Cores.branco,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //             color: Cores.branco,
    //           ),
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                   vertical: 10,
    //                   horizontal: 20,
    //                 ),
    //                 child: Row(
    //                   children: [
    //                     const Text(
    //                       "Buscar: ",
    //                       style: TextStyle(
    //                         fontSize: 20,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: SizedBox(
    //                         height: 55,
    //                         child: CupertinoTextField(
    //                           controller: busca,
    //                           onSubmitted: (value) async {
    //                             if (busca.text.isNotEmpty) {
    //                               await buscarGanhador("T", cupom: value);
    //                               busca.clear();
    //                             } else {
    //                               await buscarGanhador("T");
    //                             }
    //                           },
    //                           decoration: BoxDecoration(
    //                             borderRadius: const BorderRadius.all(
    //                               Radius.circular(10),
    //                             ),
    //                             border: Border.all(
    //                               color: Cores.cinzaEscuro,
    //                             ),
    //                           ),
    //                           placeholder: 'Pesquisar',
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(width: 10),
    //                     CupertinoButton(
    //                       color: Cores.preto,
    //                       onPressed: () async {
    //                         if (busca.text.isNotEmpty) {
    //                           await buscarGanhador("T", cupom: busca.text);
    //                           busca.clear();
    //                         } else {
    //                           await buscarGanhador("T");
    //                         }
    //                       },
    //                       padding: const EdgeInsets.symmetric(
    //                         vertical: 16,
    //                         horizontal: 16,
    //                       ),
    //                       child: const Icon(CupertinoIcons.search),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(height: 10),
    //               const Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 20),
    //                 child: Row(children: [
    //                   Text(
    //                     "Cupons",
    //                     style: TextStyle(
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   Spacer(),
    //                 ]),
    //               ),
    //               const Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 20),
    //                 child: Divider(
    //                   thickness: 1,
    //                   color: Cores.preto,
    //                 ),
    //               ),
    //               Expanded(
    //                 child: carregando
    //                     ? const Center(child: CarregamentoIOS())
    //                     : ganhador.isEmpty
    //                         ? const Center(
    //                             child: Text("Nenhum Cupom Encontrado !"))
    //                         : Padding(
    //                             padding: const EdgeInsets.all(10),
    //                             child: ListView.builder(
    //                               itemCount: ganhador.length,
    //                               itemBuilder: (context, index) {
    //                                 return cardCupons(
    //                                   onTap: () {},
    //                                   context: context,
    //                                   nome: ganhador[index].parNome,
    //                                   telefone: ganhador[index].parFone,
    //                                   ganhador: ganhador[index].cupNumero,
    //                                   data: ganhador[index].parCidade,
    //                                   // abrirCupons: () {},
    //                                   // abrirParticipantes: () {},
    //                                 );
    //                                 // return ListTile(
    //                                 //   title: Text(ganhador[index].parNome),
    //                                 //   subtitle: Text(ganhador[index].cupNumero),
    //                                 //   trailing: IconButton(
    //                                 //     icon: const Icon(CupertinoIcons.delete),
    //                                 //     onPressed: () async {
    //                                 //       // await deletarCupon(cupons[index].id);
    //                                 //     },
    //                                 //   ),
    //                                 // );
    //                               },
    //                             ),
    //                           ),
    //               ),
    //               SizedBox(
    //                 height: 35,
    //                 child: Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 10),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       Text(
    //                         "Total de Cupons: ${ganhador.isNotEmpty ? ganhador[0].qtdCupons : 0}",
    //                         style: const TextStyle(fontWeight: FontWeight.bold),
    //                       ), // Text("Total de Cupons: ${cupons.length}"),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

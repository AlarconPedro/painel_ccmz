import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/models/sorteios_model.dart';
import 'package:painel_ccmn/pages/sorteios/sorteios.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../data/api/promocao/api_promocao.dart';
import '../../models/promocoes_model.dart';
import '../../widgets/cards/sorteio/card_promocao.dart';
import '../pages.dart';
import 'cadastro_promocoes.dart';

class Promocoes extends StatefulWidget {
  const Promocoes({super.key});

  @override
  State<Promocoes> createState() => _PromocoesState();
}

class _PromocoesState extends State<Promocoes> {
  List<PromocoesModel> promocao = [];

  bool carregando = false;

  buscarPromocoes() async {
    setState(() => carregando = true);
    var retorno = await ApiPromocao().getPromocoes();
    if (retorno.statusCode == 200) {
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => promocao.add(PromocoesModel.fromJson(item)));
      }
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarPromocoes();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      abrirTelaCadastro: () async {
        var retorno = await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) => const CadastroPromocoes(),
            context: context,
          ),
        );
        if (retorno != null) {
          setState(() {
            // sorteios.add(retorno);
          });
        }
      },
      buscaNome: (value) {},
      tituloBoto: 'Nova Promoção',
      tituloPagina: 'Promoções',
      filtro: false,
      itens: [],
      label: 'Promoções',
      onChange: () {},
      selecionado: 0,
      corpo: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(width: 55),
              Expanded(
                  child: Text("Promoção",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                child: Text("Data Início",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: Text("Data Fim",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(width: 50),
              Text("Particip. ", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Text("Cupons", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: carregando
                ? const CarregamentoIOS()
                : ListView.builder(
                    // itemCount: sorteios.length,
                    itemCount: promocao.length,
                    itemBuilder: (context, index) {
                      return cardPromocao(
                        promocao: PromocoesModel(
                          proNome: promocao[index].proNome,
                          proDataInicio: promocao[index].proDataInicio,
                          proDataFim: promocao[index].proDataFim,
                          proCodigo: promocao[index].proCodigo,
                          proDescricao: promocao[index].proDescricao,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const Sorteios(),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:painel_ccmn/pages/sorteios/sorteios.dart';

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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListView.builder(
              // itemCount: sorteios.length,
              itemCount: 2,
              itemBuilder: (context, index) {
                return cardPromocao(
                  promocao: PromocoesModel(
                    proNome: 'Promoção $index',
                    proDataInicio: '01/01/2021',
                    proDataFim: '01/01/2022',
                    proCodigo: 0,
                    proDescricao: "",
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

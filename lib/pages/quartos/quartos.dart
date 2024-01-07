import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class Quartos extends StatefulWidget {
  const Quartos({super.key});

  @override
  State<Quartos> createState() => _QuartosState();
}

class _QuartosState extends State<Quartos> {
  bool carregando = false;

  List<QuartoModel> quartos = [];

  buscarQuartos() async {
    setState(() => carregando = true);
    var retorno = await ApiQuarto().getQuartos();
    if (retorno.statusCode == 200) {
      quartos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(
          () => quartos.add(QuartoModel.fromJson(item)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer quartos !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  deleteQuarto(int codigoQuarto) async {
    setState(() => carregando = true);
    var retorno = await ApiQuarto().deleteQuarto(codigoQuarto);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Quarto excluido com sucesso !"),
        ),
      );
      buscarQuartos();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao excluir quarto !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarQuartos();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Quarto",
      tituloPagina: "Quartos",
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) {
              return const CadastroQuarto();
            },
            context: context,
          ),
        );
        buscarQuartos();
      },
      corpo: [
        const Row(children: [
          SizedBox(width: 55),
          Expanded(
            flex: 4,
            child: Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text("Bloco", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 50),
          Expanded(
            flex: 2,
            child: Text("Qtd. Camas",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 50),
          Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 25),
        ]),
        carregando
            ? const Expanded(child: Center(child: CarregamentoIOS()))
            : Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListView.builder(
                    itemCount: quartos.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {},
                          child: CardQuartos(
                            quarto: quartos[index],
                            excluir: () {
                              deleteQuarto(quartos[index].quaCodigo);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}

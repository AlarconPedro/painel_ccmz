import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../data/data.dart';

class Bloco extends StatefulWidget {
  const Bloco({super.key});

  @override
  State<Bloco> createState() => _BlocoState();
}

class _BlocoState extends State<Bloco> {
  bool carregando = false;

  List<BlocoModel> blocos = [];

  buscarBlocos() async {
    setState(() => carregando = true);
    var retorno = await ApiBloco().getBlocos();
    if (retorno.statusCode == 200) {
      blocos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() => blocos.add(BlocoModel.fromJson(item)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer blocos !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  deletarBloco(int codigoBloco) async {
    setState(() => carregando = true);
    var retorno = await ApiBloco().deleteBloco(codigoBloco);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Bloco excluido com sucesso !"),
        ),
      );
      buscarBlocos();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao excluir bloco !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarBlocos();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Bloco",
      tituloPagina: "Blocos",
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) {
              return CadastroBloco(
                bloco: null,
              );
            },
            context: context,
          ),
        );
        buscarBlocos();
      },
      buscaNome: (value) async {},
      corpo: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(width: 40),
              Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Spacer(),
              Text("Qtd. Quartos",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Qtd. Livres",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Qtd. Ocupados",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        carregando
            ? const Flexible(child: Center(child: CarregamentoIOS()))
            : Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: blocos.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              CupertinoDialogRoute(
                                builder: (context) {
                                  return CadastroBloco(
                                    bloco: blocos[index],
                                  );
                                },
                                context: context,
                              ),
                            );
                            buscarBlocos();
                          },
                          child: CardBloco(
                            bloco: blocos[index],
                            excluir: () {
                              deletarBloco(blocos[index].bloCodigo);
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

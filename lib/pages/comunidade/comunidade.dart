import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/data/models/comunidade_model.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class Comunidade extends StatefulWidget {
  const Comunidade({super.key});

  @override
  State<Comunidade> createState() => _ComunidadeState();
}

class _ComunidadeState extends State<Comunidade> {
  List<ComunidadeModel> comunidades = [];

  bool carregando = false;

  buscarComunidades() async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiComunidade().getComunidades();
    if (retorno.statusCode == 200) {
      comunidades.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        setState(() {
          comunidades.add(ComunidadeModel.fromJson(item));
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer comunidades !"),
        ),
      );
    }
    setState(() {
      carregando = false;
    });
  }

  deleteComunidade(int codigoComunidade) async {
    setState(() {
      carregando = true;
    });
    var retorno = await ApiComunidade().deleteComunidade(codigoComunidade);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Comunidade excluida com sucesso !"),
        ),
      );
      buscarComunidades();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao excluir comunidade !"),
        ),
      );
    }
    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarComunidades();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Nova Comunidade",
      tituloPagina: "Comunidade",
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) {
              return CadastroComunidade();
            },
            context: context,
          ),
        );
        buscarComunidades();
      },
      buscaNome: (busca) {},
      corpo: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text("Nome", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Cidade", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("UF", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Qtd. Pessoas",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        carregando
            ? const Expanded(child: Center(child: CarregamentoIOS()))
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    itemCount: comunidades.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              CupertinoDialogRoute(
                                builder: (context) {
                                  return CadastroComunidade(
                                    comunidade: comunidades[index],
                                  );
                                },
                                context: context,
                              ),
                            );
                            buscarComunidades();
                          },
                          child: CardComunidade(
                            comunidade: comunidades[index],
                            excluir: () {
                              deleteComunidade(comunidades[index].comCodigo);
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

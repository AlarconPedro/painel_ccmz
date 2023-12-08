import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmz/data/data.dart';
import 'package:painel_ccmz/pages/pages.dart';
import 'package:painel_ccmz/widgets/widgets.dart';

import '../../classes/classes.dart';

class Evento extends StatefulWidget {
  const Evento({super.key});

  @override
  State<Evento> createState() => _EventoState();
}

class _EventoState extends State<Evento> {
  bool carregando = false;

  List<EventoModel> eventos = [];

  buscarEventos() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().getEventos();
    if (retorno.statusCode == 200) {
      eventos.clear();
      var decoded = json.decode(retorno.body);
      for (var item in decoded) {
        print(item);
        setState(() => eventos.add(EventoModel.fromJson(item)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao trazer eventos !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  deleteEvento(int codigoEvento) async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().deleteEvento(codigoEvento);
    if (retorno.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.verdeEscuro,
          content: Text("Evento excluido com sucesso !"),
        ),
      );
      buscarEventos();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Cores.vermelhoMedio,
          content: Text("Erro ao excluir evento !"),
        ),
      );
    }
    setState(() => carregando = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buscarEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Esqueleto(
      tituloBoto: "Novo Evento",
      tituloPagina: "Eventos",
      abrirTelaCadastro: () async {
        await Navigator.push(
          context,
          CupertinoDialogRoute(
            builder: (context) {
              return CadastroEvento();
            },
            context: context,
          ),
        );
        buscarEventos();
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
            child: Text("Data Início",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child:
                Text("Data Fim", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 75),
          Text("Quartos", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Text("Pessoas", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Text("Alocação", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
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
                    itemCount: eventos.length,
                    itemBuilder: (context, index) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              CupertinoDialogRoute(
                                builder: (context) {
                                  return CadastroEvento(evento: eventos[index]);
                                },
                                context: context,
                              ),
                            );
                            buscarEventos();
                          },
                          child: CardEvento(
                            evento: eventos[index],
                            excluir: () {
                              deleteEvento(eventos[index].eveCodigo);
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

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';
import 'package:painel_ccmn/pages/evento/alocacao_evento.dart';
import 'package:painel_ccmn/pages/pages.dart';
import 'package:painel_ccmn/widgets/widgets.dart';

import '../../classes/classes.dart';
import '../../estrutura/estrutura.dart';

class Evento extends StatefulWidget {
  const Evento({super.key});

  @override
  State<Evento> createState() => _EventoState();
}

class _EventoState extends State<Evento> {
  bool carregando = false;

  List<EventoModel> eventos = [];

  int mesSelecionado = DateTime.now().month;

  buscarEventos() async {
    setState(() => carregando = true);
    var retorno = await ApiEvento().getEventos(mesSelecionado);
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
      filtro: true,
      label: "Mês",
      onChange: (value) {
        setState(() => mesSelecionado = value);
        buscarEventos();
      },
      itens: const [
        DropdownMenuItem(
          value: 0,
          child: Text("Todos"),
        ),
        DropdownMenuItem(
          value: 1,
          child: Text("Janeiro"),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text("Fevereiro"),
        ),
        DropdownMenuItem(
          value: 3,
          child: Text("Março"),
        ),
        DropdownMenuItem(
          value: 4,
          child: Text("Abril"),
        ),
        DropdownMenuItem(
          value: 5,
          child: Text("Maio"),
        ),
        DropdownMenuItem(
          value: 6,
          child: Text("Junho"),
        ),
        DropdownMenuItem(
          value: 7,
          child: Text("Julho"),
        ),
        DropdownMenuItem(
          value: 8,
          child: Text("Agosto"),
        ),
        DropdownMenuItem(
          value: 9,
          child: Text("Setembro"),
        ),
        DropdownMenuItem(
          value: 10,
          child: Text("Outubro"),
        ),
        DropdownMenuItem(
          value: 11,
          child: Text("Novembro"),
        ),
        DropdownMenuItem(
          value: 12,
          child: Text("Dezembro"),
        ),
      ],
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
      buscaNome: (busca) {},
      corpo: [
        const Row(children: [
          SizedBox(width: 55),
          Expanded(
            flex: 4,
            child: Text(
              "Nome",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
          SizedBox(width: 15),
          Text("Custo", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 22),
          Text("Excluir", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 25),
        ]),
        carregando
            ? const Flexible(child: Center(child: CarregamentoIOS()))
            : Flexible(
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
                            quartos: () {
                              Navigator.push(
                                context,
                                CupertinoDialogRoute(
                                  builder: (context) {
                                    return QuartosEvento(
                                      codigoEvento: eventos[index].eveCodigo,
                                      // evento: eventos[index],
                                    );
                                  },
                                  context: context,
                                ),
                              );
                            },
                            pessoas: () {
                              Navigator.push(
                                context,
                                CupertinoDialogRoute(
                                  builder: (context) {
                                    return PessoasEvento(
                                      codigoEvento: eventos[index].eveCodigo,
                                      // evento: eventos[index],
                                    );
                                  },
                                  context: context,
                                ),
                              );
                            },
                            alocacao: () {
                              Navigator.push(
                                context,
                                CupertinoDialogRoute(
                                  builder: (context) {
                                    return const AlocacaoEvento();
                                  },
                                  context: context,
                                ),
                              );
                              // Rotas.navController.animateToPage(
                              //   6,
                              //   duration: const Duration(milliseconds: 500),
                              //   curve: Curves.easeInOut,
                              // );
                            },
                            custo: () {
                              Navigator.push(
                                context,
                                CupertinoDialogRoute(
                                    builder: (context) {
                                      return const CustoEvento();
                                    },
                                    context: context),
                              );
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

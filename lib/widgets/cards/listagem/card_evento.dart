import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_ccmn/data/data.dart';

import '../../../classes/classes.dart';
import '../../../data/models/web/hospedagem/evento_model.dart';

class CardEvento extends StatelessWidget {
  EventoModel evento;

  Function excluir;
  Function quartos;
  Function pessoas;
  Function alocacao;
  Function custo;

  CardEvento({
    super.key,
    required this.evento,
    required this.excluir,
    required this.quartos,
    required this.pessoas,
    required this.alocacao,
    required this.custo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Cores.branco,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.calendar),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: Text(evento.eveNome),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(evento.eveDataInicio),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(evento.eveDataFim),
                      ),
                      const SizedBox(width: 30),
                      const Icon(CupertinoIcons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.bed_double,
                color: Cores.cinzaEscuro,
              ),
              onPressed: () {
                quartos();
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.person,
                color: Cores.cinzaEscuro,
              ),
              onPressed: () {
                pessoas();
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.house,
                color: Cores.cinzaEscuro,
              ),
              onPressed: () {
                alocacao();
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: CupertinoButton(
              padding: const EdgeInsets.all(10),
              child: const Icon(
                CupertinoIcons.money_dollar,
                size: 35,
                color: Cores.verdeMedio,
              ),
              onPressed: () {
                custo();
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: CupertinoButton(
              child: const Icon(
                CupertinoIcons.trash,
                color: Cores.vermelhoMedio,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text("Excluir Evento"),
                      content:
                          const Text("Deseja realmente excluir este evento ?"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Não",
                              style: TextStyle(color: Cores.vermelhoMedio)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text("Sim",
                              style: TextStyle(color: Cores.verdeMedio)),
                          onPressed: () {
                            Navigator.pop(context);
                            excluir();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

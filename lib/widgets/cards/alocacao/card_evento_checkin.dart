import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';
import '../../../data/data.dart';
import '../../../funcoes/funcoes.dart';

class CardEventoCheckin extends StatelessWidget {
  Function checkin;
  Function quartos;

  EventoCheckinModel eventoDados;
  CardEventoCheckin({
    super.key,
    required this.eventoDados,
    required this.quartos,
    required this.checkin,
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
                        child: Text(eventoDados.eveNome),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          FuncoesData.dataFormatada(eventoDados.eveDataInicio),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                            FuncoesData.dataFormatada(eventoDados.eveDataFim)),
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
                CupertinoIcons.eye,
                color: Cores.azulMedio,
              ),
              onPressed: () {
                quartos();
                // quartos();
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
                CupertinoIcons.check_mark_circled,
                color: Cores.verdeMedio,
              ),
              onPressed: () {
                checkin();
              },
            ),
          ),
        ],
      ),
    );
  }
}

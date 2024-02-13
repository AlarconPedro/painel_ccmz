import 'package:flutter/material.dart';
import 'package:painel_ccmz/widgets/loading/carregamento_ios.dart';

import '../../../classes/classes.dart';

class CardCorpoTela extends StatelessWidget {
  Widget child;
  bool carregando;
  CardCorpoTela({
    super.key,
    required this.child,
    required this.carregando,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      color: Cores.branco,
      child: Expanded(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Cores.branco,
            ),
            child: carregando ? const Center(child: CarregamentoIOS()) : child),
      ),
    );
  }
}

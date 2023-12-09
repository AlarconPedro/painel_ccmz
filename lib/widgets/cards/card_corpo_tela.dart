import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class CardCorpoTela extends StatelessWidget {
  Widget child;
  CardCorpoTela({super.key, required this.child});

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
          child: child,
        ),
      ),
    );
  }
}

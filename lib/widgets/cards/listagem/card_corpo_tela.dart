import 'package:flutter/material.dart';

import '../../../classes/classes.dart';

class CardCorpoTela extends StatelessWidget {
  Widget child;
  int itemCount;
  CardCorpoTela({
    super.key,
    required this.child,
    required this.itemCount,
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
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return child;
            },
          ),
        ),
      ),
    );
  }
}

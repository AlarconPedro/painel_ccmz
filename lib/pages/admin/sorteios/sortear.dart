import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../classes/classes.dart';

class Sortear extends StatefulWidget {
  const Sortear({super.key});

  @override
  State<Sortear> createState() => _SortearState();
}

class _SortearState extends State<Sortear> {
  String texto = 'Sorteando...';

  sortear() {}

  @override
  initState() {
    super.initState();
    sortear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Cores.verdeMedio,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  texto,
                  style: const TextStyle(
                    color: Cores.branco,
                    fontSize: 20,
                  ),
                ),
                LoadingAnimationWidget.inkDrop(
                  color: Cores.branco,
                  size: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

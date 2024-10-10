import 'package:flutter/material.dart';
import '../../classes/classes.dart';

class Cupons extends StatefulWidget {
  const Cupons({super.key});

  @override
  State<Cupons> createState() => _CuponsState();
}

class _CuponsState extends State<Cupons> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Card(
            color: Cores.branco,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: SizedBox(),
          ),
        ),
      ),
    );
  }
}

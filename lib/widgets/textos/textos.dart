import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';

class Textos {
  static Text textoGrande({required String texto, Color? cor = Cores.preto}) {
    return Text(
      texto,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: cor),
    );
  }

  static Text textoMedio({required String texto, Color? cor = Cores.preto}) {
    return Text(
      texto,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: cor),
    );
  }

  static Text textoPequeno({required String texto, Color? cor = Cores.preto}) {
    return Text(
      texto,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: cor),
    );
  }

  static Text textoGrandeNormal(
      {required String texto, Color? cor = Cores.preto}) {
    return Text(
      texto,
      style: TextStyle(fontSize: 24, color: cor),
    );
  }

  static Text textoMedioNormal(
      {required String texto, Color? cor = Cores.preto}) {
    return Text(
      texto,
      style: TextStyle(fontSize: 20, color: cor),
    );
  }

  static Text textoPequenoNormal(
      {required String texto, Color? cor = Cores.preto}) {
    return Text(
      texto,
      style: TextStyle(fontSize: 16, color: cor),
    );
  }
}

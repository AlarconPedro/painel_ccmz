import 'package:flutter/material.dart';

import '../classes/classes.dart';

ScaffoldFeatureController snackNotification(
        {required BuildContext context,
        required String mensage,
        Color? cor = Cores.vermelhoMedio}) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensage), backgroundColor: cor));

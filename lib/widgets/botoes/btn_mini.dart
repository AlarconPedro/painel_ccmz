import 'package:flutter/cupertino.dart';

import '../../classes/classes.dart';

CupertinoButton btnMini({
  required VoidCallback onPressed,
  required Widget child,
  EdgeInsets? padding = const EdgeInsets.all(15),
  Color? cor = Cores.verdeMedio,
}) {
  return CupertinoButton(
      color: cor, padding: padding, onPressed: onPressed, child: child);
}

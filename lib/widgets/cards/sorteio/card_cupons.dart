import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../classes/classes.dart';

Widget cardCupons({
  required BuildContext context,
  required String nome,
  required String data,
  required String ganhador,
  required Function() onTap,
}) {
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
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.tag_solid),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Text(nome),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        ganhador,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Icon(CupertinoIcons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: const Icon(CupertinoIcons.trash,
                      color: Cores.vermelhoMedio)),
            ),
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../classes/classes.dart';
import '../../widgets/widgets.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: CardCorpoTela(
                  child: const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [CardDashboard()],
                      ),
                    ),
                  ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.symmetric(
                  //               horizontal: 10,
                  //               vertical: 5,
                  //             ),
                  //             child: Text(
                  //               "Eventos",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Expanded(
                  //         child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           physics: const BouncingScrollPhysics(),
                  //           itemCount: 20,
                  //           shrinkWrap: true,
                  //           itemBuilder: (context, index) {
                  //             return CardCorpoTela(
                  //               child: SizedBox(
                  //                 width: 150,
                  //                 child: Column(
                  //                   children: [
                  //                     Expanded(
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10),
                  //                           color: Cores.cinzaClaro,
                  //                         ),
                  //                         child: const Center(
                  //                           child: Text(
                  //                             "Imagem",
                  //                             style: TextStyle(
                  //                               fontSize: 18,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const Padding(
                  //                       padding: EdgeInsets.all(5),
                  //                       child: Text(
                  //                         "Nome do Evento",
                  //                         style: TextStyle(
                  //                           fontSize: 18,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const Padding(
                  //                       padding: EdgeInsets.all(5),
                  //                       child: Text(
                  //                         "Data do Evento",
                  //                         style: TextStyle(
                  //                           fontSize: 18,
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  // );
                  // },
                  // ),
                  // ),
                  // ],
                  // ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CardCorpoTela(
                          child: const Column(
                        children: [],
                      )),
                    ),
                    SizedBox(
                      width: 250,
                      child: CardCorpoTela(
                          child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Text(
                                  "Eventos",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            verticalDirection: VerticalDirection.down,
                            runSpacing: 10,
                            spacing: 10,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: Icon(CupertinoIcons.add),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: Icon(CupertinoIcons.add),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: Icon(CupertinoIcons.add),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                child: Icon(CupertinoIcons.add),
                              ),
                            ],
                          )
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

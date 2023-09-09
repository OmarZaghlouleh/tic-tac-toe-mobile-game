import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:xo_game/View%20Models/multiplayer_view_model.dart';
import 'package:xo_game/Views/my_scaffold.dart';

class MultiplayerBoard extends StatelessWidget {
  const MultiplayerBoard({Key? key, required this.isPlayer1}) : super(key: key);

  final bool isPlayer1;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      // floatingActionButton: Container(
      //   width: MediaQuery.of(context).orientation == Orientation.portrait
      //       ? MediaQuery.of(context).size.width * 0.27
      //       : MediaQuery.of(context).size.width * 0.17,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(30),
      //     color: Colors.red,
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //           onPressed: () {
      //             Navigator.pushReplacement(
      //                 context,
      //                 PageTransition(
      //                     child: MyScaffold(),
      //                     type: MediaQuery.of(context).orientation ==
      //                             Orientation.portrait
      //                         ? PageTransitionType.topToBottom
      //                         : PageTransitionType.rightToLeft));
      //           },
      //           icon: const Icon(
      //             Icons.home_rounded,
      //             color: Colors.white,
      //           )),
      //       IconButton(
      //         icon: const Icon(
      //           Icons.replay_rounded,
      //           color: Colors.white,
      //         ),
      //         onPressed: () {
      //           restartgame();
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.20,
            //   child: Center(
            //     child: Text(
            //       gameover ? '' : '$currentplayer Turn',
            //       style: TextStyle(
            //           fontFamily: 'Gameplay',
            //           color: currentplayer == 'X'
            //               ? Colors.blue
            //               : Colors.red,
            //           fontSize: 35),
            //     ),
            //   ),
            // ),
            Expanded(
              // height: MediaQuery.of(context).size.height * 0.75,
              // width: MediaQuery.of(context).size.width * 0.85,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StreamBuilder<DatabaseEvent>(
                    stream: Provider.of<MultiplayerViewModel>(context,
                            listen: false)
                        .play(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        log(snapshot.data!.snapshot.value.toString());
                        final data = snapshot.data!.snapshot.value as Map;
                        List<int> player1Playes = data['player1Playes'] == null
                            ? []
                            : data['player1Playes'] as List<int>;
                        List<int> player2Playes = data['player2Playes'] == null
                            ? []
                            : data['player2Playes'] as List<int>;

                        return GridView.count(
                          childAspectRatio: 1,
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: List.generate(9, (index) {
                            return InkWell(
                                onTap: () async {
                                  if (isPlayer1) {
                                    if (player1Playes.contains(index)) {
                                      player1Playes.add(index);
                                    }
                                  } else {
                                    if (player2Playes.contains(index)) {
                                      player2Playes.add(index);
                                    }
                                  }
                                  await Provider.of<MultiplayerViewModel>(
                                          context,
                                          listen: false)
                                      .updatePlay(
                                          isPlayer1: isPlayer1,
                                          player1Playes: player1Playes,
                                          player2Playes: player2Playes);
                                },
                                borderRadius: BorderRadius.circular(15),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.red,
                                            offset: Offset(2, 2))
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Color(0xff240046),
                                    ),
                                    child: Center(
                                      child: Text(
                                        player1Playes.contains(index)
                                            ? 'X'
                                            : player2Playes.contains(index)
                                                ? 'O'
                                                : '',
                                        style: TextStyle(
                                          color: !player1Playes.contains(index)
                                              ? (player2Playes.contains(index)
                                                  ? Colors.red
                                                  : Colors.transparent)
                                              : Colors.blue,
                                          fontSize: 30,
                                          fontFamily: 'Gameplay',
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          }),
                        );
                      } else
                        return Text("Error");
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void restartgame() {
  //   setState(() {
  //     gameover = false;
  //     currentplayer = 'X';
  //     turnes = 0;
  //     Player.PlayerX = [];
  //     Player.PlayerO = [];
  //   });
  // }

  // void updataState(BuildContext ctx, bool isLandscape) {
  //   List<dynamic> results = Player.checkwinner();
  //   setState(() {
  //     currentplayer = currentplayer == 'X' ? 'O' : 'X';
  //     turnes++;

  //     if (results[1]) {
  //       //restartgame();
  //       gameover = true;
  //       resultDialog(ctx, results, isLandscape);
  //     }
  //     if (turnes == 9 && !gameover && !results[1]) {
  //       //restartgame();
  //       gameover = true;
  //       resultDialog(ctx, results, isLandscape);
  //     }
  //   });
  // }

  // Future<dynamic> resultDialog(
  //     BuildContext ctx, List<dynamic> results, bool isLandscape) {
  //   return showDialog(
  //       barrierDismissible: true,
  //       context: ctx,
  //       builder: (ctx) {
  //         return Center(
  //           child: Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               color: results[0] != 'X'
  //                   ? (results[0] == 'O'
  //                       ? Colors.red[900]
  //                       : const Color(0xff240046))
  //                   : Colors.blue[900],
  //             ),
  //             width: isLandscape
  //                 ? MediaQuery.of(context).size.width * 0.7
  //                 : MediaQuery.of(context).size.width * 0.7,
  //             height: isLandscape
  //                 ? MediaQuery.of(context).size.height * 0.7
  //                 : MediaQuery.of(context).size.height * 0.25,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Text(
  //                   results[1] ? '${results[0]} Won' : 'Draw',
  //                   style: TextStyle(
  //                       fontSize: isLandscape ? 50 : 25,
  //                       color: Colors.white,
  //                       decoration: TextDecoration.none,
  //                       fontFamily: 'Gameplay'),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     ElevatedButton(
  //                         onPressed: () {
  //                           restartgame();
  //                           Navigator.pop(ctx);
  //                           Navigator.pushReplacement(
  //                               context,
  //                               PageTransition(
  //                                   child: MyScaffold(),
  //                                   type: isLandscape
  //                                       ? PageTransitionType.rightToLeft
  //                                       : PageTransitionType.bottomToTop));
  //                         },
  //                         child: const Text(
  //                           'Main Menu',
  //                           style: TextStyle(fontFamily: 'Gameplay'),
  //                         )),
  //                     ElevatedButton(
  //                         onPressed: () {
  //                           Navigator.pop(ctx);
  //                           restartgame();
  //                         },
  //                         child: const Text(
  //                           'Restart',
  //                           style: TextStyle(fontFamily: 'Gameplay'),
  //                         ))
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
}

import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:xo_game/game_logic.dart';

import 'my_scaffold.dart';

class GameScreen extends StatefulWidget {
  GameScreen(this.isComputer, {Key? key}) : super(key: key);

  bool isComputer;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool gameover = false;

  String currentplayer = 'X';
  int turnes = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: Container(
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width * 0.27
            : MediaQuery.of(context).size.width * 0.17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.red,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: MyScaffold(),
                          type: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? PageTransitionType.topToBottom
                              : PageTransitionType.rightToLeft));
                },
                icon: const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                )),
            IconButton(
              icon: const Icon(
                Icons.replay_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                restartgame();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) => orientation == Orientation.portrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: Center(
                        child: Text(
                          gameover ? '' : '$currentplayer Turn',
                          style: TextStyle(
                              fontFamily: 'Gameplay',
                              color: currentplayer == 'X'
                                  ? Colors.blue
                                  : Colors.red,
                              fontSize: 35),
                        ),
                      ),
                    ),
                    Expanded(
                      // height: MediaQuery.of(context).size.height * 0.75,
                      // width: MediaQuery.of(context).size.width * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.count(
                          childAspectRatio: 1,
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: List.generate(9, (index) {
                            return InkWell(
                                onTap: gameover
                                    ? null
                                    : () async {
                                        if (Player.PlayerO.contains(index) ||
                                            Player.PlayerX.contains(index)) {
                                          return;
                                        }
                                        Player.playgame(index, currentplayer);

                                        updataState(
                                            context,
                                            orientation == Orientation.landscape
                                                ? true
                                                : false);
                                        if (!gameover &&
                                            turnes != 9 &&
                                            widget.isComputer) {
                                          Player.autoplay(currentplayer);
                                          updataState(
                                              context,
                                              orientation ==
                                                      Orientation.landscape
                                                  ? true
                                                  : false);
                                        }

                                        if (turnes == 9) gameover = true;
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
                                        !Player.PlayerX.contains(index)
                                            ? (Player.PlayerO.contains(index)
                                                ? 'O'
                                                : '')
                                            : 'X',
                                        style: TextStyle(
                                          color: !Player.PlayerX.contains(index)
                                              ? (Player.PlayerO.contains(index)
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
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.05),
                        child: GridView.count(
                          childAspectRatio: 1,
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          children: List.generate(9, (index) {
                            return InkWell(
                                onTap: gameover
                                    ? null
                                    : () async {
                                        if (Player.PlayerO.contains(index) ||
                                            Player.PlayerX.contains(index)) {
                                          return;
                                        }
                                        Player.playgame(index, currentplayer);

                                        updataState(
                                            context,
                                            orientation == Orientation.landscape
                                                ? true
                                                : false);
                                        if (!gameover &&
                                            turnes != 9 &&
                                            widget.isComputer) {
                                          Player.autoplay(currentplayer);
                                          updataState(
                                              context,
                                              orientation ==
                                                      Orientation.landscape
                                                  ? true
                                                  : false);
                                        }

                                        if (turnes == 9) gameover = true;
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
                                        !Player.PlayerX.contains(index)
                                            ? (Player.PlayerO.contains(index)
                                                ? 'O'
                                                : '')
                                            : 'X',
                                        style: TextStyle(
                                          color: !Player.PlayerX.contains(index)
                                              ? (Player.PlayerO.contains(index)
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
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Text(
                          gameover ? '' : '$currentplayer Turn',
                          style: TextStyle(
                              fontFamily: 'Gameplay',
                              color: currentplayer == 'X'
                                  ? Colors.blue
                                  : Colors.red,
                              fontSize: 35),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void restartgame() {
    setState(() {
      gameover = false;
      currentplayer = 'X';
      turnes = 0;
      Player.PlayerX = [];
      Player.PlayerO = [];
    });
  }

  void updataState(BuildContext ctx, bool isLandscape) {
    List<dynamic> results = Player.checkwinner();
    setState(() {
      currentplayer = currentplayer == 'X' ? 'O' : 'X';
      turnes++;

      if (results[1]) {
        //restartgame();
        gameover = true;
        resultDialog(ctx, results, isLandscape);
      }
      if (turnes == 9 && !gameover && !results[1]) {
        //restartgame();
        gameover = true;
        resultDialog(ctx, results, isLandscape);
      }
    });
  }

  Future<dynamic> resultDialog(
      BuildContext ctx, List<dynamic> results, bool isLandscape) {
    return showDialog(
        barrierDismissible: true,
        context: ctx,
        builder: (ctx) {
          return Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: results[0] != 'X'
                    ? (results[0] == 'O'
                        ? Colors.red[900]
                        : const Color(0xff240046))
                    : Colors.blue[900],
              ),
              width: isLandscape
                  ? MediaQuery.of(context).size.width * 0.7
                  : MediaQuery.of(context).size.width * 0.7,
              height: isLandscape
                  ? MediaQuery.of(context).size.height * 0.7
                  : MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    results[1] ? '${results[0]} Won' : 'Draw',
                    style: TextStyle(
                        fontSize: isLandscape ? 50 : 25,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'Gameplay'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            restartgame();
                            Navigator.pop(ctx);
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: MyScaffold(),
                                    type: isLandscape
                                        ? PageTransitionType.rightToLeft
                                        : PageTransitionType.bottomToTop));
                          },
                          child: const Text(
                            'Main Menu',
                            style: TextStyle(fontFamily: 'Gameplay'),
                          )),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            restartgame();
                          },
                          child: const Text(
                            'Restart',
                            style: TextStyle(fontFamily: 'Gameplay'),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xo_game/game_logic.dart';

import 'my_scaffold.dart';

class GameScreenLandscape extends StatefulWidget {
  GameScreenLandscape(this.isComputer, {Key? key}) : super(key: key);

  bool isComputer;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreenLandscape> {
  bool gameover = false;

  String currentplayer = 'X';
  int turnes = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          restartgame();
        },
        child: const Icon(Icons.replay_rounded),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: FittedBox(
                      child: Text(
                        gameover ? '' : '$currentplayer Turn',
                        style: TextStyle(
                            fontFamily: 'Gameplay',
                            color:
                                currentplayer == 'X' ? Colors.blue : Colors.red,
                            fontSize: 35),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width * 0.50,
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
                                    Player.PlayerX.contains(index)) return;
                                Player.playgame(index, currentplayer);

                                updataState(context);
                                if (!gameover &&
                                    turnes != 9 &&
                                    widget.isComputer) {
                                  Player.autoplay(currentplayer);
                                  updataState(context);
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
                                    color: Colors.red, offset: Offset(2, 2))
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

  void updataState(BuildContext ctx) {
    List<dynamic> results = Player.checkwinner();
    setState(() {
      currentplayer = currentplayer == 'X' ? 'O' : 'X';
      turnes++;

      if (results[1]) {
        //restartgame();
        gameover = true;
        resultDialog(ctx, results);
      }
      if (turnes == 9 && !gameover && !results[1]) {
        //restartgame();
        gameover = true;
        resultDialog(ctx, results);
      }
    });
  }

  Future<dynamic> resultDialog(BuildContext ctx, List<dynamic> results) {
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
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    results[1] ? '${results[0]} Won' : 'Draw',
                    style: const TextStyle(
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
                                    type: PageTransitionType.bottomToTop));
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

import 'package:flutter/material.dart';

import 'package:xo_game/Widgets/animated_background.dart';
import 'package:page_transition/page_transition.dart';

import 'game_screen.dart';

class MyScaffoldLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBackground(true),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: const Center(
                    child: Text(
                      'X O',
                      style: TextStyle(
                        fontFamily: 'Strengthen',
                        color: Color(0xffd00000),
                        fontSize: 100,
                        shadows: [
                          Shadow(color: Colors.red, blurRadius: 70),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: GameScreen(true),
                                type: PageTransitionType.leftToRight));
                      },
                      child: const FittedBox(
                        child: Text(
                          'VS Computer',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gameplay',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: GameScreen(false),
                                type: PageTransitionType.leftToRight));
                      },
                      child: const FittedBox(
                        child: Text(
                          'VS Player',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gameplay',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

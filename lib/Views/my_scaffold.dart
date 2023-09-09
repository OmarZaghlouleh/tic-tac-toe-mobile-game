import 'package:flutter/material.dart';
import 'package:xo_game/View%20Models/multiplayer_view_model.dart';
import 'package:xo_game/Views/Auth/register_view.dart';
import 'package:xo_game/Views/game_screen.dart';
import 'package:xo_game/Views/game_screen_landscape.dart';
import 'package:xo_game/Views/Multiplayer/invite_player_view.dart';
import 'package:xo_game/Views/my_scaffold_landscape.dart';
import 'package:xo_game/Widgets/animated_background.dart';
import 'package:page_transition/page_transition.dart';
import 'package:xo_game/Widgets/main_screen_button.dart';
import 'package:xo_game/main.dart';
import 'package:xo_game/utils/color_manager.dart';
import 'package:xo_game/utils/extensions.dart';
import 'package:xo_game/utils/theme_manager.dart';

import '../utils/string_manager.dart';
import 'Multiplayer/landing_view.dart';

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) => SafeArea(
          child: Center(
              child: orientation == Orientation.portrait
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.20,
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
                        AnimatedBackground(false),
                        CustomButton(
                            title: StringManager.vsComputer,
                            icon: Icons.computer_rounded,
                            onPressed: () {
                              orientation == Orientation.portrait
                                  ? Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: GameScreen(true),
                                          type: PageTransitionType.topToBottom))
                                  : Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: GameScreenLandscape(true),
                                          type:
                                              PageTransitionType.topToBottom));
                            }),
                        CustomButton(
                            title: StringManager.vsPlayer,
                            icon: Icons.person_rounded,
                            onPressed: () {
                              orientation == Orientation.portrait
                                  ? Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: GameScreen(false),
                                          type: PageTransitionType.topToBottom))
                                  : Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: GameScreenLandscape(false),
                                          type:
                                              PageTransitionType.topToBottom));
                            }),
                        CustomButton(
                            title: StringManager.multiplayer,
                            icon: Icons.people_rounded,
                            onPressed: () {
                              if (sharedPreferences.getString('id') != null) {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: MultiplayerLandingView(),
                                        type: PageTransitionType.topToBottom));
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: RegisterView(),
                                        type: PageTransitionType.topToBottom));
                              }
                            })
                      ],
                    )
                  : MyScaffoldLandscape()),
        ),
      ),
    );
  }
}

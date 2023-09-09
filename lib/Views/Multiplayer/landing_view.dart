import 'package:flutter/material.dart';
import 'package:xo_game/Views/Multiplayer/accept_an_invite_view.dart';
import 'package:xo_game/Views/Multiplayer/invite_player_view.dart';
import 'package:xo_game/Widgets/main_screen_button.dart';
import 'package:xo_game/utils/extensions.dart';
import 'package:xo_game/utils/string_manager.dart';
import 'package:xo_game/utils/theme_manager.dart';

class MultiplayerLandingView extends StatelessWidget {
  const MultiplayerLandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                StringManager.multiplayer,
                style: ThemeManager.defaultTextStyle(fontSize: 40),
              ),
            ),
            20.space(),
            CustomButton(
                title: StringManager.inviteAPlayer,
                icon: Icons.send_rounded,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InvitePlayerView()));
                }),
            CustomButton(
                title: StringManager.acceptAnInvite,
                icon: Icons.send_rounded,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AcceptAnInviteView()));
                })
          ],
        ),
      )),
    );
  }
}

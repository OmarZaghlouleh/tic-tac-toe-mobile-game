import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xo_game/View%20Models/multiplayer_view_model.dart';
import 'package:xo_game/Widgets/custom_text_field.dart';
import 'package:xo_game/utils/extensions.dart';
import 'package:xo_game/utils/theme_manager.dart';

import '../../Widgets/loading_indicator.dart';
import '../../Widgets/main_screen_button.dart';
import '../../utils/string_manager.dart';

class AcceptAnInviteView extends StatelessWidget {
  const AcceptAnInviteView({Key? key}) : super(key: key);

  void init({required BuildContext context}) {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MultiplayerViewModel>(context, listen: false)
          .initMatchIdController();
    });
  }

  @override
  Widget build(BuildContext context) {
    init(context: context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                StringManager.acceptAnInvite,
                style: ThemeManager.defaultTextStyle(fontSize: 35),
              ),
            ),
            20.space(),
            CustomTextFormField(
              label: StringManager.matchId,
              icon: Icons.person,
              validator: () {},
              controller:
                  Provider.of<MultiplayerViewModel>(context, listen: false)
                      .getMatchIdController,
            ),
            // Selector<MultiplayerViewModel, int?>(
            //   selector: (p0, p1) => p1.getMatchId,
            //   builder: (context, value, child) => value == null
            //       ? const SizedBox.shrink()
            //       : Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(
            //             StringManager.matchIdMessage(
            //               id: value,
            //             ),
            //             style: ThemeManager.defaultTextStyle(
            //                 withFontFamily: false, fontSize: 18),
            //           ),
            //         ),
            // ),
            // 20.space(),
            Consumer<MultiplayerViewModel>(
              builder: (context, multiplayer, child) => multiplayer
                      .getActionLoadingState
                  ? const LoadingIndicator()
                  : CustomButton(
                      width: 200,
                      title: StringManager.search,
                      icon: Icons.done_rounded,
                      onPressed: !multiplayer.getIsMatchIdFilled
                          ? null
                          : () async {
                              await multiplayer.acceptInvite(context: context);
                            }),
            ),
          ]),
        ),
      ),
    );
  }
}

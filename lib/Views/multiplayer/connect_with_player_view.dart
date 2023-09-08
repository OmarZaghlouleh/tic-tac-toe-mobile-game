import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xo_game/View%20Models/multiplayer_view_model.dart';
import 'package:xo_game/Widgets/custom_text_field.dart';
import 'package:xo_game/Widgets/main_screen_button.dart';
import 'package:xo_game/utils/extensions.dart';
import 'package:xo_game/utils/string_manager.dart';
import 'package:xo_game/utils/theme_manager.dart';

import '../../Widgets/loading_indicator.dart';

class ConnectWithPlayerView extends StatelessWidget {
  const ConnectWithPlayerView({Key? key}) : super(key: key);

  void init({required BuildContext context}) {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<MultiplayerViewModel>(context, listen: false)
          .initCotrollers();
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
                StringManager.searchForPlayer,
                style: ThemeManager.defaultTextStyle(fontSize: 35),
              ),
            ),
            20.space(),
            CustomTextFormField(
              label: StringManager.playerName,
              icon: Icons.person,
              validator: () {},
              controller:
                  Provider.of<MultiplayerViewModel>(context, listen: false)
                      .getNameController,
            ),
            20.space(),
            Consumer<MultiplayerViewModel>(
              builder: (context, multiplayer, child) =>
                  multiplayer.getActionLoadingState
                      ? LoadingIndicator()
                      : CustomButton(
                          width: 200,
                          title: StringManager.search,
                          icon: Icons.done_rounded,
                          onPressed: !multiplayer.getIsNameFilled
                              ? null
                              : () async {
                                  await multiplayer.search(context: context);
                                }),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: Provider.of<MultiplayerViewModel>(context, listen: false)
                  .getUsers(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                      "Full Name: ${data['full_name']} ${data['last_name']}");
                }

                return Text("loading");
              },
            )
          ]),
        ),
      ),
    );
  }
}

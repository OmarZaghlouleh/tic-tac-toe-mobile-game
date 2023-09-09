import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xo_game/View%20Models/auth_view_model.dart';
import 'package:xo_game/Widgets/custom_text_field.dart';
import 'package:xo_game/Widgets/loading_indicator.dart';
import 'package:xo_game/Widgets/main_screen_button.dart';
import 'package:xo_game/utils/extensions.dart';
import 'package:xo_game/utils/string_manager.dart';
import 'package:xo_game/utils/theme_manager.dart';
import 'package:xo_game/utils/validators.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void init({required BuildContext context}) {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<AuthViewModel>(context, listen: false).initCotrollers();
    });
  }

  @override
  Widget build(BuildContext context) {
    init(context: context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              20.space(),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Selector<AuthViewModel, TextEditingController>(
                        selector: (p0, p1) => p1.getNameController,
                        builder: (context, value, child) => CustomTextFormField(
                            controller: value,
                            label: StringManager.name,
                            icon: Icons.person,
                            validator: () {}),
                      ),
                      Selector<AuthViewModel, TextEditingController>(
                        selector: (p0, p1) => p1.getEmailController,
                        builder: (context, value, child) => CustomTextFormField(
                          controller: value,
                          label: StringManager.email,
                          icon: Icons.email_outlined,
                          validator: () {},
                        ),
                      ),
                      Selector<AuthViewModel, TextEditingController>(
                        selector: (p0, p1) => p1.getPasswordController,
                        builder: (context, value, child) => CustomTextFormField(
                          obsecure: true,
                          controller: value,
                          label: StringManager.password,
                          icon: Icons.lock_outline,
                          validator: () {
                            return validatePassword(
                                password: value.text.trim());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.space(),
              Consumer<AuthViewModel>(
                builder: (context, auth, child) => auth.getActionLoadingState
                    ? LoadingIndicator()
                    : CustomButton(
                        width: 200,
                        title: StringManager.register,
                        icon: Icons.done_rounded,
                        onPressed:
                            !(auth.getIfEmailFilled && auth.getIfPasswordFilled)
                                ? null
                                : () async {
                                    Provider.of<AuthViewModel>(context,
                                            listen: false)
                                        .createUser(context: context);
                                  }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

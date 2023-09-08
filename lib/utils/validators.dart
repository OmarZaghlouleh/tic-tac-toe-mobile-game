import 'package:xo_game/utils/string_manager.dart';

String? validatePassword({required String password}) {
  if (password.trim().length < 6) {
    return StringManager.passwordLengthError;
  }
  return null;
}

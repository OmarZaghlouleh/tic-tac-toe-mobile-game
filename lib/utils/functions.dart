import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xo_game/Models/user_model.dart';
import 'package:xo_game/utils/string_manager.dart';

Future<void> setUserData({required User user}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('id', user.uid);
  sharedPreferences.setString(
      'name', user.displayName ?? "${StringManager.player}${user.uid}");
}

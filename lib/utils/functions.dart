import 'package:shared_preferences/shared_preferences.dart';

Future<void> setUserData({required String id, required String name}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString('id', id);
  sharedPreferences.setString('name', name);
}

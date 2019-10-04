import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String> setUserAvatar(String userAvatar) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userAvatar', userAvatar);
    return userAvatar;
  }

  Future<String> getUserAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userAvatar');
  }
}

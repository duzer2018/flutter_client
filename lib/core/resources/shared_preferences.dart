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

  Future<String> setUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
    return userName;
  }

  Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  Future<String> setEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    return email;
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }
}

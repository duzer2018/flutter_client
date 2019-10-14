import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<String> setUserAvatar(String userAvatar) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userAvatar', userAvatar);
    print("userAvatar === $userAvatar");
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

  Future<String> setPassword(String pass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pass', pass);
    return pass;
  }

  Future<String> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('pass');
  }

   Future<String> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("token = $token");
    prefs.setString('token', token);
    return token;
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

     Future<int> setId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', id);
    return id;
  }

  Future<int> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }
}

import 'package:flutter_client/core/resources/shared_preferences.dart';
import 'package:flutter_client/core/resources/network_manager.dart';

class Repository {

  final sharedPrefs = SharedPrefs();
  final network = Network();

  registerUser(String email, String password) =>
      network.registerUser(email, password);
  loginUser(String email, String password) =>
      network.loginUser(email, password);
  setUserAvatar(_image) => sharedPrefs.setUserAvatar(_image);
  getUserAvatar() => sharedPrefs.getUserAvatar();
  setUserName(userName) => sharedPrefs.setUserName(userName);
  getUserName() => sharedPrefs.getUserName();
  setEmail(email) => sharedPrefs.setEmail(email);
  getEmail() => sharedPrefs.getEmail();

  setPassword(pass) => sharedPrefs.setEmail(pass);
  getPassword() => sharedPrefs.getEmail();
  getToken() => sharedPrefs.getToken();
  getId() => sharedPrefs.getId();
  setToken(token) => sharedPrefs.setToken(token);

  updUser(name, id, token) => network.updUser(name, id, token);
  fetchUser(token) => network.fetchUser(token);

}
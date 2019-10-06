
import 'package:cdcalctest/core/models/user.dart';
import 'package:cdcalctest/core/resources/shared_preferences.dart';
  
import 'package:cdcalctest/core/resources/network_manager.dart';

class Repository {

  final sharedPrefs = SharedPrefs();
  final network = Network();

  registerUser() => network.registerUser();
  Future<User>loginUser() => network.loginUser();
  setUserAvatar(_image) => sharedPrefs.setUserAvatar(_image);
  getUserAvatar() => sharedPrefs.getUserAvatar();
  setUserName(userName) => sharedPrefs.setUserName(userName);
  getUserName() => sharedPrefs.getUserName();
  setEmail(email) => sharedPrefs.setEmail(email);
  getEmail() => sharedPrefs.getEmail();
}
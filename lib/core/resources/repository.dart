
import 'package:cdcalctest/core/resources/shared_preferences.dart';

class Repository {

  final sharedPrefs = SharedPrefs();

  setUserAvatar(_image) => sharedPrefs.setUserAvatar(_image);
  getUserAvatar() => sharedPrefs.getUserAvatar();
  setUserName(userName) => sharedPrefs.setUserName(userName);
  getUserName() => sharedPrefs.getUserName();
  setEmail(email) => sharedPrefs.setEmail(email);
  getEmail() => sharedPrefs.getEmail();

}
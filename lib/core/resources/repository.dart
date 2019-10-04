
import 'package:cdcalctest/core/resources/shared_preferences.dart';

class Repository {

  final sharedPrefs = SharedPrefs();

  setUserAvatar(_image) => sharedPrefs.setUserAvatar(_image);
  getUserAvatar() => sharedPrefs.getUserAvatar();

}
import 'package:cdcalctest/core/blocs/bloc_provider.dart';
import 'package:cdcalctest/core/models/user.dart';
import 'package:cdcalctest/core/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase {
  User user = User();
  final _repository = Repository();
  final _userDataController = BehaviorSubject<User>();
  final _userTokenController = BehaviorSubject<User>();

  Observable<User> get outUserData => _userDataController.stream;
  Observable<User> get outUserToken => _userTokenController.stream;

  register() async {
    user = await _repository.registerUser();
    print("user id bloc =" + user.userId);
//    _userTokenController.add(user.token);
  }

//  reportQuest(double lat, double lon, int id) {
//    Future<ReportData> report = _repository.report(_user, lat, lon, id);
//    _reportController.sink.addStream(report.asStream());
//  }

  login() async {

   _userTokenController.sink.add(await _repository.loginUser());

//   print("user token " +  user.token);

  }

  setUserAvatar(String userName) {
    _repository.setUserAvatar(user.avatarUrl);
  }

//  getUserAvatar() async {
//    var userAvatar = await _repository.getUserAvatar();
//    if (userAvatar != null) userAvatar.add(_image);
//  }

  setUserName(String userName) {
    _repository.setUserName(user.firstName);
  }

//  getUserName() async {
//    String userName = await _repository.getUserName();
//    userNameStream.add(userName);
//  }

  setEmail(String email) {
    _repository.setEmail(user.params.email);
  }

//  getEmail() async {
//    String email = await _repository.getEmail();
//    emailStream.add(email);
//  }

  @override
  void dispose() {
    _userDataController.close();
    _userTokenController.close();
  }
}
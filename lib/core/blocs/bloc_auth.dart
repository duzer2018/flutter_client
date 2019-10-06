import 'package:cdcalctest/core/blocs/bloc_provider.dart';
import 'package:cdcalctest/core/models/user.dart';
import 'package:cdcalctest/core/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase {
  User user = User();
  final _repository = Repository();
  final _userErrorController = BehaviorSubject<String>();
  final _userTokenController = BehaviorSubject<String>();

  Observable<String> get outUserError => _userErrorController.stream;
  Observable<String> get outUserToken => _userTokenController.stream;

  register(String email, String password) async {
    user = await _repository.registerUser(email, password);
    _userTokenController.add(user.token);
    _setUserShared(user);
    _addError();
  }

  login(String email, String password) async {
    user = await _repository.loginUser(email, password);
   _userTokenController.sink.add(user.token);
    _setUserShared(user);
    _addError();
  }

  _addError(){
    if (user.error != null)
      _userErrorController.add(user.error);
  }

  setAuthShared(String email, String password){
    _repository.setEmail(email);
    _repository.setPassword(password);
  }

  _setUserShared(User user){
    if (user.avatarUrl != null){
      _repository.setUserAvatar(user.avatarUrl);
    }
    if (user.firstName != null){
      _repository.setUserAvatar(user.firstName);
    }
  }

  @override
  void dispose() {
    _userErrorController.close();
    _userTokenController.close();
  }
}
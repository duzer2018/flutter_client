import 'package:flutter_client/core/blocs/bloc_provider.dart';
import 'package:flutter_client/core/models/user.dart';
import 'package:flutter_client/core/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase {
  User user = User();
  final _repository = Repository();
  final _userErrorController = BehaviorSubject<String>();
  final _userTokenController = BehaviorSubject<String>();

  Observable<String> get outUserError => _userErrorController.stream;
  Observable<String> get outUserToken => _userTokenController.stream;

  AuthBloc(){
    getAuthShared();
  }

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

  setAuthShared(String token){
    _repository.setToken(token);
  }

  getAuthShared() async {
    String token = await _repository.getToken();
    if(token != null)
      _userTokenController.add(token);
  }

  _setUserShared(User user){
    if (user.avatarUrl != null){
      _repository.setUserAvatar(user.avatarUrl);
    }
  }

  @override
  void dispose() {
    _userErrorController.close();
    _userTokenController.close();
  }
}
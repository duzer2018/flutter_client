import 'package:cdcalctest/core/blocs/bloc_provider.dart';
import 'package:cdcalctest/core/models/user.dart';
import 'package:cdcalctest/core/resources/repository.dart';

class AuthBloc extends BlocBase {
  User user = User();
  final _repository = Repository();

  register() async {
    user = await _repository.registerUser();
    print("user id bloc =" + user.userId);
  }

  login() async {
    await _repository.loginUser();
  }


  @override
  void dispose() {
    // TODO: implement dispose
  }

}
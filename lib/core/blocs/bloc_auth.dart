import 'package:cdcalctest/core/blocs/bloc_provider.dart';
import 'package:cdcalctest/core/resources/repository.dart';

class AuthBloc extends BlocBase {
  final _repository = Repository();

  register() async {
    await _repository.registerUser();
  }


  @override
  void dispose() {
    // TODO: implement dispose
  }

}
import 'package:cdcalctest/core/resources/network_manager.dart';

class Repository {
  final network = Network();

  registerUser() => network.registerUser();
  loginUser() => network.loginUser();
}
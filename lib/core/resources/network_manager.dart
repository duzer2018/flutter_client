import 'package:cdcalctest/core/models/user.dart';
import 'package:jsonrpc2/jsonrpc_io_client.dart';

class Network{
  static const String BASE_URL = 'https://m.ugnest.com/rpc/v1';
  ServerProxy proxy = ServerProxy('https://m.ugnest.com/rpc/v1');
  User user = User();

  Future<User> loginUser(String email, String password) async{
    await proxy.call('auth.login', {
      'phone': email,
      'password': password
    })
        .then((returned)=>proxy.checkError(returned))
        .then((result){
          user = User.fromResult(result);
          print("login: $result");
        })
        .catchError((error){
          user = User.fromError(error);
          print(error);
        });
    return user;
  }

  Future<User> registerUser(String email, String password) async{
    await proxy.call('auth.reg', {
    'phone': email,
    'password': password
    })
        .then((returned)=>proxy.checkError(returned))
        .then((result){
          print("register: $result");
          user = User.fromResult(result);
          print("user id =  ${user.userId} \n  user email = ${user.params.email} "
              "\n user avatar = ${user.avatarUrl}");
        }).catchError((error){
          user = User.fromError(error);
          print("user error "+ user.error);
          print("register error "+ error.toString());
        });
    return user;
  }
}

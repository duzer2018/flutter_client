import 'dart:convert';
import 'dart:io';

import 'package:cdcalctest/core/models/user.dart';
import 'package:jsonrpc2/jsonrpc_io_client.dart';
import 'package:http/http.dart' as http;

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
          updUser(user, password);

    })
        .catchError((error){
          user = User.fromError(error);
          print(error);
        });
    return user;
  }

//  Future<void> loginUser(String email, String password) async{
////    var body = jsonEncode({'id': 1, 'method': 'auth.login','jsonrpc':'2.0'});
////    Map header = <String, String>{
////      'phone': email,'password': password,
////      "Content-Type": "application/json"
////    };
//
//    var body = jsonEncode({
//      'id': 2,
//      'method': 'auth.login',
//      'jsonrpc':'2.0',
//      'params': {
//        'phone': email,
//        'password': password}});
//    return await http.post(BASE_URL, body: body,).then((http.Response response){
//      var jsonResponse = json.decode(response.body);
//      print('loginUser  body: ${response.body}');
//
//      user = User.fromResult(jsonResponse);
//      updUser(user, password);
//    });
//  }

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
          updUser(user, password);
        }).catchError((error){
          user = User.fromError(error);
          print("user error "+ user.error);
          print("register error "+ error.toString());
        });
    return user;
  }

  Future<User> updUser(User user, String pwd) async {
    Map header = <String, String>{HttpHeaders.authorizationHeader:'Bearer ${user.token}',};
    var body = jsonEncode({
    'id': 2,
    'jsonrpc':'2.0',
    'method': 'users.Update',
    'params': {
      'user': {
        'firstName': 'takobel222', //тут мы меняем имя юзера
        'Password': "$pwd",
        'isAdmin': false,
        'isModerator': false,
        'isSupervisor': false,
        'userId': user.userId,
    }}});
    return await http
        .post(BASE_URL, headers: header, body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      print("response.statusCode = $statusCode");
      print("response.body updUser " + response.body);
    });
  }

  Future<void> _makeHTTPLogin() async{
    var body = jsonEncode({'id': 1, 'method': 'auth.login','jsonrpc':'2.0'});
    Map header = <String, String>{
      'phone':'kirill12334@zhuharev.ru','password':'Qqqq689689',
      "Content-Type": "application/json"
    };
    var response = await http.post(BASE_URL, body: body, headers: header);
    print('_makeHTTPLogin  body: ${response.body}');
  }

//    var body = jsonEncode({'id': 1, 'method': 'auth.login','jsonrpc':'2.0', 'phone':'kirill1233455667@zhuharev.ru','password':'rf#45&Qqqq689689'});
//    Map header = <String, String>{
//      'phone':'kirill1233455667@zhuharev.ru','password':'rf#45&Qqqq689689',
//      "Content-Type": "application/json"
//    };
//    var response = await http.post(BASE_URL, body: body);
//    print('_makeHTTPLogin  body: ${response.body}');



//  Future<User> updUser(User user, String pwd) async{
//        user.firstName = "takobel222";
//        print("user.firstName " + user.firstName);
//        print("user.token " + user.token);
//
//    print("user id " + user.userId.toString());
//    await proxy.call('users.Update',
//      {'Authorization':'Bearer ${user.token}',
//        "user": {
//        "Password": "$pwd",
//        "isAdmin": false,
//        "isModerator": false,
//        "isSupervisor": false,
//        "userId": user.userId,
//      }}
//      )
//        .then((returned)=>proxy.checkError(returned))
//        .then((result){
//      print("updUser: $result");
//      user = User.fromResult(result);
//      print("user firstName=  ${user.firstName}");
//      print("user token=  ${user.token}");
//    }).catchError((error){
//      user = User.fromError(error);
//      print("user error "+ user.error);
//      print("register error "+ error.toString());
//    });
//    return user;
//  }
//

}

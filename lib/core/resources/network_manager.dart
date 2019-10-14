import 'dart:convert';
import 'dart:io';

import 'package:cdcalctest/core/models/user.dart';
import 'package:cdcalctest/core/resources/shared_preferences.dart';
import 'package:jsonrpc2/jsonrpc_io_client.dart';
import 'package:http/http.dart' as http;

class Network {
  static const String BASE_URL = 'https://m.ugnest.com/rpc/v1';
  ServerProxy proxy = ServerProxy('https://m.ugnest.com/rpc/v1');
  User user = User();

  Future<User> loginUser(String email, String password) async {
    await proxy
        .call('auth.login', {'phone': email, 'password': password})
        .then((returned) => proxy.checkError(returned))
        .then((result) {
          user = User.fromResult(result);
          SharedPrefs().setToken(user.token);
          SharedPrefs().setId(user.userId);
          print("login: $result");
        })
        .catchError((error) {
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

  Future<User> registerUser(String email, String password) async {
    await proxy
        .call('auth.reg', {'phone': email, 'password': password})
        .then((returned) => proxy.checkError(returned))
        .then((result) {
          print("register: $result");
          user = User.fromResult(result);
          print(
              "user id =  ${user.userId} \n  user email = ${user.params.email} "
              "\n user avatar = ${user.avatarUrl}");
        })
        .catchError((error) {
          user = User.fromError(error);
          SharedPrefs().setToken(user.token);
          SharedPrefs().setId(user.userId);
          print("user error " + user.error);
          print("register error " + error.toString());
        });
    return user;
  }

  Future<User> updUser(String name, String pwd, int id, String token) async {
    Map header = <String, String>{
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    var body = jsonEncode({
      'id': 2,
      'jsonrpc': '2.0',
      'method': 'users.Update',
      'params': {
        'user': {
          'firstName': name, //тут мы меняем имя юзера
          'Password': "$pwd",
          'isAdmin': false,
          'isModerator': false,
          'isSupervisor': false,
          'userId': id,
        }
      }
    });
    await http
        .post(BASE_URL, headers: header, body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      var jsonResponse = json.decode(response.body);
      print("jsonResponse = $jsonResponse");
      var jsonString = json.encode(jsonResponse);
      print("jsonString = $jsonString");
      print("response.statusCode = $statusCode");
      print("response.body updUser " + response.body);
      fetchUser(name, pwd, id, token);
    });
  }

  Future<UserMi> fetchUser(
      String name, String pwd, int id, String token) async {
    Map header = <String, String>{
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    var body = jsonEncode({
      'id': 2,
      'jsonrpc': '2.0',
      'method': 'users.Me',
      'params': {
        'user': {
          'firstName': name,
          'Password': "$pwd",
          'isAdmin': false,
          'isModerator': false,
          'isSupervisor': false,
          'userId': id,
        }
      }
    });
    var response = await http.post(BASE_URL, headers: header, body: body);
    var jsonResponse = json.decode(response.body);
    print("response.body = ${response.body}");
    var user = UserMi.fromJson(jsonResponse);
    SharedPrefs().setUserName(user.result.firstName);
    return user;
  }

  Future<void> _makeHTTPLogin() async {
    var body = jsonEncode({'id': 1, 'method': 'auth.login', 'jsonrpc': '2.0'});
    Map header = <String, String>{
      'phone': 'kirill12334@zhuharev.ru',
      'password': 'Qqqq689689',
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

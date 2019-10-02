import 'dart:convert';
import 'package:http/http.dart' as http;

class Network{
  static const String BASE_URL = 'https://m.ugnest.com/rpc/v1';

  Future<void> loginUser() async{
    var body = jsonEncode({'id': 1, 'method': 'auth.login','jsonrpc':'2.0'});
    Map header = <String, String>{
      'phone':'kirill12334@zhuharev.ru','password':'Qqqq689689',
      "Content-Type": "application/json"
    };
    var response = await http.post(BASE_URL, body: body, headers: header);
    print('_makeHTTPLogin  body: ${response.body}');
  }

  Future<void> registerUser() async{
    var body = jsonEncode({'id': 2, 'method': 'auth.reg','jsonrpc':'2.0'});
    Map header = <String, String>{
      'phone':'hello@gmail.com','password':'ghfghfghfthfthfthQqqq689689',
      "Content-Type": "application/json"
    };
    var response = await http.post(BASE_URL, body: body, headers: header);
    print('_makeHTTPReg  body: ${response.body}');
  }
}
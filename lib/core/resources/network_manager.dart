import 'dart:convert';
import 'package:cdcalctest/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:jsonrpc2/jsonrpc_io_client.dart';

class Network{
  static const String BASE_URL = 'https://m.ugnest.com/rpc/v1';
  ServerProxy proxy = ServerProxy('https://m.ugnest.com/rpc/v1');

  Future<void> loginUser() async{
//    var body = jsonEncode({'id': 1, 'method': 'auth.login','jsonrpc':'2.0', 'phone':'kirill1233455667@zhuharev.ru','password':'rf#45&Qqqq689689'});
//    Map header = <String, String>{
//      'phone':'kirill1233455667@zhuharev.ru','password':'rf#45&Qqqq689689',
//      "Content-Type": "application/json"
//    };
//    var response = await http.post(BASE_URL, body: body);
//    print('_makeHTTPLogin  body: ${response.body}');

    proxy.call('auth.login', {
      'phone':'kirill1233455667@zhuharev.ru',
      'password':'rf#45&Qqqq689689'
    })
        .then((returned)=>proxy.checkError(returned))
        .then((result){print("body: $result");})
        .catchError((error){print(error);});
  }

  Future<User> registerUser() async{
    User user = User();
    proxy.call('auth.reg', {
      'phone':'kirill123345566789019@zhuharev.ru',
      'password':'rf#45&Qqqq689689'
    })
        .then((returned)=>proxy.checkError(returned))
        .then((result){
          print("body: $result");
          user = User.fromResult(result);
          print("user id =  ${user.userId} \n  user email = ${user.params.email} "
              "\n user avatar = ${user.avatarUrl}");
        }).catchError((error){print(error);});
    return user;
  }
}
//body: {"jsonrpc":"2.0","id":2,"result":{"userId":5447,"firstName":"","lastName":"","Role":0,
//"params":{"promotedBy":0,"attributes":null,"email":"kirill123345566@zhuharev.ru","bio":"","bdate":"0001-01-01T00:00:00Z","hometown":""},
//"username":"","Status":0,"avatarUrl":"https://sun1-28.userapi.com/c846416/v846416629/1197f7/gks30F_xp7A.jpg?ava=1",
//"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTQ0NywiZXhwIjoxNTc1Mjc5Nzk3LCJpc3MiOiJ1Z25lc3QuY29tIn0.sWPxWtsoTtH78LxfHtKa3JXltb0oSYtCRSjpedsfCsI"}}

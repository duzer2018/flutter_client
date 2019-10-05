class User {
  String userId;
  Params params;
  String avatarUrl;

  User({this.userId, this.params, this.avatarUrl});

  factory User.fromResult(Map<String, dynamic> json) {
    return User(
      userId: json['userId'].toString(),
      params: Params.fetchResult(json['params']),
      avatarUrl: json['avatarUrl'] as String,
    );
  }
}
class Params {
  String email;

  Params({this.email});

  factory Params.fetchResult(Map<String, dynamic> json){
    return Params(email: json['email'] as String);
  }
}

//body: {"jsonrpc":"2.0","id":2,"result":{"userId":5447,"firstName":"","lastName":"","Role":0,
//"params":{"promotedBy":0,"attributes":null,"email":"kirill123345566@zhuharev.ru","bio":"","bdate":"0001-01-01T00:00:00Z","hometown":""},
//"username":"","Status":0,"avatarUrl":"https://sun1-28.userapi.com/c846416/v846416629/1197f7/gks30F_xp7A.jpg?ava=1",
//"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTQ0NywiZXhwIjoxNTc1Mjc5Nzk3LCJpc3MiOiJ1Z25lc3QuY29tIn0.sWPxWtsoTtH78LxfHtKa3JXltb0oSYtCRSjpedsfCsI"}}


//{
//"jsonrpc": "2.0",
//"id": "1",
//"result": {
//"userId": 371
//}
//}

//Пример ответа с ошибкой:
//
//{
//"jsonrpc": "2.0",
//"id": "1",
//"error": {
//"code": 507,
//"message": "login already taken"
//}
//}
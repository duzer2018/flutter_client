class User {
  String userId;
  String firstName;
  Params params;
  String avatarUrl;
  String error;
  String token;

  User({this.userId, this.firstName, this.params, this.avatarUrl, this.token, this.error});

  factory User.fromResult(Map<String, dynamic> json) {
    return User(
      userId: json['userId'].toString(),
      firstName: json['firstName'].toString(),
      params: Params.fetchResult(json['params']),
      avatarUrl: json['avatarUrl'] as String,
      token: json['token'] as String,
    );
  }

  factory User.fromError(Map<String, dynamic> json) {
    return User(
      error: json['error'].toString(),
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

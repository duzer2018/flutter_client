import 'package:flutter_client/core/blocs/bloc_auth.dart';
import 'package:flutter_client/core/ui/slider_view.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.onSignIn}) : super(key: key);

  final VoidCallback onSignIn;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  static final RegExp nameRegExp2 = RegExp(
      "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+");
  bool _validate = false;
  String _email, _password;
  double _width = 0;
  double _height = 0;
  double _signInWidth = 220;
  double _signInHeight = 50;
  double _registerWidth = 220;
  double _registerHeight = 50;
  double _logoWidth = 250;
  double _logoHeight = 250;
  bool loginButton = true;
  Border border = null;
  final authBloc = AuthBloc();

  @override
  void initState() {
    authBloc.outUserToken.listen((token) =>
        _pushToTabs(token, authBloc)
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    
    return new Scaffold(
        body: ListView(children: <Widget>[
      Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            SafeArea(
                child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.decelerate,
                    width: _logoWidth,
                    height: _logoHeight,
                    child: Image.asset("assets/avatar.png"))),
            Column(
              children: <Widget>[
                Container(
                  child: loginAndRegistration(),
                ),
                SizedBox(height: 20),
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.decelerate,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blueGrey),
                  width: _signInWidth,
                  height: _signInHeight,
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      setState(() {
                        border = Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.blueGrey);
                        _width = 300;
                        _height = 240;
                        _signInWidth = 0;
                        _signInHeight = 0;
                        _logoWidth = 200;
                        _logoHeight = 200;
                        loginButton = true;
                        if (_registerWidth == 0 && _registerHeight == 0) {
                          _registerWidth = 220;
                          _registerHeight = 50;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(height: 10),
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.decelerate,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.blueGrey),
                  width: _registerWidth,
                  height: _registerHeight,
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text(
                      "Create an account",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      setState(() {
                        border = Border.all(
                            width: 2,
                            style: BorderStyle.solid,
                            color: Colors.blueGrey);
                        loginButton = false;
                        _width = 300;
                        _height = 240;
                        _logoWidth = 200;
                        _logoHeight = 200;
                        _registerWidth = 0;
                        _registerHeight = 0;
                        _signInWidth = 220;
                        _signInHeight = 50;
                      });
                    },
                  ),
                ),
                SizedBox(height: 7),
//                          GoogleSignInButton(
//                              borderRadius: 10,
//                              darkMode: true,
//                              onPressed: () =>
//                                  authService.googleSignIn().whenComplete(() {
//                                    if (authService.users.email != null) {
//                                      Navigator.of(context)
//                                          .push(
//                                          MaterialPageRoute(builder: (context) {
//                                            return FireMap();
//                                          }));
//                                    }
//                                  })),
              ],
            ),
          ]))
    ]));
  }

  loginAndRegistration() {
    // authBloc.outUserToken.listen((token) => _pushToTabs(token, authBloc));
    authBloc.outUserError
        .listen((error) => new SnackBar(content: new Text(error.toString())));
    return AnimatedContainer(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(color: Colors.grey[200], border: border),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: _width,
        height: _height,
        child: Form(
            key: _formKey,
            autovalidate: _validate,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) => value.isEmpty
                        ? 'Your email address is empty'
                        : (nameRegExp2.hasMatch(value)
                            ? null
                            : 'Not a valid email'),
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value.length < 6)
                        return "Your password needs to be atleast 6 characters";
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 10),
                  loginButton == true
                      ? Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: MaterialButton(
                            textColor: Colors.white,
                            child: Text("Login"),
                            onPressed: () {
                              login(authBloc);
                            },
                          ))
                      : Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: MaterialButton(
                            textColor: Colors.white,
                            child: Text("Registration"),
                            onPressed: () {
                              registration(authBloc);
                            },
                          )),
                ])));
  }

  login(authBloc) {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      _formKey.currentState.save();
      authBloc.login(_email, _password);
      print("auth $_email $_password");
      _formKey.currentState.save();
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  registration(authBloc) {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      _formKey.currentState.save();
      authBloc.register(_email, _password);
      print("auth $_email $_password");
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  _pushToTabs(String token, AuthBloc authBloc) {
    if (token != null) {
      authBloc.setAuthShared(token);
      Navigator.pushReplacement(
         context, MaterialPageRoute(builder: (context) => SliderView()));
    }
  }
}

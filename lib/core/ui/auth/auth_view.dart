import 'package:cdcalctest/core/blocs/bloc_auth.dart';
import 'package:cdcalctest/core/blocs/bloc_provider.dart';
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
  String _email, _password;
  double _width = 0;
  double _height = 0;
  double _signInWidth = 220;
  double _signInHeight = 40;
  double _registerWidth = 220;
  double _registerHeight = 40;
  double _logoWidth = 250;
  double _logoHeight = 250;
  bool loginButton = true;
  Border border = null;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            child: Center(
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
                          SizedBox(height: 10),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 600),
                            curve: Curves.decelerate,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                color: Colors.blueGrey),
                            width: _signInWidth,
                            height: _signInHeight,
                            child: MaterialButton(
                              textColor: Colors.white,
                              child: Text(
                                "Sign in",
                                style:
                                TextStyle(fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () {
                                setState(() {
                                  border = Border.all(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Colors.blueGrey);
                                  _width = 300;
                                  _height = 200;
                                  _signInWidth = 0;
                                  _signInHeight = 0;
                                  _logoWidth = 200;
                                  _logoHeight = 200;
                                  loginButton = true;
                                  if (_registerWidth == 0 &&
                                      _registerHeight == 0) {
                                    _registerWidth = 220;
                                    _registerHeight = 40;
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
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                color: Colors.blueGrey),
                            width: _registerWidth,
                            height: _registerHeight,
                            child: MaterialButton(
                              textColor: Colors.white,
                              child: Text(
                                "Create an account",
                                style:
                                TextStyle(fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () {
                                setState(() {
                                  border = Border.all(
                                      width: 2,
                                      style: BorderStyle.solid,
                                      color: Colors.blueGrey);
                                  loginButton = false;
                                  _width = 300;
                                  _height = 200;
                                  _logoWidth = 200;
                                  _logoHeight = 200;
                                  _registerWidth = 0;
                                  _registerHeight = 0;
                                  _signInWidth = 220;
                                  _signInHeight = 40;
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
                    ]))));
  }

  loginAndRegistration() {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return AnimatedContainer(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(color: Colors.grey[200], border: border),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: _width,
        height: _height,
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value.isEmpty) return "Please type an Email";
                },
                onSaved: (value) => _email = value,
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
                onSaved: (value) => _password = value,
              ),
              SizedBox(height: 10),
              loginButton == true
                  ? Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Login"),
                    onPressed: () {

                    },
                  ))
                  : Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: MaterialButton(
                    textColor: Colors.white,
                    child: Text("Registration"),
                    onPressed: () {
                      authBloc.register();
                    },
                  ))
            ])));
  }

  login() {
    final formState = _formKey.currentState;
    if (formState.validate()) {

    }
  }
}
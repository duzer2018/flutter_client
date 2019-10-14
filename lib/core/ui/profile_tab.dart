import 'dart:io';
import 'dart:math';

import 'package:cdcalctest/core/blocs/bloc_profile.dart';
import 'package:cdcalctest/core/ui/auth/auth_view.dart';
import 'package:cdcalctest/core/ui/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileTabState();
  }
}

class ProfileTabState extends State<ProfileTab> {
  final profileBloc = ProfileBloc();
  String name;
  String email;
  static final RegExp nameRegExp = RegExp('[a-zA-Z-а-яА-Я-]');
  static final RegExp nameRegExp2 = RegExp(
      "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+");
  GlobalKey<FormState> _nameKey = new GlobalKey();
  GlobalKey<FormState> _emailKey = new GlobalKey();
  bool _validate = false;
  bool _validate2 = false;
  FocusNode _nameFocus;
  FocusNode _emailFocus;

  @override
  void initState() {
    profileBloc.getUserAvatar();
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _nameFocus.addListener(() {
      if (!_nameFocus.hasFocus) saveName();
    });
    _emailFocus.addListener(() {
      if (!_emailFocus.hasFocus) saveEmail();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Stack(children: <Widget>[
        Container(
            child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                  stream: profileBloc.outUserAvatar,
                  builder: (context, snapshot) {
                    return Container(
                        width: 270,
                        height: 270,
                        child: Stack(children: <Widget>[
                          Center(
                              child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: snapshot.data != null
                                      ? FileImage(File(snapshot.data))
                                      : AssetImage("assets/user.png")),
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          )),
                          Positioned(
                              bottom: 20,
                              right: 20,
                              child: FloatingActionButton(
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.photo_camera),
                                onPressed: () => bottomSheet(context),
                              )),
                        ]));
                  }),
            ],
          ),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(children: <Widget>[
                Text("User Name:",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                Form(
                  key: _nameKey,
                  autovalidate: _validate,
                  child: formInput(),
                ),
                SizedBox(height: 20),
                Text("Email:", style: TextStyle(fontWeight: FontWeight.w600)),
                Form(
                    key: _emailKey,
                    autovalidate: _validate2,
                    child: emailFormInput()),
              ])),
        ])),
        Positioned(
          right: 10,
          top: 10,
          child: FloatingActionButton(
            heroTag: "logOut",
            onPressed: () {
              profileBloc.setToken("");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: 
            Transform.rotate(
              angle: 180 * pi / 180,
              child: 
               Icon(Icons.exit_to_app),
          )),
        )
      ])
    ]);
  }

  Widget formInput() {
    return StreamBuilder(
      stream: profileBloc.outUserName,
      builder: (context, snapshot) {
        return TextFormField(
          maxLength: 25,
          focusNode: _nameFocus,
          decoration: InputDecoration(
              hasFloatingPlaceholder: false,
              alignLabelWithHint: true,
              hintText: snapshot.data != null ? snapshot.data : ""),
          validator: (value) => value.length < 3
              ? 'Name less than 3 characters'
              : (nameRegExp.hasMatch(value) ? null : 'Enter a Valid Name'),
          onSaved: (String val) {
            name = val;
          },
        );
      },
    );
  }

  Widget emailFormInput() {
    return StreamBuilder(
      stream: profileBloc.outEmail,
      builder: (context, snapshot) {
        return TextFormField(
          focusNode: _emailFocus,
          decoration: InputDecoration(
              hasFloatingPlaceholder: false,
              alignLabelWithHint: true,
              hintText: snapshot.data),
          validator: (value) => value.isEmpty
              ? 'Your email address is empty'
              : (nameRegExp2.hasMatch(value) ? null : 'Enter a Valid E-mail'),
          onSaved: (String val) {
            name = val;
          },
        );
      },
    );
  }

  saveName() {
    if (_nameKey.currentState.validate()) {
      _nameKey.currentState.save();
      profileBloc.setUserName(name);
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  saveEmail() {
    if (_emailKey.currentState.validate()) {
      _emailKey.currentState.save();
      profileBloc.setEmail(email);
    } else {
      setState(() {
        _validate2 = true;
      });
    }
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Text("Choose photo",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                BotSheet(
                  icon: Icons.photo_camera,
                  label: "Take photo",
                  onTap: () {
                    profileBloc.getImageFromCamera();
                    Navigator.of(context).pop(true);
                  },
                ),
                BotSheet(
                  icon: Icons.photo,
                  label: "Upload from gallery",
                  onTap: () {
                    profileBloc.getImageFromGallery();
                    Navigator.of(context).pop(true);
                  },
                ),
                BotSheet(
                  icon: Icons.delete,
                  label: "Remove photo",
                  onTap: () {
                    profileBloc.userAvatarStream.add(null);
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          );
        });
  }
}

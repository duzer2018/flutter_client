import 'package:cdcalctest/core/blocs/bloc_profile.dart';
import 'package:cdcalctest/core/ui/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class PrifileTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PrifileTabState();
  }
}

class PrifileTabState extends State<PrifileTab> {
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
    // profileBloc.getUserAvatar();
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
    return Container(
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
                                  ? FileImage(snapshot.data)
                                  : AssetImage("assets/user.png")),
                          border: Border.all(width: 3, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
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
            Text("User Name:", style: TextStyle(fontWeight: FontWeight.w600)),
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
    ]));
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
              hintText: snapshot.data),
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
            email = val;
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

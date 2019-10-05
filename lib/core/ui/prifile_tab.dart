import 'package:cdcalctest/core/blocs/bloc_profile.dart';
import 'package:cdcalctest/core/ui/widgets/bottom_sheet.dart';
import 'package:cdcalctest/core/ui/widgets/text_form.dart';
import 'package:flutter/material.dart';

class PrifileTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PrifileTabState();
  }
}

class PrifileTabState extends State<PrifileTab> {
  final profileBloc = ProfileBloc();
  String name = "Tony Stark";
  String email = '';
  static final RegExp nameRegExp = RegExp('[a-zA-Z-а-яА-Я-]');
  static final RegExp nameRegExp2 = RegExp("[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+");
  GlobalKey<FormState> _key = new GlobalKey();
  GlobalKey<FormState> _key2 = new GlobalKey();
  bool _validate = false;
  FocusNode _focusNode;

  @override
  void initState() {
    // profileBloc.getUserAvatar();
    profileBloc.getEmail();
    profileBloc.getUserName();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) saveName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            StreamBuilder(
                stream: profileBloc.outUserAvatar,
                builder: (context, snapshot) {
                  return Container(
                      width: 210,
                      height: 220,
                      child: Stack(children: <Widget>[
                        Center(
                            child: Container(
                          width: 150,
                          height: 150,
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
            Container(
                width: 170,
                child: Form(
                    key: _key, autovalidate: _validate, child: UserTextForm(stream: profileBloc.outUserName,
                    focusNode: _focusNode, nameRegExp: nameRegExp, onSaved: (String val) {
            name = val;
          },))),
          ],
        ),
      ]))
    ]);
  }


  Widget formInput() {
    return StreamBuilder(
      stream: profileBloc.outUserName,
      builder: (context, snapshot) {
        return TextFormField(
          maxLength: 25,
          focusNode: _focusNode,
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

  saveName() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      profileBloc.setUserName(name);
    } else {
      setState(() {
        _validate = true;
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
                  onTap: () => profileBloc.getImageFromCamera(),
                ),
                BotSheet(
                  icon: Icons.photo,
                  label: "Upload from gallery",
                  onTap: () => profileBloc.getImageFromGallery(),
                ),
                BotSheet(
                  icon: Icons.delete,
                  label: "Remove photo",
                  onTap: () => profileBloc.userAvatarStream.add(null),
                )
              ],
            ),
          );
        });
  }
}

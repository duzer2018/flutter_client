import 'package:flutter/material.dart';

class UserTextForm extends StatefulWidget{
  UserTextForm({@required this.stream, this.focusNode, this.nameRegExp, this.onSaved});

  final stream;
  final focusNode;
  final nameRegExp;
  final onSaved;

  @override
  State<StatefulWidget> createState() {
    return UserTextFormState();
  }
}

class UserTextFormState extends State<UserTextForm>{
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return TextFormField(
          maxLength: 25,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
              hasFloatingPlaceholder: false,
              alignLabelWithHint: true,
              hintText: snapshot.data),
          validator: (value) => value.length < 3
              ? 'Name less than 3 characters'
              : (widget.nameRegExp.hasMatch(value) ? null : 'Enter a Valid Name'),
          onSaved: widget.onSaved
        );
      },
    );
  }
}
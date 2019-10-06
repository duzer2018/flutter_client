import 'dart:async';
import 'dart:io';

import 'package:cdcalctest/core/blocs/bloc_provider.dart';
import 'package:cdcalctest/core/resources/repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc extends BlocBase {
  ProfileBloc() {
    getUserName();
    getEmail();
  }

  File _image;

  final userAvatarStream = BehaviorSubject();
  final userNameStream = BehaviorSubject();
  final emailStream = BehaviorSubject();
  final _repository = Repository();

  Observable get outUserAvatar => userAvatarStream.stream;
  Observable get outUserName => userNameStream.stream;
  Observable get outEmail => emailStream.stream;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
    userAvatarStream.add(_image);
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    userAvatarStream.add(_image);
    _repository.setUserAvatar(_image.toString());
  }

  getUserAvatar() async {
    var userAvatar = await _repository.getUserAvatar();
    if (userAvatar != null) userAvatar.add(_image);
  }

  setUserName(String userName) {
    _repository.setUserName(userName);
  }

  getUserName() async {
    String userName = await _repository.getUserName();
    userNameStream.add(userName);
  }

  setEmail(String email) {
    _repository.setEmail(email);
  }

  getEmail() async {
    String email = await _repository.getEmail();
    emailStream.add(email);
  }

  dispose() {
    userAvatarStream.close();
    userNameStream.close();
    emailStream.close();
  }
}

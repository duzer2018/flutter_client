import 'dart:async';
import 'dart:io';
import 'package:cdcalctest/core/blocs/bloc_provider.dart';
import 'package:cdcalctest/core/models/user.dart';
import 'package:cdcalctest/core/resources/repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ProfileBloc extends BlocBase {
  ProfileBloc() {
    getUserName();
    getEmail();
  }

  File _image;
  String pwd = "123456ppnn";

  final userAvatarStream = BehaviorSubject();
  final userNameStream = BehaviorSubject();
  final emailStream = BehaviorSubject();
  final _repository = Repository();

  Observable get outUserAvatar => userAvatarStream.stream;
  Observable get outUserName => userNameStream.stream;
  Observable get outEmail => emailStream.stream;

  Future getImageFromCamera() async {
    // var image = await
    ImagePicker.pickImage(source: ImageSource.camera)
        .then((File recordedImage) {
      GallerySaver.saveImage(recordedImage.path);
      _image = recordedImage;
      userAvatarStream.add(_image.path);
      _repository.setUserAvatar(recordedImage.path);
    });
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    userAvatarStream.add(_image.path);
    _repository.setUserAvatar(_image.path);
  }

  getUserAvatar() async {
    var userAvatar = await _repository.getUserAvatar();
    if (userAvatar != null) userAvatarStream.add(userAvatar);
  }

  setUserName(String name) async{
    String token = await _repository.getToken();
    int id = await _repository.getId();
    _repository.updUser(name, pwd, id, token);
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

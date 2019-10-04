import 'dart:io';
import 'dart:ui';

import 'package:cdcalctest/core/resources/repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
class ProfileBloc{

  File _image;

final userAvatar = BehaviorSubject();
final _repository = Repository();

Observable get outUserAvatar => userAvatar.stream;

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
      userAvatar.add(_image);
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
      userAvatar.add(_image);
      _repository.setUserAvatar(_image.toString());
  }

  getUserAvatar() async {
    var userAvatar = await _repository.getUserAvatar();
    if(userAvatar != null)
    
    userAvatar.add(_image);
  }

  dispose(){
    userAvatar.close();
  }
}
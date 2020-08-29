import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditModel extends ChangeNotifier {
  final picker = ImagePicker();
  File imageFile;

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }
}

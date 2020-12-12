import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:tampre/view/calendar_route.dart';
import 'package:tampre/view/friend_add_route.dart';
import 'package:tampre/view/home_route.dart';
import 'package:tampre/view/profile_route.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileModel extends ChangeNotifier {

  Future showImagePicker() async {
    notifyListeners();
  }
}

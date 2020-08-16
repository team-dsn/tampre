import 'package:flutter/material.dart';

import 'package:tampre/view/component/user.dart';

import '../view/component/user.dart';

class FriendAddModel extends ChangeNotifier {


  List<User> people = [
    User(id: 'aris', userName: 'アリストテレス', birthday: '19970125', icon: 'images/aristoteres.png', wishList: 'https://ja.wikipedia.org/wiki/newton'),
    User(id: 'newton', icon: 'images/newton.jpeg', userName: 'ニュートン', birthday: '19921221', wishList: 'https://ja.wikipedia.org/wiki/newton'),
  ];

  User onSearchPressed(String query){
    User selectedUser;
    print("idは$query");
    people.forEach((user) {
      if(user.id == query){
        print("君は${user.userName}");
        selectedUser = user;
      }
    });
    notifyListeners();
    return selectedUser;
  }
}

import 'package:flutter/material.dart';

import 'package:tampre/view/component/user.dart';

class FriendAddModel extends ChangeNotifier {
  String userName = "";

  var people = [
    User(id: "aris", userName: "aristoteres"),
    User(id: "newton", userName: "newton"),
  ];

  void onSearchPressed(String query){
    print("idは$query");    
    people.forEach((user) {
      if(user.id == query){
        print("君は${user.userName}");
        userName = user.userName;
      }
    }); 
    notifyListeners();
  }
}

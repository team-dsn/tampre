import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tampre/view/component/global.dart' as global;
import 'package:tampre/view/component/user.dart';
import 'package:tampre/model/footer_model.dart';

class FriendAddModel extends ChangeNotifier {
  List<User> people = [
    User(userId: 'aris', userName: 'アリストテレス', birthday: '19970125', icon: 'images/aristoteres.png', wishList: 'https://ja.wikipedia.org/wiki/newton'),
    User(userId: 'newton', icon: 'images/newton.jpeg', userName: 'ニュートン', birthday: '19921221', wishList: 'https://ja.wikipedia.org/wiki/newton'),
  ];

  User onSearchPressed(BuildContext context, String query){
    // ダミー処理。本来は、友達申請の対応処理完了時にfriendRequestNumberを1減らす。
    // footerの別アイコンを押すことでfooterの再描画がかかる。
    global.friendRequestNumber--;
    if(global.friendRequestNumber < 0) {
      global.friendRequestNumber = 0;
    }
    context.read<FooterModel>().onItemTapped(FooterModel.indexFriendAdd);
    User selectedUser;
    print("userIdは$query");
    people.forEach((user) {
      if(user.userId == query){
        print("君は${user.userName}");
        selectedUser = user;
      }
    });
    notifyListeners();
    return selectedUser;
  }
}

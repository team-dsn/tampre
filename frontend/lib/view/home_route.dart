import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tampre/model/home_model.dart';
import 'package:tampre/view/component/global.dart' as global;
import 'package:tampre/view/component/user.dart';
import 'package:tampre/view/profile_route.dart';

import 'friend_profile.dart';

class Home extends StatelessWidget {
  List<User> users;
  String title = 'ホーム';
  
  // フッターからの遷移で呼ばれる
  Home(): this.users = global.users;
  // カレンダー画面上で複数人該当する日をタップ時の遷移で呼ばれる
  Home.users({List<User> users}){
    this.users = users;
    this.title = '${users[0].birthday.month}月${users[0].birthday.day}日生まれの友達';
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(users),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Consumer<HomeModel>(
          builder: (context, model, child) {
            model.sort();
            final userTiles = model.users.map((user) =>
                ListTile(
                  onTap: () async {
                    //todo:画面遷移
                    await Navigator.push (
                    context,
                    MaterialPageRoute(builder: (context) => FriendProfile(user:user),)
                      );
                    },
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(user.icon), // no matter how big it is, it won't overflow
                    ),
                    title: Text('${user.birthday.month}/${user.birthday.day}'),
                    subtitle: Text(user.userName)
            )).toList();
            return ListView(
                children:userTiles,
            );
          },
          ),
      ),
    );
  }
}

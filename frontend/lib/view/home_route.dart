import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tampre/model/home_model.dart';
import 'package:tampre/view/component/image_tile.dart';

import 'profile_route.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ホーム"),
        ),
        body: Consumer<HomeModel>(
          builder: (context, model, child) {
            final users = model.users;
            model.sort();
            final userTiles = users.map((user) =>
                ListTile(
                  onTap: () async {
                    //todo:画面遷移
                    await Navigator.push (
                    context,
                    MaterialPageRoute(builder: (context) => Profile(user:user),)
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

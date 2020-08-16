import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tampre/model/home_model.dart';

import 'package:tampre/view/component/image_tile.dart';

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
            final userTiles = users.map((user) => ImageTile(
              icon: user.icon, username: user.userName, birthday: user.birthday,
            ),).toList();
            return ListView(
                children:userTiles,
            );
          },
          ),
      ),
    );
  }
}

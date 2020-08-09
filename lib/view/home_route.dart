import 'package:flutter/material.dart';

import 'package:tampre/view/component/image_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ホーム"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ImageTile(icon: 'images/aristoteres.png', username: 'アリストテレス', birthday: '8/10'),
          ImageTile(icon: 'images/newton.jpeg', username: 'ニュートン', birthday: '12/25'),
        ]
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text('名前',
              style: TextStyle(
                fontSize: 40,
              )),
          Image.asset('images/aristoteres.png'),
          Container(
            color: Colors.blue[600],
            child: Column(children: <Widget>[
              Text('誕生日'),
              Text('欲しいものリスト'),
            ]),
          ),
        ]),
      ),
    );
  }
}

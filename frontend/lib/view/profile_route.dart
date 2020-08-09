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
          SpaceBox.height(10),
          Text('名前',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
              )),
          SpaceBox.height(10),
          Image.asset(
            'images/aristoteres.png',
            width: MediaQuery.of(context).size.width * 0.45,
            height:MediaQuery.of(context).size.width * 0.45,
          ),
          SpaceBox.height(30),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20),
            color: Colors.grey[300],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '誕生日:',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Text('欲しいものリスト:', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
                ]),
          ),
        ]),
      ),
    );
  }
}

class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}

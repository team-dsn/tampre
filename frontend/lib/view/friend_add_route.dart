import 'package:flutter/material.dart';

class FriendAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("友達追加"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SpaceBox.height(30),
          Container(
            width:MediaQuery.of(context).size.width * 0.8,
            child:TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '友達ID',
                ),
            ),
          ),
          SpaceBox.height(10),
          Text('名前',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
              ),
          ),
          SpaceBox.height(10),
          Image.asset(
            'images/aristoteres.png',
            width: MediaQuery.of(context).size.width * 0.45,
            height:MediaQuery.of(context).size.width * 0.45,
          ),
          SpaceBox.height(40),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width * 0.6,
            height: 50,
            child:RaisedButton(
              child: Text("友達申請",style: TextStyle(fontSize: 20)),
              color: Colors.white,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              onPressed: () {},
            ),
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

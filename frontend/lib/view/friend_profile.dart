import 'package:flutter/material.dart';
import 'package:tampre/view/home_route.dart';
import 'package:tampre/view/profile_edit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tampre/view/component/global.dart' as global;

import 'component/user.dart';

class FriendProfile extends StatelessWidget {
  FriendProfile({this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール"),
        actions: <Widget>[
          FlatButton(
            child: Text('削除',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed:() {
              //todo:ユーザーを削除する
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('本当に削除しますか'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          global.users.remove(user);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
    ),
      ],
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 8,),
          Text(user.userName,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
              )),
          SizedBox(height: 10,),
          Image.asset(
            user.icon,
            width: MediaQuery.of(context).size.width * 0.45,
            height:MediaQuery.of(context).size.width * 0.45,
          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20),
            color: Colors.grey[300],
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Text('誕生日:',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                        ),
                        Text('${user.birthday.month}/${user.birthday.day}',
                          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                        ),
                      ]
                  ),
                  Text('欲しいものリスト:',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      )
                  ),
                  InkWell(
                    child: Text(user.wishList,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        )
                    ),
                    onTap: ()async {
                      if (await canLaunch(user.wishList)) {
                        await launch(user.wishList);
                      };
                    },
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}

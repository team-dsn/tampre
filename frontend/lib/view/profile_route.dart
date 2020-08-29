import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'component/user.dart';

class Profile extends StatelessWidget {
  Profile({this.user});
  final User user;


  @override
  Widget build(BuildContext context) {
    final bool isFriend = user != null;
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール"),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 8,),
          Text( isFriend ? user.userName : 'MyName',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
              )),
          SizedBox(height: 10,),
          isFriend
          ? Image.asset(
            user.icon,
            width: MediaQuery.of(context).size.width * 0.45,
            height:MediaQuery.of(context).size.width * 0.45,
          )
           : Container(
             color: Colors.grey,
              child: Text('自分の写真'),
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
                      Text( isFriend ? '${user.birthday.month}/${user.birthday.day}' : '自分の誕生日',
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
                    child: Text( isFriend ? user.wishList : '自分のほしいものリスト',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                            )
                    ),
                    onTap: ()async {
                      if (await canLaunch(isFriend ? user.wishList : '自分のほしいものリスト')) {
                        await launch(isFriend ? user.wishList : '自分のほしいものリスト');
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

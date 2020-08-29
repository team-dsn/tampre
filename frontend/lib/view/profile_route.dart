import 'package:flutter/material.dart';
import 'package:tampre/view/profile_edit.dart';
import 'package:url_launcher/url_launcher.dart';

import 'component/user.dart';

class Profile extends StatelessWidget {
  final User myUser = User(id: '1', userName: '私', birthday: '19950303', icon: 'images/aristoteres.png', wishList: 'https://ja.wikipedia.org/wiki/newton');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("プロフィール"),
        actions: <Widget>[
          FlatButton(
            child: Text('編集',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed:(){
              //todo:画面遷移
              Navigator.push (
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEdit(myUser),)
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 8,),
          Text(myUser.userName,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
              )),
          SizedBox(height: 10,),
          Image.asset(
            myUser.icon,
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
                      Text('${myUser.birthday.month}/${myUser.birthday.day}',
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
                    child: Text(myUser.wishList,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                            )
                    ),
                    onTap: () async {
                      if (await canLaunch(myUser.wishList)) {
                        await launch(myUser.wishList);
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

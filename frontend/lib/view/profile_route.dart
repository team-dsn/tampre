import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tampre/model/profile_model.dart';
import 'package:tampre/view/profile_edit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tampre/view/component/global.dart' as global;


import 'component/user.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileModel>(
      create: (_) => ProfileModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("プロフィール"),
          actions: <Widget>[
            FlatButton(
              child: Text('編集',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed:()async {
                await Navigator.push (
                    context,
                    MaterialPageRoute(builder: (context) => ProfileEdit(myUser:global.myUser),)
                );
              },
            )
          ],
        ),
        body: Consumer<ProfileModel>(
          builder: (context, model, child) {
            return Center(
              child: Column(children: <Widget>[
                SizedBox(height: 8,),
                Text(global.myUser.userName,
                    style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1,
                    )),
                SizedBox(height: 10,),
                Image.asset(
                  global.myUser.profileImageUrl,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.45,
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.45,
                ),
                SizedBox(height: 30,),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  padding: EdgeInsets.all(20),
                  color: Colors.grey[300],
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            children: <Widget>[
                              Text('誕生日:',
                                style: TextStyle(fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.05),
                              ),
                              Text(
                                '${global.myUser.birthday.month}/${global.myUser
                                    .birthday.day}',
                                style: TextStyle(fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.05),
                              ),
                            ]
                        ),
                        Text('欲しいものリスト:',
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
                            )
                        ),
                        InkWell(
                          child: Text(global.myUser.wishListUrl,
                              style: TextStyle(
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.05,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              )
                          ),
                          onTap: () async {
                            if (await canLaunch(global.myUser.wishListUrl)) {
                              await launch(global.myUser.wishListUrl);
                            };
                          },
                        ),
                      ]),
                ),
                // 一時的に追加
                RaisedButton(
                  child: Text("初期登録画面", style: TextStyle(fontSize: 20)),
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileEdit(),)
                    );
                  },
                ),
                //一時的に追加ここまで
              ]),
            );
          },
        ),
      ),
    );
  }
}

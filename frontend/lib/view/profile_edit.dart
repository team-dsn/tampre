import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tampre/model/profile_edit_model.dart';
import 'package:tampre/view/wishlist_method.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tampre/view/component/global.dart' as global;

import 'component/user.dart';

class ProfileEdit extends StatelessWidget {
  final User myUser;
  final userIdEditingController = TextEditingController();
  final userNameEditingController = TextEditingController();
  final birthdayEditingController = TextEditingController();
  final wishListUrlEditingController = TextEditingController();
  bool isEditing;

  ProfileEdit({this.myUser}){
    this.isEditing = this.myUser != null;
  }

  Future<String> _setCurrentSetting() async {
    if (this.isEditing) {
      this.userIdEditingController.text = await User.getMyUserId();
      this.userNameEditingController.text = this.myUser.userName;
      this.birthdayEditingController.text =
        '${this.myUser.birthday.month}/${this.myUser.birthday.day}';
        wishListUrlEditingController.text = this.myUser.wishListUrl;
    }
    return 'Success';
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _setCurrentSetting(),
      builder: (context, AsyncSnapshot<String> snapshot) { return ChangeNotifierProvider<ProfileEditModel>(
      create: (_) => ProfileEditModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              isEditing
              ? "プロフィール"
          : "ユーザー情報登録"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                isEditing
                ? '完了'
                : '登録',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed:() {
                User.setMyUserId(userIdEditingController.text);
                global.myUser.userName = userNameEditingController.text;
                //global.myUser.birthday = birthdayEditingController as DateTime ;
                global.myUser.wishListUrl = wishListUrlEditingController.text;
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Consumer<ProfileEditModel>(
          builder: (context, model, child) {
            return Center(
              child: Column(children: <Widget>[
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: TextField(
                      controller: userIdEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                        hintText: "ユーザーID",
                        hintStyle: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,), 
                      ),
                      style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.08,
                      )
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  child: TextField(
                      controller: userNameEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(5),
                        hintText: "ユーザー名",
                        hintStyle: TextStyle(fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.05,), 
                      ),
                      style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.08,
                      )
                  ),
                ),
                SizedBox(height: 20,),

                InkWell(
                    onTap: () async {
                      //todo imagepickerを開く
                      await model.showImagePicker();
                    },
                    child: myUser != null
                        ? Image.asset(myUser.profileImageUrl,
                    height:MediaQuery.of(context).size.width * 0.5
                      ,)
                        : Container(
                      decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Icon(Icons.person,
                          color: Colors.white,
                          size:MediaQuery.of(context).size.width * 0.5
                      ),
                    ),
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
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.5,
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.10,
                                child: TextField(
                                  controller: birthdayEditingController,
                                  style: TextStyle(fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.05),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ]
                        ),
                        SizedBox(height: 8,),
                        Text('欲しいものリスト:',
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05,
                            )
                        ),
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.10,
                          child: TextField(
                            controller: wishListUrlEditingController,
                            style: TextStyle(fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.05,),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(5)
                            ),
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text("欲しいものリストの登録方法",style: TextStyle(fontSize: 20)),
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  onPressed: () {
                    Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => wishListMethod(),)
                    );
                  },
                ),
              ]),
            );
          },
        ),
      ),
    );
    }
    );
  }
}

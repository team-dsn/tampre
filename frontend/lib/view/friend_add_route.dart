import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tampre/model/friend_add_model.dart';

import 'component/user.dart';

class FriendAdd extends StatelessWidget {
  String id;
  User user;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FriendAddModel>(
      create: (_) => FriendAddModel(),
      child:Scaffold(
        appBar: AppBar(
          title: Text("友達追加"),
        ),
        body: Consumer<FriendAddModel>(builder: (context, model, child) {
            return Center(
              child: Column(children: <Widget>[
                SizedBox(
                height: 30,
                ),
                Row(children: <Widget>[
                  Spacer(),
                  Container(
                    width:MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    child:TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '友達ID',
                      ),
                  onChanged: (text){
                    id = text;
                    print(id);
                  }
                  ),
                ),
                  Spacer(),
                  ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.1,
                    height: 50,
                    child:RaisedButton(
                      child: Icon(Icons.search),
                      color: Colors.grey[300],
                      shape:OutlineInputBorder(),
                      onPressed: () {
                        this.user = model.onSearchPressed(id);
                      },
                  )
                ),
                  Spacer(),
              ],),
                SizedBox(
                height: 30,
                ),
                Text(user != null
                  ? user.userName
                  : '',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                  ),
              ),
                SizedBox(
                height: 10,
              ),
                user != null
                ? Image.asset(
                  user.icon,
                    width: MediaQuery.of(context).size.width * 0.5,
                    height:MediaQuery.of(context).size.width * 0.5,
                )
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

                SizedBox(
                height: 40,
              ),
                ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.6,
                height: 50,
                  child: user != null
                      ? RaisedButton(
                          child: Text("友達申請",style: TextStyle(fontSize: 20)),
                          color: Colors.white,
                          shape: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        onPressed: () {},
                      )
                      : Container(),
              ),
            ]),
          );
        }),
      )
    );
  }
}

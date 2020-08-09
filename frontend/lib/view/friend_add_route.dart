import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:provider/provider.dart';

import 'package:tampre/model/friend_add_model.dart';


class FriendAdd extends StatelessWidget {
  String id;
 



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
              SpaceBox.height(30),
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
                      model.onSearchPressed(id);
                    },
                  )
                ),
                Spacer(),
              ],),
              SpaceBox.height(30),
              Text(model.userName,
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
          );
        }),
      )
    );
  }

}


class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);

  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}



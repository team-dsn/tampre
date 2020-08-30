import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quartet/quartet.dart' show slice;
import 'package:tampre/view/component/friend_candidate.dart';

import 'package:tampre/view/component/friend_candidate.dart';
import 'package:tampre/view/component/global.dart' as global;
import 'package:tampre/view/component/user.dart';
import 'package:tampre/view/footer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await loadJsonAsset();
  await loadFriendRequestJsonAsset();
  runApp(App());
}

Future<void> loadJsonAsset() async {
  String loadData = await rootBundle.loadString('json/data.json');
  final jsonResponse = json.decode(loadData);
  jsonResponse.forEach((key,value) {
    for(dynamic v in value){
      String month = slice('0' + v['birthday']['month'], -2);
      String day = slice('0' + v['birthday']['day'], -2);
      String birthday = '${v['birthday']['year']}${month}${day}';
      global.users.add(
        User(
          id: v['id'],
          birthday: birthday,
          icon: v['image'],
          userName: v['name'],
          wishList: v['wishList']
        )
      );
    }
  });
}

Future<void> loadFriendRequestJsonAsset() async {
  String loadFriendRequestData = await rootBundle.loadString('json/friend_requested.json');
  final friendRequestedJsonResponse = json.decode(loadFriendRequestData);
  friendRequestedJsonResponse.forEach((fc) {
    global.friendCandidates.add(
        FriendCandidate(
          userId: fc['userId'],
          userName: fc['userName'],
          icon: fc['userImageUrl'],
        )
      );
  });
  global.friendRequestNumber = global.friendCandidates.length;
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tampre',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
      ),
      home: FooterWidget(),
    );
  }
}

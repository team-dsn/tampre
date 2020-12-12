import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quartet/quartet.dart' show slice;
import 'package:tampre/view/component/friend_candidate.dart';
import 'package:tampre/view/component/global.dart' as global;
import 'package:tampre/view/component/user.dart';
import 'package:tampre/view/footer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('.env');
  await loadJsonAsset();
  await loadFriendRequestJsonAsset();
  runApp(App());
}

Future<void> loadJsonAsset() async {
  http.Response res = await http.get(
      '${DotEnv().env["PRD_URL"]}/friends/${global.myUser.userId}',
      headers: {'Content-Type': 'application/json'});
  final jsonResponse = jsonDecode(utf8.decode(res.bodyBytes));
  for (var user in jsonResponse) {
    String month = slice('0' + user['birthday']['month'], -2);
    String day = slice('0' + user['birthday']['day'], -2);
    String birthday = '${user['birthday']['year']}${month}${day}';
    global.users.add(User(
        userId: user['userId'],
        birthday: birthday,
        profileImageUrl: user['profileImageUrl'],
        userName: user['userName'],
        wishListUrl: user['wishListUrl']));
  }
}

Future<void> loadFriendRequestJsonAsset() async {
  String loadFriendRequestData = await rootBundle.loadString('json/friend_requested.json');
  final friendRequestedJsonResponse = json.decode(loadFriendRequestData);
  friendRequestedJsonResponse.forEach((fc) {
    global.friendCandidates.add(
        FriendCandidate(
          userId: fc['userId'],
          userName: fc['userName'],
          profileImageUrl: fc['profileImageUrl'],
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

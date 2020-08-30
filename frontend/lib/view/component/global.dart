import 'package:tampre/view/component/user.dart';
import 'package:tampre/view/component/friend_candidate.dart';

// DBから取得したデータを格納する
// 現状、DBの代わりにjson/data.jsonを使用している
List<User> users = [];

// DBから取得したデータを格納する
// 現状、DBの代わりにjson/friend_requested.jsonを使用している
List<FriendCandidate> friendCandidates = [];

int friendRequestNumber = 0;

import 'package:tampre/view/component/global.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String _userId;
  String _userName;
  String _profileImageUrl;
  DateTime _birthday;
  int transformedDate;
  String _wishListUrl;
  static const String _myUserIdKey = 'myUserId';

  String get userId => _userId;
  String get userName => _userName;
  String get profileImageUrl => _profileImageUrl;
  DateTime get birthday => _birthday;
  String get wishListUrl => _wishListUrl;

  void set userId(String userId) {_userId = userId;}
  void set userName(String userName) {_userName = userName;}
  void set birthday(DateTime birthday) {_birthday = birthday;}
  void set wishListUrl(String wishListUrl) {_wishListUrl = wishListUrl;}


  User({String userId, String userName, String profileImageUrl, String birthday, String wishListUrl}){
    this._userId  = userId;
    this._userName = userName;
    this._birthday = DateTime.parse(birthday);
    this._profileImageUrl = profileImageUrl;
    this._wishListUrl = wishListUrl;
  }

  static void setMyUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_myUserIdKey, userId);
    global.myUser.userId = userId;
  }

  static Future<String> getMyUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_myUserIdKey);
  }
}

class User {
  String _userId;
  String _userName;
  String _profileImageUrl;
  DateTime _birthday;
  int transformedDate;
  String _wishListUrl;

  String get userId => _userId;
  String get userName => _userName;
  String get profileImageUrl => _profileImageUrl;
  DateTime get birthday => _birthday;
  String get wishListUrl => _wishListUrl;

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
}
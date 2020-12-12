class User {
  String _userId;
  String _userName;
  String _icon;
  DateTime _birthday;
  int transformedDate;
  String _wishList;

  String get userId => _userId;
  String get userName => _userName;
  String get icon => _icon;
  DateTime get birthday => _birthday;
  String get wishList => _wishList;

  void set userName(String userName) {_userName = userName;}
  void set birthday(DateTime birthday) {_birthday = birthday;}
  void set wishList(String wishList) {_wishList = wishList;}


  User({String userId, String userName, String icon, String birthday, String wishList}){
    this._userId  = userId;
    this._userName = userName;
    this._birthday = DateTime.parse(birthday);
    this._icon = icon;
    this._wishList = wishList;
  }
}
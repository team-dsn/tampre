class User {
  String _id;
  String _userName;
  String _icon;
  DateTime _birthday;
  int transformedDate;
  String _wishList;

  String get id => _id;
  String get userName => _userName;
  String get icon => _icon;
  DateTime get birthday => _birthday;
  String get wishList => _wishList;

  User({String id, String userName, String icon, String birthday, String wishList}){
    this._id  = id;
    this._userName = userName;
    this._birthday = DateTime.parse(birthday);
    this._icon = icon;
    this._wishList = wishList;
  }
}
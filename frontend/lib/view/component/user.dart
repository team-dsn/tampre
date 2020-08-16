class User {
  String _id;
  String _userName;
  String _icon;
  String _birthday;

  String get id => _id;
  String get userName => _userName;
  String get icon => _icon;
  String get birthday => _birthday;

  User({String id, String userName, String icon, String birthday}){
    this._id  = id;
    this._userName = userName;
    this._birthday = birthday;
    this._icon = icon;
  }
}
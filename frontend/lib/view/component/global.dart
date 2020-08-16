class TmpUser {
  DateTime _birthday;
  String _icon;
  String _name;
  String _wishList;

  DateTime get birthday => _birthday;
  String get icon => _icon;
  String get name => _name;
  String get wishList => _wishList;

  TmpUser({DateTime birthday, String icon, String name, String wishList}){
    this._birthday = birthday;
    this._icon = icon;
    this._name = name;
    this._wishList = wishList;
  }
}

List<TmpUser> users = [];

class TmpUser {
  DateTime _birthday;
  String _icon;
  String _name;

  DateTime get birthday => _birthday;
  String get icon => _icon;
  String get name => _name;

  TmpUser({DateTime birthday, String icon, String name}){
    this._birthday = birthday;
    this._icon = icon;
    this._name = name;
  }
}

List<TmpUser> users = [];

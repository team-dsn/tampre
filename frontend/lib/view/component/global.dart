class TmpUser {
  DateTime _birthday;
  String _icon;

  DateTime get birthday => _birthday;
  String get icon => _icon;

  TmpUser({DateTime birthday, String icon}){
    this._birthday = birthday;
    this._icon = icon;
  }
}

List<TmpUser> users = [];

class FriendCandidate {
  String _userId;
  String _userName;
  String _icon;

  String get userId => _userId;
  String get userName => _userName;
  String get icon => _icon;

  FriendCandidate({String userId, String userName, String icon}){
    this._userId = userId;
    this._userName = userName;
    this._icon = icon;
  }
}

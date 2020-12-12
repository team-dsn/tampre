class FriendCandidate {
  String _userId;
  String _userName;
  String _profileImageUrl;

  String get userId => _userId;
  String get userName => _userName;
  String get profileImageUrl => _profileImageUrl;

  FriendCandidate({String userId, String userName, String profileImageUrl}){
    this._userId = userId;
    this._userName = userName;
    this._profileImageUrl = profileImageUrl;
  }
}

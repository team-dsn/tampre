class User {
  String _id;
  String _userName;

  String get id => _id;
  String get userName => _userName;

  User({String id, String userName}){
    this._id  = id;
    this._userName = userName;
  }
}
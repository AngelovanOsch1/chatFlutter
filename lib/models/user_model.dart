class UserModel {
  final String _name;
  final String _email;
  final String _telephoneNumber;
  final String _profilePhoto;
  final bool _isOnline;
  final String _uid;

  UserModel(this._name, this._email, this._telephoneNumber, this._profilePhoto, this._isOnline, this._uid);

  String get name => _name;
  String get email => _email;
  String get telephoneNumber => _telephoneNumber;
  String get profilePhoto => _profilePhoto;
  bool get isOnline => _isOnline;
  String get uid => _uid;
}

class UserModel {
  Map<String, dynamic> _data = {
    'name': '',
    'email': '',
    'telephoneNumber': '',
    'profilePhoto': '',
    'isOnline': false,
    'uid': '',
  };

  UserModel(
    String name,
    String email,
    String telephoneNumber,
    String profilePhoto,
    bool isOnline,
    String uid,
  ) {
    _data['name'] = name;
    _data['email'] = email;
    _data['telephoneNumber'] = telephoneNumber;
    _data['profilePhoto'] = profilePhoto;
    _data['isOnline'] = isOnline;
    _data['uid'] = uid;
  }

  Map<String, dynamic> get data => _data;

  void setData(Map<String, dynamic> data) {
    _data = data;
  }

  Map<String, dynamic> testFunction() {
    return _data;
  }
}

import 'package:flutter/material.dart';

class UserModel {
  late final String name;
  late final String email;
  late final String profilePhoto;
  late final String banner;
  late final String telephoneNumber;
  late final String country;
  late final String bio;
  late final String uid;
  bool isOnline = false;

  UserModel(
      {required this.name,
      required this.email,
      required this.profilePhoto,
      required this.banner,
      required this.telephoneNumber,
      required this.country,
      required this.bio,
      required this.uid,
      required this.isOnline});
}

class UserModelProvider extends ChangeNotifier {
  dynamic _userData =
      UserModel(name: '', email: '', profilePhoto: '', banner: '', telephoneNumber: '', country: '', bio: '', uid: '', isOnline: false);
  UserModel get userData => _userData;

  void setUserData(Map<String, dynamic> data) {
    _userData = UserModel(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        profilePhoto: data['profilePhoto'] ?? '',
        banner: data['banner'] ?? '',
        telephoneNumber: data['telephoneNumber'] ?? '',
        country: data['country'] ?? '',
        bio: data['bio'] ?? '',
        uid: data['uid'] ?? '',
        isOnline: true);
    notifyListeners();
  }
}

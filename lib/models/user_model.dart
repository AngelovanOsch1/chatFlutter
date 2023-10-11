import 'package:flutter/material.dart';

class UserData {
  late final String name;
  late final String email;
  late final String profilePhoto;
  late final String telephoneNumber;
  bool isOnline = false;

  UserData({required this.name, required this.email, required this.profilePhoto, required this.telephoneNumber, required this.isOnline});
}

class UserDataProvider extends ChangeNotifier {
  var _userData = UserData(name: '', email: '', profilePhoto: '', telephoneNumber: '', isOnline: false);
  UserData get userData => _userData;

  void setUserData(Map<String, dynamic> data) {
    _userData = UserData(
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        profilePhoto: data['profilePhoto'] ?? '',
        telephoneNumber: data['telephoneNumber'] ?? '',
        isOnline: true);
    notifyListeners();
  }
}

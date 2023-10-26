import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  late final String id;
  late final String name;
  late final String email;
  late final String profilePhoto;
  late final String banner;
  late final String telephoneNumber;
  late final String country;
  late final String bio;
  bool isOnline = false;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.profilePhoto,
      required this.banner,
      required this.telephoneNumber,
      required this.country,
      required this.bio,
      required this.isOnline});


  static UserModel constructFromSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
        id: snapshot.id,
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        profilePhoto: data['profilePhoto'] ?? '',
        banner: data['banner'] ?? '',
        telephoneNumber: data['telephoneNumber'] ?? '',
        country: data['country'] ?? '',
        bio: data['bio'] ?? '',
        isOnline: data['isOnline'] ?? false);
  }
}

class UserModelProvider extends ChangeNotifier {
  dynamic _userData =
      UserModel(id: '', name: '', email: '', profilePhoto: '', banner: '', telephoneNumber: '', country: '', bio: '', isOnline: false);
  UserModel get userData => _userData;

  setUserData(Map<String, dynamic> data, String? id) {
    _userData = UserModel(
        id: id ?? '',
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        profilePhoto: data['profilePhoto'] ?? '',
        banner: data['banner'] ?? '',
        telephoneNumber: data['telephoneNumber'] ?? '',
        country: data['country'] ?? '',
        bio: data['bio'] ?? '',
        isOnline: true);

    notifyListeners();
  }
}

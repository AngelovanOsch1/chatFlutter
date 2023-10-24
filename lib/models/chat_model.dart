import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final List<UserModel> userModelList;

  ChatModel({required this.userModelList});

  // Constructor to create a ChatModel instance from snapshots of two users
  static ChatModel constructFromSnapshots(List<DocumentSnapshot> userDocs) {
    List<UserModel> userModelList = [];

    for (var userDoc in userDocs) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      final bool isOnline = data['isOnline'] == true;

      UserModel user = UserModel(
        id: userDoc.id,
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        profilePhoto: data['profilePhoto'] ?? '',
        banner: data['banner'] ?? '',
        telephoneNumber: data['telephoneNumber'] ?? '',
        country: data['country'] ?? '',
        bio: data['bio'] ?? '',
        isOnline: isOnline,
      );

      userModelList.add(user);
    }

    // Assuming you have two users in the list
    if (userModelList.length == 2) {
      return ChatModel(userModelList: userModelList);
    } else {
      // Handle the case where there are not exactly two users
      throw Exception("Expected exactly two users in the list.");
    }
  }
}

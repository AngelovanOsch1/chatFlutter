import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatModel {
  late final UserModel currentUser;
  late final UserModel? selectedUser;

  ChatModel({required this.currentUser, required this.selectedUser});

  static ChatModel constructFromSnapshots(List<DocumentSnapshot> userDocs) {
    late final UserModel currentUser;
    late final UserModel selectedUser;

    for (var userDoc in userDocs) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      final bool isOnline = data['isOnline'] == true;

      if (FirebaseAuth.instance.currentUser?.uid == userDoc.id) {
        currentUser = UserModel(
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
      } else {
        selectedUser = UserModel(
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
      }
    }

    return ChatModel(currentUser: currentUser, selectedUser: selectedUser);
  }
}

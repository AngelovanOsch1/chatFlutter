import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatModel {
  late final String date;
  late final String? lastMessage;
  late final UserModel currentUser;
  late final UserModel selectedUser;

  ChatModel({
    // required this.date,
    this.lastMessage,
    required this.currentUser,
    required this.selectedUser,
  });

  static ChatModel constructFromSnapshots(List<DocumentSnapshot> snapshots) {
    late final UserModel currentUser;
    late final UserModel selectedUser;
    late String date;

    for (DocumentSnapshot snapshot in snapshots) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (FirebaseAuth.instance.currentUser?.uid == snapshot.id) {
        currentUser = UserModel(
          id: snapshot.id,
          email: data['email'] ?? '',
          name: data['name'] ?? '',
          profilePhoto: data['profilePhoto'] ?? '',
          banner: data['banner'] ?? '',
          telephoneNumber: data['telephoneNumber'] ?? '',
          country: data['country'] ?? '',
          bio: data['bio'] ?? '',
          isOnline: data['isOnline'] ?? false,
        );
      } else {
        selectedUser = UserModel(
          id: snapshot.id,
          email: data['email'] ?? '',
          name: data['name'] ?? '',
          profilePhoto: data['profilePhoto'] ?? '',
          banner: data['banner'] ?? '',
          telephoneNumber: data['telephoneNumber'] ?? '',
          country: data['country'] ?? '',
          bio: data['bio'] ?? '',
          isOnline: data['isOnline'] ?? false,
        );
      }
    }
    return ChatModel(currentUser: currentUser, selectedUser: selectedUser);
  }
}

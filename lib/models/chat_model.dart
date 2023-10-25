import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatModel {
  late final UserModel currentUser;
  late final UserModel? selectedUser;

  ChatModel({required this.currentUser, required this.selectedUser});

  static ChatModel constructFromSnapshots(List<DocumentSnapshot> snapshots) {
    late UserModel currentUser;
    late UserModel selectedUser;
    
    for (DocumentSnapshot snapshot in snapshots) {
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (FirebaseAuth.instance.currentUser?.uid == snapshot.id) {
        final bool isOnline = data['isOnline'] == true;
        currentUser = UserModel(
          id: snapshot.id,
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
        final bool isOnline = data['isOnline'] == true;
        selectedUser = UserModel(
          id: snapshot.id,
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

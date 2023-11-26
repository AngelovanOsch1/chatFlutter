import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatModel {
  late final UserModel currentUser;
  UserModel? selectedUser;

  ChatModel({
    required this.currentUser,
    required this.selectedUser,
  });

  static ChatModel constructFromSnapshots(List<DocumentSnapshot> snapshots) {
    late final UserModel currentUser;
    UserModel? selectedUser;

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

      // ignore: prefer_conditional_assignment
      if (selectedUser == null) {
        selectedUser = UserModel(
          id: '',
          email: '',
          name: 'Deleted User',
          profilePhoto:
              'https://firebasestorage.googleapis.com/v0/b/chatappforschool.appspot.com/o/project_images%2Fdeleted_user.png?alt=media&token=07d1903e-f338-472b-a253-e40fd128b87a',
          banner: '',
          telephoneNumber: '',
          country: '',
          bio: '',
          isOnline: false,
        );
      }
    }
    return ChatModel(currentUser: currentUser, selectedUser: selectedUser);
  }
}

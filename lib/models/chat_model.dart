import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final List<String>? names;

  ChatModel({required this.names});

  static ChatModel constructFromSnapshots(List<DocumentSnapshot<Object?>> userDocs) {
    List<String> names = [];

    for (var userDoc in userDocs) {
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        names.add(userData['name'] ?? '');
      }
    }

    return ChatModel(names: names);
  }
}

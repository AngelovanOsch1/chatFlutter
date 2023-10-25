import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatModelController {
  final BuildContext context;

  ChatModelController(this.context);

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsStream(UserModel userModel) {
    return FirebaseFirestore.instance.collection('chats').where('participants.${userModel.id}', isEqualTo: true).snapshots();
  }

  Future<Map<String, dynamic>> getUserProfileFromStream(dynamic chatDocs) async {
    DocumentSnapshot? snapshot;
    ChatModel? chatModel;

    for (var chatDoc in chatDocs) {
      var chatData = chatDoc.data();
      var participants = chatData['participants'] as Map<String, dynamic>;

      List<String> participantIds = participants.keys.toList();
      for (String participantId in participantIds) {
        snapshot = await FirebaseFirestore.instance.collection('users').doc(participantId).get();
      }
      chatModel = ChatModel.constructFromSnapshots(snapshot!);

    }

    Map<String, dynamic> userData = {
      'currentUser': chatModel!.currentUser,
      'selectedUser': chatModel.selectedUser,
    };

    return userData;
  }
}


import 'package:chatapp/models/chat_document_model.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatModelController {
  late final BuildContext context;

  ChatModelController(this.context);

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsStream(UserModel userModel) {
    return FirebaseFirestore.instance.collection('chats').where('participants.${userModel.id}', isEqualTo: true).snapshots();
  }
  
  ChatDocumentModel getChatDocumentFromStream(QueryDocumentSnapshot<Map<String, dynamic>> chatData) {
    late final ChatDocumentModel chatDocumentModel;
    chatDocumentModel = ChatDocumentModel.constructFromSnapshot(chatData);
    return chatDocumentModel;
  }

  Future<ChatModel> getUserProfileFromStream(List<String> participantIds) async {
    late List<DocumentSnapshot> snapshots = [];
    late final ChatModel chatModel;

    for (String participantId in participantIds) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(participantId).get();
      snapshots.add(snapshot);
    }

    chatModel = ChatModel.constructFromSnapshots(snapshots);

    return chatModel;
  }

}



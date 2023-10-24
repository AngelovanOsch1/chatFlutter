import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatModelController {
  final BuildContext context;

  ChatModelController(this.context);

  Stream<List<ChatModel>> getChatsStream(UserModel userModel) async* {
    final snapshot = await context.read<Repository>().getChatsCollection.where('participants.${userModel.id}', isEqualTo: true).get();

    var chatModels = <ChatModel>[];

    for (var doc in snapshot.docs) {
      var participants = doc['participants'] as Map<String, dynamic>;
      List<String> participantIds = participants.keys.toList();

      var userDocs = await _getUserDocs(participantIds);

      var chatModel = ChatModel.constructFromSnapshots(userDocs);
      chatModels.add(chatModel);
    }

    yield chatModels;
  }

  Future<List<DocumentSnapshot>> _getUserDocs(List<String> userIDs) async {
    List<DocumentSnapshot> userDocs = [];

    for (String userID in userIDs) {
      DocumentSnapshot userDoc = await context.read<Repository>().getUserCollection.doc(userID).get();

      if (userDoc.exists) {
        userDocs.add(userDoc);
      }
    }

    return userDocs;
  }
}

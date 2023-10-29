import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDocumentModel {
  late final String id;
  late final DateTime date;
  late final String? lastMessage;
  late final Map<String, dynamic> participantIds;

  ChatDocumentModel({required this.id, required this.date, this.lastMessage, required this.participantIds});

  static ChatDocumentModel constructFromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> chatData) {
    final Map<String, dynamic> data = chatData.data();

    return ChatDocumentModel(
      id: chatData.id,
      date: data['date']?.toDate(),
      lastMessage: data['lastMessage'] ?? '',
      participantIds: data['participants'] ?? '',
    );
  }
}

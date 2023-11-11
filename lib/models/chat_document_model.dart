import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDocumentModel {
  late final String id;
  late final DateTime date;
  late final String? lastMessage;
  late final List<dynamic> participantIds;
  late final Map<String, dynamic>? unreadMessageCounterForUser;

  ChatDocumentModel({required this.id, required this.date, this.lastMessage, required this.participantIds, this.unreadMessageCounterForUser});

  static ChatDocumentModel constructFromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> chatData) {
    final Map<String, dynamic> data = chatData.data();

    return ChatDocumentModel(
      id: chatData.id,
      date: data['date']?.toDate(),
      lastMessage: data['lastMessage'] ?? '',
      participantIds: data['participants'] ?? '',
      unreadMessageCounterForUser: data['unreadMessageCounterForUser'],
    );
  }
}

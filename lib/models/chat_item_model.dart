class ChatItem {
  late final String documentId;
  ChatItem({required this.documentId});

  static ChatItem constructFromSnapshots() {
    return ChatItem(documentId: '123');
  }
}

import 'package:flutter/material.dart';

class ChatItemController {
  late final BuildContext context;

  ChatItemController(this.context);

  test(String chatItemDataId) {
    debugPrint(chatItemDataId);
  }
}

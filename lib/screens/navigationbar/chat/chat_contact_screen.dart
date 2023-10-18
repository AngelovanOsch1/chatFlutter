import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatContactScreen extends StatefulWidget {
  final UserModel userModel;

  const ChatContactScreen({super.key, required this.userModel});

  @override
  State<ChatContactScreen> createState() => _ChatContactScreenState();
}

class _ChatContactScreenState extends State<ChatContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.userModel.name),
      ),
    );
  }
}

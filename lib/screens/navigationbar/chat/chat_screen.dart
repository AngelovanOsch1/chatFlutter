import 'package:chatapp/colors.dart';
import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/navigationbar/chat/add_user.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_contact_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ChatScreen({Key? key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final UserModel userModel = Provider.of<UserModelProvider>(context, listen: false).userData;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AddUser();
            },
          );
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.add,
          color: colorScheme.primary,
          size: 40,
        ),
      ),
      body: StreamBuilder(
        stream: ChatModelController(context).getChatsStream(userModel),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final List<QueryDocumentSnapshot<Map<String, dynamic>>> chatDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              String documentId = chatDocs[index].id;
              Map<String, dynamic> chatData = chatDocs[index].data();
              Map<String, dynamic> participants = chatData['participants'] as Map<String, dynamic>;

              List<String> participantIds = participants.keys.toList();
              return FutureBuilder(
                future: ChatModelController(context).getUserProfileFromStream(participantIds),
                builder: (BuildContext context, AsyncSnapshot<ChatModel> userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (userSnapshot.hasError) {
                    return Text('Error: ${userSnapshot.error}');
                  }

                  final ChatModel chatModel = userSnapshot.data!;
                  return test(chatModel, documentId);
                },
              );
            },
          );
        },
      ),
    );
  }
  Widget test(ChatModel chatModel, String documentId) {
    return ListTile(
      leading:
          ProfilePhoto(chatModel.selectedUser!.profilePhoto, chatModel.selectedUser!.name, chatModel.selectedUser!.isOnline, 'contactProfilePhoto'),
      title: Text(
        chatModel.selectedUser!.name,
        style: textTheme.headlineSmall,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatContactScreen(
              selectedChatModel: chatModel,
              documentId: documentId,
            ),
          ),
        );
      },
    );
  }
}

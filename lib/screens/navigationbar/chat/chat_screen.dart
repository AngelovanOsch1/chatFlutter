import 'package:chatapp/colors.dart';
import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/models/chat_document_model.dart';
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
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 120,
        toolbarHeight: 150,
        leading: Padding(
          padding: const EdgeInsets.only(top: 40, left: 40),
          child: ProfilePhoto(userModel.profilePhoto, userModel.name, userModel.isOnline, 'chatScreen'),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Text(userModel.name, style: textTheme.headlineMedium),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: Divider(
              color: colorScheme.onBackground,
            ),
          ),
        ),
      ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 50, bottom: 5),
            child: Text(
              'Recent chats',
              style: textTheme.headlineMedium!.copyWith(color: colorScheme.primary, fontSize: 12),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: ChatModelController(context).getChatsStream(userModel),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  final List<QueryDocumentSnapshot<Map<String, dynamic>>> chatDocs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: chatDocs.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> chatData = chatDocs[index];
                      final ChatDocumentModel chatDocumentModel = ChatModelController(context).getChatDocumentFromStream(chatData);
                      List<dynamic> participants = chatDocumentModel.participantIds;

                      return FutureBuilder(
                        future: ChatModelController(context).getUserProfileFromStream(
                          participants,
                        ),
                        builder: (BuildContext context, AsyncSnapshot<ChatModel> userSnapshot) {
                          if (!userSnapshot.hasData) {
                            return Container();
                          }
                          final ChatModel chatModel = userSnapshot.data!;
                          return friendList(chatModel, chatDocumentModel);
                        },
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget friendList(ChatModel chatModel, ChatDocumentModel chatDocumentModel) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 35, right: 50),
          leading:
              ProfilePhoto(
              chatModel.selectedUser!.profilePhoto, chatModel.selectedUser!.name, chatModel.selectedUser!.isOnline, 'contactProfilePhoto'),
          title: Text(
            chatModel.selectedUser!.name,
            style: textTheme.headlineMedium!.copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            chatDocumentModel.lastMessage!,
            style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                child: Text(
                  'date',
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 10),
                ),
              ),
              unreadMessageCounter(chatModel, chatDocumentModel),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatContactScreen(
                  selectedChatModel: chatModel,
                  documentId: chatDocumentModel.id,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 50,
            left: 50,
          ),
          child: Divider(
            color: colorScheme.onBackground,
          ),
        ),
      ],
    );
  }

  unreadMessageCounter(ChatModel chatModel, ChatDocumentModel chatDocumentModel) {
    int? unreadMessageCounter = chatDocumentModel.unreadMessageCounterForUser![chatModel.currentUser.id]['unreadMessageCounter'];

    return unreadMessageCounter != null
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              unreadMessageCounter.toString(),
              style: textTheme.headlineMedium!.copyWith(fontSize: 12),
            ),
          )
        : const SizedBox();
  }
}

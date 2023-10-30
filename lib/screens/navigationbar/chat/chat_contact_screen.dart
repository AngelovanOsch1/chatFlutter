import 'package:chatapp/colors.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/screens/navigationbar/profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatContactScreen extends StatefulWidget {
  final ChatModel selectedChatModel;
  final String documentId;

  const ChatContactScreen({super.key, required this.selectedChatModel, required this.documentId});

  @override
  State<ChatContactScreen> createState() => _ChatContactScreenState();
}

class _ChatContactScreenState extends State<ChatContactScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();

          },
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(selectedUserModel: widget.selectedChatModel.selectedUser),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.selectedChatModel.selectedUser.name,
                    style: textTheme.headlineMedium!.copyWith(fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'Last online 1 minute ago',
                      style: textTheme.headlineSmall!.copyWith(fontSize: 12, color: colorScheme.onBackground),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: ProfilePhoto(widget.selectedChatModel.selectedUser.profilePhoto, widget.selectedChatModel.selectedUser.name,
                    widget.selectedChatModel.selectedUser.isOnline, 'contactProfilePhoto'),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.more_vert_rounded,
                size: 35,
              ),
              onPressed: () {},
            ),
          ),
        ],
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: context
                  .read<Repository>()
                  .getChatsCollection
                  .doc(widget.documentId)
                  .collection('messages')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;
                
                return ListView.builder(
                  itemCount: messages.length,
                  controller: _scrollController,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final String messageText = messages[index]['textMessage'];
                    final String sentBy = messages[index]['sentBy'];
                    return text(messageText, sentBy);
                  },
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.background,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, -2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextField(
                controller: _messageController,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onSubmitted: (message) {
                  if (message.isNotEmpty) {
                    sendMessage(message);
                  }
                },
                style: textTheme.headlineSmall,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: AppLocalizations.of(context).typeHere,
                  hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  suffixIcon: IconButton(
                    padding: const EdgeInsetsDirectional.only(end: 30),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    icon: Icon(
                      Icons.send,
                      color: colorScheme.primary,
                    ),
                    onPressed: () {
                      final String message = _messageController.text;
                      if (message.isNotEmpty) {
                        sendMessage(message);
                        _messageController.clear();
                      }
                    },
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
  Widget text(String message, String sentBy) {
    return sentBy == context.read<Repository>().getAuth.currentUser?.uid
        ? Padding(
            padding: const EdgeInsets.only(right: 25, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: myMessage,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    message,
                    style: textTheme.headlineSmall!.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: friendsMessage,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    message,
                    style: textTheme.headlineSmall!.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
  }

  void sendMessage(String messageText) async {
    final CollectionReference<Map<String, dynamic>> messagesCollection =
        context.read<Repository>().getChatsCollection.doc(widget.documentId).collection('messages');

    await messagesCollection
        .add({
          'textMessage': messageText, 'date': DateTime.now(), 'sentBy': widget.selectedChatModel.currentUser.id},
    );

    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    
    final CollectionReference chatCollection = context.read<Repository>().getChatsCollection;

    await chatCollection.doc(widget.documentId).update({
      'lastMessage': messageText,
      'date': DateTime.now(),
      },
    );
  }
}

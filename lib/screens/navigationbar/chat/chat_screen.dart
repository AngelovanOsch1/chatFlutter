import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/navigationbar/chat/add_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder<QuerySnapshot>(
          stream: getChatsForUser(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.data!.docs.isEmpty) {
              return Text('No chats found.');
            }

            List<QueryDocumentSnapshot> chatDocuments = snapshot.data!.docs;

            return ListView(
              children: chatDocuments.map((chatDocument) {
                return ListTile(
                  title: Text(chatDocument.id),
                );
              }).toList(),
            );
          },
        )
    );
  }

  Stream<QuerySnapshot> getChatsForUser() {
    final CollectionReference chatsCollection = context.read<Repository>().getChatsCollection;
    UserModel userModel = Provider.of<UserModelProvider>(context, listen: false).userData;

    return chatsCollection.where('userIds.${userModel.id}', isEqualTo: true).snapshots();
  }
}

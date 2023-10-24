import 'package:chatapp/colors.dart';
import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/navigationbar/chat/add_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Stream<List<ChatModel>> _chatCollection;

  @override
  void initState() {
    UserModel userModel = Provider.of<UserModelProvider>(context, listen: false).userData;
    _chatCollection = ChatModelController(context).getChatsStream(userModel);
    super.initState();
  }

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
      body: StreamBuilder(
        stream: _chatCollection,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('snapshot.error: ${snapshot.error.toString()}');
            return Container();
          }
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemExtent: 65,
            itemBuilder: (context, index) {
              ChatModel chatData = snapshot.data![index];
              List<UserModel> users = chatData.userModelList;

              // Access and display user data, for example, the name and email of the first user
              UserModel user1 = users[0];
              UserModel user2 = users[1];

              return ListTile(
                title: Text("User 1: ${user1.name}, ${user1.email}"),
                subtitle: Text("User 2: ${user2.name}, ${user2.email}"),
                // You can display other user data as needed
              );

            },
          );
        },
      ),
    );
  }
}

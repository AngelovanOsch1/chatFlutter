import 'package:chatapp/colors.dart';
import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
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
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModelProvider>(context, listen: false).userData;

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
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var chatDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              // var chatData = chatDocs[index].data();
              // var participants = chatData['participants'] as Map<String, dynamic>;

              // List<String> participantIds = participants.keys.toList();
              return FutureBuilder(
                future: ChatModelController(context).getUserProfileFromStream(chatDocs), // Fetch participant data
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Loading indicator
                  }

                  if (userSnapshot.hasError) {
                    return Text('Error: ${userSnapshot.error}');
                  }

                  List<String> participantNames = userSnapshot.data!['names'];
                  List<String> participantProfilePhotos = userSnapshot.data!['profilePhotos'];
                  List<bool> participantIsOnline = userSnapshot.data!['isOnline'];

                  return ListTile(
                    title: Text(
                      participantNames.join(', '),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < participantNames.length; i++)
                          ProfilePhoto(participantProfilePhotos[i], participantNames[i], participantIsOnline[i], 'contactProfilePhoto'),
                      ],
                    ),
                    onTap: () {},
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

}

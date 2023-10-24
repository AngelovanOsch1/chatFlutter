import 'package:chatapp/colors.dart';
import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/navigationbar/chat/add_user.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              debugPrint(chatData.names.toString());
              // var participants = chatData['participants'] as Map<String, dynamic>;

              // List<String> participantIds = participants.keys.toList();
              // return FutureBuilder(
              //   future: _getUserNamesAndProfilePhotos(participantIds), // Fetch participant data
              //   builder: (context, userSnapshot) {
              //     if (userSnapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator(); // Loading indicator
              //     }

              //     if (userSnapshot.hasError) {
              //       return Text('Error: ${userSnapshot.error}');
              //     }

              //     List<String> participantNames = userSnapshot.data!['names'];
              //     List<String> participantProfilePhotos = userSnapshot.data!['profilePhotos'];
              //     List<bool> participantIsOnline = userSnapshot.data!['isOnline'];

              //     return ListTile(
              //       title: Text(
              //         participantNames.join(', '),
              //       ),
              //       subtitle: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           for (int i = 0; i < participantNames.length; i++)
              //             ProfilePhoto(participantProfilePhotos[i], participantNames[i], participantIsOnline[i], 'contactProfilePhoto'),
              //         ],
              //       ),
              //       onTap: () {},
              //     );
              //   },
              // );
            },
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _getUserNamesAndProfilePhotos(List<String> userIDs) async {
    List<String> names = [];
    List<String> profilePhotos = [];
    List<bool> isOnline = [];

    for (String userID in userIDs) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        debugPrint(userData.toString());
        names.add(userData['name'] ?? '');
        profilePhotos.add(userData['profilePhoto'] ?? '');
        isOnline.add(userData['isOnline'] ?? false);
      }
    }

    return {
      'names': names,
      'profilePhotos': profilePhotos,
      'isOnline': isOnline,
    };
  }
}

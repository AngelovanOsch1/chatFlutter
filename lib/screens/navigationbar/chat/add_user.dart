import 'package:chatapp/colors.dart';
import 'package:chatapp/controllers/chat_controller.dart';
import 'package:chatapp/controllers/user_controller.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_contact_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colorScheme.background,
      contentPadding: const EdgeInsets.only(bottom: 50),
      title: Text(
        AppLocalizations.of(context).addFriendsAction,
        style: textTheme.headlineMedium!.copyWith(color: colorScheme.primary),
      ),
      content: SizedBox(
        height: 400,
        width: 350,
        child: Column(
          children: [
            searchBar(context),
            Flexible(
              child: usersList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 20, bottom: 10, left: 20),
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context).searchHere,
          hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
          suffixIcon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget usersList(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<UserModel>>(
        stream: UserModelController(context).getUsersStream(),
        builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
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
              final UserModel selectedUserModel = snapshot.data![index];
              if (searchController.text.isEmpty || selectedUserModel.name.toLowerCase().contains(searchController.text.toLowerCase())) {
                return userTile(selectedUserModel);
              } else {
                return const Center(
                  child: Text('test'),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget userTile(UserModel selectedUserModel) {
    return ListTile(
      title: Text(
          selectedUserModel.name,
        style: textTheme.headlineMedium!.copyWith(fontSize: 12),
      ),
      subtitle: Text(
          selectedUserModel.bio,
        style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            width: 35,
            height: 25,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ),
      onTap: () {
          createChat(selectedUserModel);
        },
        leading: ProfilePhoto(selectedUserModel.profilePhoto, selectedUserModel.name, selectedUserModel.isOnline, 'contactProfilePhoto'));
  }

  void createChat(UserModel selectedUserModel) async {
    final UserModel userModel = Provider.of<UserModelProvider>(context, listen: false).userData;
    final CollectionReference chatsCollection = context.read<Repository>().getChatsCollection;
    final DocumentReference chatDocumentRef = chatsCollection.doc();
    late final ChatModel chatModel;

    final querySnapshot = await chatsCollection
        .where('participants.${userModel.id}', isEqualTo: true)
        .where('participants.${selectedUserModel.id}', isEqualTo: true)
        .get();

    if (querySnapshot.docs.isEmpty) {
      await chatDocumentRef.set({
        'date': DateTime.now(),
        'participants': {
          userModel.id: true,
          selectedUserModel.id: true,
        },
      });
      final DocumentSnapshot chatDocument = await chatsCollection.doc(chatDocumentRef.id).get();
      final Map<String, dynamic> data = chatDocument.data() as Map<String, dynamic>;
      final Map<String, dynamic> participants = data['participants'];
      final List<String> participantIds = participants.keys.toList();
      chatModel = await ChatModelController(context).getUserProfileFromStream(participantIds);
    } else {
      for (DocumentSnapshot snapshot in querySnapshot.docs) {
        final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        final Map<String, dynamic> participants = data['participants'];
        final List<String> participantIds = participants.keys.toList();
        chatModel = await ChatModelController(context).getUserProfileFromStream(participantIds);
      }
    }
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatContactScreen(
          selectedChatModel: chatModel,
          documentId: chatDocumentRef.id,
        ),
      ),
    );
  }
}

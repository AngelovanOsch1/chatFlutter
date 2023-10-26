import 'package:chatapp/colors.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/screens/navigationbar/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class ChatContactScreen extends StatefulWidget {
  final ChatModel selectedChatModel;

  const ChatContactScreen({super.key, required this.selectedChatModel});

  @override
  State<ChatContactScreen> createState() => _ChatContactScreenState();
}

class _ChatContactScreenState extends State<ChatContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'chatScreen');
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
                    widget.selectedChatModel.selectedUser!.name,
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
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: ProfilePhoto(
                      widget.selectedChatModel.selectedUser!.profilePhoto, widget.selectedChatModel.selectedUser!.name,
                      widget.selectedChatModel.selectedUser!.isOnline, 'contactProfilePhoto'),
                ),
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: colorScheme.background,
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
              textInputAction: TextInputAction.send,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              autofocus: true,
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
                    Icons.mic,
                    color: colorScheme.primary,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:chatapp/colors.dart';
import 'package:chatapp/custom_widgets/profile_photo.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/user_controller.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_contact_screen.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Timer? _searchDebounce;
  final TextEditingController searchController = TextEditingController();
  late Stream<List<UserModel>> _userCollection;

  @override
  void initState() {
    _searchDebounce?.cancel();
    _userCollection = UserModelController(context).getUsersStream();
    super.initState();
  }

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
        stream: _userCollection,
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
              final UserModel userModel = snapshot.data![index];
              if (searchController.text.isEmpty || userModel.name.toLowerCase().contains(searchController.text.toLowerCase())) {
                return userTile(userModel);
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

  Widget userTile(UserModel userModel) {
    return ListTile(
      title: Text(
        userModel.name,
        style: textTheme.headlineMedium!.copyWith(fontSize: 12),
      ),
      subtitle: Text(
        userModel.bio,
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatContactScreen(selectedUserModel: userModel),
          ),
        );
      },
        leading: SizedBox(
          width: 60,
          child: ProfilePhoto(userModel.profilePhoto, userModel.name, userModel.isOnline, 'contactProfilePhoto'),
        )
    );     
  }
}

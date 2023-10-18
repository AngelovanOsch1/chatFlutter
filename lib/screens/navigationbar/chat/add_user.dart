import 'dart:async';

import 'package:chatapp/colors.dart';
import 'package:chatapp/models/user_Controller.dart';
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
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        'Add friends',
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
      padding: const EdgeInsets.only(top: 30, right: 20, bottom: 20, left: 20),
      child: TextField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: 'Search here',
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
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: userTile(userModel),
                );
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
      trailing: SizedBox(
        height: 30,
        width: 40,
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Add',
            style: textTheme.headlineMedium!.copyWith(fontSize: 12),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatContactScreen(userModel: userModel),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: userModel.profilePhoto.isEmpty
            ? Text(
                userModel.name[0],
                style: textTheme.headlineLarge!.copyWith(fontSize: 25),
              )
            : ClipOval(
                child: Image.network(
                  userModel.profilePhoto,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}

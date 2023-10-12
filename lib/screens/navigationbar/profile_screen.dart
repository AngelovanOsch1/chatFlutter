import 'package:chatapp/colors.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSceen extends StatefulWidget {
  const ProfileSceen({super.key});

  @override
  State<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends State<ProfileSceen> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataProvider>(context).userData;

    final ModalRoute<Object?>? parentRoute = ModalRoute.of(context);
    final bool hasLeadingIcon = parentRoute?.settings.name != '/profile';

    return Scaffold(
      appBar: AppBar(
        leading: hasLeadingIcon
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          'My profile',
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 35, right: 20, bottom: 35, left: 20),
            child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(right: 16, left: 16)),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Change',
                      style: textTheme.headlineSmall,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        Icons.create,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
      body: Center(
        child: Image(image: NetworkImage(userData.profilePhoto), alignment: Alignment.center, fit: BoxFit.cover),
      ),
    );
  }
}

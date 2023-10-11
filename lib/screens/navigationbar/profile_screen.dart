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
        return Scaffold(
          body: Center(
        child: Image(image: NetworkImage(userData.profilePhoto), alignment: Alignment.center, fit: BoxFit.cover),
      ),
    );
  }
}

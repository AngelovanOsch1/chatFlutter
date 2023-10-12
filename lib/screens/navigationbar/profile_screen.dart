import 'package:chatapp/colors.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileSceen extends StatefulWidget {

  @override
  State<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends State<ProfileSceen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        UserModel userModel = Provider.of<UserModel>(context, listen: false);
        Map<String, dynamic>? userData = userModel.userData;
        if (userData != null) {
          debugPrint(userModel.userData.toString());
        } else {
          debugPrint(userModel.userData.toString());
        }
        return Scaffold(
          body: Center(
            child: Text('Profile', style: textTheme.headlineMedium),
          ),
        );
      },
    );
  }
}

import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class ProfileSceen extends StatefulWidget {
  const ProfileSceen({super.key});

  @override
  State<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends State<ProfileSceen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Text('My Profile', style: textTheme.headlineMedium),
      ),
    );
  }
}

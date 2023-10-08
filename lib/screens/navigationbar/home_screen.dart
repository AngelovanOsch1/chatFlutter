import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/screens/navigationbar/chat_screen.dart';
import 'package:chatapp/screens/navigationbar/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int index = 0;
  final screens = [
    const ChatScreen(),
    const ProfileSceen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await FirebaseFunction.instance.signOut(context);
          },
          child: Text(
            'Logout',
            style: textTheme.headlineMedium,
          ),
        ),
      ),
    );
  }
}

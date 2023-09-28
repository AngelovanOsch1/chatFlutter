import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the chat',
              style: TextStyle(color: Colors.white),
            ),
            TextButton(
              onPressed: () => {},
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

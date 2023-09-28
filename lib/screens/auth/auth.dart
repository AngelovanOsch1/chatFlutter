import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('test'),
    );
  }
}

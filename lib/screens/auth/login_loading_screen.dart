import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginLoadingScreen extends StatelessWidget {
  UserModel? userModel;

  LoginLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
          final User? user = snapshot.data;
          return FutureBuilder<DocumentSnapshot>(
          future: context.read<Repository>().getFirestore.collection('users').doc(user?.uid).get(),
            builder: (context, userDocSnapshot) {
              if (userDocSnapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: colorScheme.onBackground,
                    color: colorScheme.primary,
                    value: 0.5,
                  ),
                ),
              );
            }
            if (userDocSnapshot.connectionState == ConnectionState.done) {
              if (userDocSnapshot.data?.data() == null) {
                return const Scaffold(
                  body: Center(
                    child: Text('whoops'),
                  ),
                );
              }
              final userData = userDocSnapshot.data?.data() as Map<String, dynamic>;
              debugPrint(userData.toString());
              userModel?.setData(userData);

              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
              );
              }
              return Container();
            },
        );
      },
    );
  }
}

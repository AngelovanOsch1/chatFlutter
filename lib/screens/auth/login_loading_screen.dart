import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
class LoginLoadingScreen extends StatelessWidget {
  const LoginLoadingScreen({super.key});

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
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Validators.instance.isLoading(context);
                },
              );
            }
            if (userDocSnapshot.connectionState == ConnectionState.done) {
              if (userDocSnapshot.data?.data() == null) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        const Text('whoops'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'landingScreen');
                          },
                          child: const Text('Back to the landing screen'),
                        ),
                      ],
                    ),
                  ),
                );
              }
              
              final userData = userDocSnapshot.data?.data() as Map<String, dynamic>;

              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Provider.of<UserModelProvider>(context, listen: false).setUserData(userData);

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

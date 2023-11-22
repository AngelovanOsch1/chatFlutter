import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
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
          future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> userDocSnapshot) {
              if (userDocSnapshot.connectionState == ConnectionState.waiting) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Validators.instance.isLoading(context, true);
                },
              );
            }
            if (userDocSnapshot.connectionState == ConnectionState.done) {
              if (userDocSnapshot.data?.data() == null) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context).whoopsMessage),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'landingScreen');
                          },
                          child: Text(AppLocalizations.of(context).backToLandingAction),
                        ),
                      ],
                    ),
                  ),
                );
              }
              
              WidgetsBinding.instance.addPostFrameCallback(
                (_) async {
                  final Map<String, dynamic> userData = userDocSnapshot.data?.data() as Map<String, dynamic>;
                  Provider.of<UserModelProvider>(context, listen: false).setUserData(userData, userDocSnapshot.data?.id);

                  await context.read<Repository>().getUserCollection.doc(userDocSnapshot.data?.id).update(
                    {
                    'isOnline': true,
                    },
                  );

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

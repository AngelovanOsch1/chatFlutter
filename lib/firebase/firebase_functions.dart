// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:chatapp/firebase/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FirebaseFunctions {
  FirebaseFunctions._();

  static final FirebaseFunctions instance = FirebaseFunctions._();

  StreamSubscription? authListener;

  Future init(BuildContext context) async {
    authListener = context
        .read<Repository>()
        .getAuth
        .authStateChanges()
        .listen((User? user) async {
      if (user == null) {
        Navigator.pushNamed(context, 'login');
        return;
      }
    });
  }

  Future<void> signIn(
      BuildContext context, String email, String password) async {
    try {
      await context
          .read<Repository>()
          .getAuth
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, '/homescreen');
    } catch (e) {
      debugPrint('error while signing in: ${e.toString()}');
    }
  }

  Future<void> createUser(
      BuildContext context, String email, String password) async {
    try {
      await context
          .read<Repository>()
          .getAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, '/homescreen');
    } catch (e) {
      debugPrint('error while creating account: ${e.toString()}');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await context.read<Repository>().getAuth.signOut();
      Navigator.pushReplacementNamed(context, '/homescreen');
    } catch (e) {
      debugPrint('error while signing out: ${e.toString()}');
    }
  }
}

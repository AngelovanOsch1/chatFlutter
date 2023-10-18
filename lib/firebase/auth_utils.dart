import 'dart:async';
import 'package:chatapp/firebase/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
export 'auth_utils.dart';

class FirebaseFunction {
  FirebaseFunction._();

  static final FirebaseFunction instance = FirebaseFunction._();
  
  Future<UserCredential?> signIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await context
          .read<Repository>()
          .getAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      final String error = e.code;
      switch (error) {
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email address'),
            ),
          );
          break;
        case 'user-disabled':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'This account is disabled. Please contact us if you think this was a mistake'),
            ),
          );
          break;
        case 'INVALID_LOGIN_CREDENTIALS':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid credentials'),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Oops, something went wrong. Please try again later'),
            ),
          );
      }
    }
    return null;
  }

  Future<UserCredential?> createUser(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await context
          .read<Repository>()
          .getAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      final String error = e.code;
      switch (error) {
        case 'email-already-in-use':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'There is already a registered user with this email address'),
            ),
          );
          break;
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email address is not valid email address'),
            ),
          );
          break;
        case 'weak-password':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password should at least be 6 characters long'),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Oops, something went wrong. Please try again later'),
            ),
          );
      }
    }
    return null;
  }

  void signOut(BuildContext context) async {
    try {
      await context.read<Repository>().getAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        'landingScreen',
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Oops, something went wrong. Please try again later'),
        ),
      );
    }
  }

  void resetPassword(BuildContext context, String email) async {
    try {
      await context.read<Repository>().getAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reset link sent to $email'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      final String error = e.code;
      switch (error) {
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email address'),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Oops, something went wrong. Please try again later'),
            ),
          );
      }
    }
  }

  void changeEmailAddress(BuildContext context, String newEmailAddress, String password) async {
    try {
      await context.read<Repository>().getAuth.currentUser?.updateEmail(newEmailAddress);
      await context.read<Repository>().getAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        'landingScreen',
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      final String error = e.code;
      switch (error) {
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid email address'),
            ),
          );
          break;
        case 'email-already-in-use':
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('There is already a registered user with this email address'),
            ),
          );
          break;
        case 'requires-recent-login':
          AuthCredential credential = EmailAuthProvider.credential(
            email: context.read<Repository>().getAuth.currentUser!.email!,
            password: password,
          );
          context.read<Repository>().getAuth.currentUser?.reauthenticateWithCredential(credential);
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Oops, something went wrong. Please try again later'),
            ),
          );
      }
    }
  }
}


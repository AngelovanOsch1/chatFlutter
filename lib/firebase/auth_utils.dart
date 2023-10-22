import 'dart:async';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            SnackBar(
              content: Text(
                AppLocalizations.of(context).invalidEmailMessage,
              ),
            ),
          );
          break;
        case 'user-disabled':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                 AppLocalizations.of(context).accountDisabledMessage),
            ),
          );
          break;
        case 'INVALID_LOGIN_CREDENTIALS':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).invalidCredentialsMessage),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(AppLocalizations.of(context).oopsMessage),
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
            SnackBar(
              content: Text(
                  AppLocalizations.of(context).emailExistsMessage),
            ),
          );
          break;
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).invalidEmailMessage),
            ),
          );
          break;
        case 'weak-password':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).passwordLengthMessage),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(AppLocalizations.of(context).oopsMessage),
            ),
          );
      }
    }
    return null;
  }

  void signOut(BuildContext context) async {
    try {
      final CollectionReference usersCollection = context.read<Repository>().getUserCollection;

      await usersCollection.doc(context.read<Repository>().getAuth.currentUser?.uid).update({
        'isOnline': false,
      });

      await context.read<Repository>().getAuth.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        'landingScreen',
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).oopsMessage),
        ),
      );
    }
  }

  void resetPassword(BuildContext context, String email) async {
    try {
      await context.read<Repository>().getAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context).resetLinkSentToAction} $email'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      final String error = e.code;
      switch (error) {
        case 'invalid-email':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).invalidEmailMessage),
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).oopsMessage),
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
            SnackBar(
              content: Text(AppLocalizations.of(context).invalidEmailMessage),
            ),
          );
          break;
        case 'email-already-in-use':
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).emailExistsMessage),
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
            SnackBar(
              content: Text(AppLocalizations.of(context).oopsMessage),
            ),
          );
      }
    }
  }
}


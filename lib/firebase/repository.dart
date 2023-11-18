import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Repository extends ChangeNotifier {
  Repository(this.auth, this.users);

  late FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  final FirebaseFunctions cloudFunction = FirebaseFunctions.instanceFor(region: 'europe-west1');

  FirebaseAuth get getAuth {
    return auth;
  }

  CollectionReference get getUserCollection {
    return users;
  }

  CollectionReference get getChatsCollection {
    return chats;
  }

  FirebaseFunctions get getCloudFunction {
    return cloudFunction;
  }
}

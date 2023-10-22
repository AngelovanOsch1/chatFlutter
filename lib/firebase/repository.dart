import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Repository extends ChangeNotifier {
  Repository(this.auth, this.firestore, this.users);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');

  FirebaseAuth get getAuth {
    return auth;
  }

  FirebaseFirestore get getFirestore {
    return firestore;
  }

  CollectionReference get getUserCollection {
    return users;
  }

  CollectionReference get getChatsCollection {
    return chats;
  }

}

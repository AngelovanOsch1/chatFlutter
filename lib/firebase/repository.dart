import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Repository extends ChangeNotifier {
  Repository(this.auth, this.firestore);

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth get getAuth {
    return auth;
  }

  FirebaseFirestore get getFirestore {
    return firestore;
  }
}

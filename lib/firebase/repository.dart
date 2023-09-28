import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  Repository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuth get getAuth {
    return _auth;
  }

  FirebaseFirestore get getFirestore {
    return _firestore;
  }
}

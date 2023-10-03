import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  Repository(this._auth, this._firestore);

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth get getAuth {
    return _auth;
  }

  FirebaseFirestore get getFirestore {
    return _firestore;
  }
}

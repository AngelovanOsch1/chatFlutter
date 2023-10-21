import 'package:chatapp/app.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final LocalStorage settings = LocalStorage('settings.json');
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  await settings.ready;

runApp(
  Phoenix(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModelProvider>(
          create: (context) => UserModelProvider(),
        ),
        ChangeNotifierProvider<Repository>(
          create: (context) => Repository(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
            FirebaseFirestore.instance.collection('users'),
          ),
        ),
      ],
      child: const MyApp(),
    ),

  )
  );
}


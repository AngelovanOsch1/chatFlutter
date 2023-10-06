import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/screens/auth/auth.dart';
import 'package:chatapp/screens/auth/login.dart';
import 'package:chatapp/screens/auth/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          Repository(FirebaseAuth.instance, FirebaseFirestore.instance),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      theme: themeData,
      home: const AuthScreen(),
      routes: {'login': (context) => const Login(), 'signup': (context) => const Signup()},
    );
  }
}

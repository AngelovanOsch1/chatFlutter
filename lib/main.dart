import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/auth/landing_screen.dart';
import 'package:chatapp/screens/auth/login_screen.dart';
import 'package:chatapp/screens/auth/reset_password.dart';
import 'package:chatapp/screens/auth/signup_screen.dart';
import 'package:chatapp/screens/navigationbar/chat_screen.dart';
import 'package:chatapp/screens/navigationbar/home_screen.dart';
import 'package:chatapp/screens/navigationbar/navigationbar.dart';
import 'package:chatapp/screens/navigationbar/profile_screen.dart';
import 'package:chatapp/screens/auth/login_loading_screen.dart';
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
runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(
          create: (context) => UserModel(),
        ),
        ChangeNotifierProvider<Repository>(
          create: (context) => Repository(FirebaseAuth.instance, FirebaseFirestore.instance),
        ),
      ],
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
      initialRoute: FirebaseAuth.instance.currentUser == null ? 'landingScreen' : '/',
      routes: {
        '/': (context) => const NavigationBarClass(),
        'homeScreen': (context) => const HomeScreen(),
        'landingScreen': (context) => const LandingScreen(),
        'loginScreen': (context) => const LoginScreen(),
        'signupScreen': (context) => const SignupScreen(),
        'chatScreen': (context) => const ChatScreen(),
        'profileScreen': (context) => ProfileSceen(),
        'loginLoadingScreen': (context) => LoginLoadingScreen(),
        'resetPassword': (context) => const ResetPassword(),
      },
    );
  }
}

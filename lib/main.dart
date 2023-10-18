import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/auth/landing_screen.dart';
import 'package:chatapp/screens/auth/login_screen.dart';
import 'package:chatapp/screens/auth/reset_password.dart';
import 'package:chatapp/screens/auth/signup_screen.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_contact_screen.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_screen.dart';
import 'package:chatapp/screens/navigationbar/home/home_screen.dart';
import 'package:chatapp/screens/navigationbar/navigationbar.dart';
import 'package:chatapp/screens/auth/change_email_screen.dart';
import 'package:chatapp/screens/navigationbar/profile/edit_profile_screen.dart';
import 'package:chatapp/screens/navigationbar/profile/profile_screen.dart';
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
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      theme: themeData,
      initialRoute: context.read<Repository>().getAuth.currentUser == null ? 'landingScreen' : 'loginLoadingScreen',
      routes: {
        '/': (context) => const NavigationBarClass(),
        'homeScreen': (context) => const HomeScreen(),
        'landingScreen': (context) => const LandingScreen(),
        'loginScreen': (context) => const LoginScreen(),
        'signupScreen': (context) => const SignupScreen(),
        'chatScreen': (context) => const ChatScreen(),
        'profileScreen': (context) => const ProfileSceen(),
        'editProfileScreen': (context) => const EditProfileScreen(),
        'loginLoadingScreen': (context) => const LoginLoadingScreen(),
        'resetPasswordScreen': (context) => const ResetPasswordScreen(),
        'changeEmailScreen': (context) => const ChangeEmailScreen(),
      },
    );
  }
}

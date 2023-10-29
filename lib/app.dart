import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/screens/auth/change_email_screen.dart';
import 'package:chatapp/screens/auth/landing_screen.dart';
import 'package:chatapp/screens/auth/login_loading_screen.dart';
import 'package:chatapp/screens/auth/login_screen.dart';
import 'package:chatapp/screens/auth/reset_password.dart';
import 'package:chatapp/screens/auth/signup_screen.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_screen.dart';
import 'package:chatapp/screens/navigationbar/home/home_screen.dart';
import 'package:chatapp/screens/navigationbar/navigationbar.dart';
import 'package:chatapp/screens/navigationbar/profile/edit_profile_screen.dart';
import 'package:chatapp/screens/navigationbar/profile/profile_screen.dart';
import 'package:chatapp/screens/navigationbar/settings/app_language.dart';
import 'package:chatapp/screens/navigationbar/settings/contact_us.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final LocalStorage settings = LocalStorage('settings.json');

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    final CollectionReference usersCollection = context.read<Repository>().getUserCollection;
    if (state == AppLifecycleState.resumed) {
      if (context.read<Repository>().getAuth.currentUser != null) {
        await usersCollection.doc(context.read<Repository>().getAuth.currentUser?.uid).update({
          'isOnline': true,
        });
      }
    } else if (state == AppLifecycleState.paused) {
      if (context.read<Repository>().getAuth.currentUser != null) {
        await usersCollection.doc(context.read<Repository>().getAuth.currentUser?.uid).update({
          'isOnline': false,
        });
      }
    }
  }

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
        'profileScreen': (context) => ProfileScreen(),
        'editProfileScreen': (context) => const EditProfileScreen(),
        'loginLoadingScreen': (context) => const LoginLoadingScreen(),
        'resetPasswordScreen': (context) => const ResetPasswordScreen(),
        'changeEmailScreen': (context) => const ChangeEmailScreen(),
        'appLanguageScreen': (context) => const AppLanguageScreen(),
        'contactUsScreen': (context) => const ContactUsScreen(),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('nl'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        String? setLocale = settings.getItem('appLocale');
        if (setLocale != null) {
          Intl.defaultLocale = setLocale;
          return Locale(setLocale);
        }
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              settings.setItem('locale', locale.languageCode);
              Intl.defaultLocale = supportedLocale.toLanguageTag();
              return supportedLocale;
            }
          }
        }
        settings.setItem('locale', supportedLocales.first.languageCode);
        Intl.defaultLocale = supportedLocales.first.toLanguageTag();
        return supportedLocales.first;
      },
    );
  }
}

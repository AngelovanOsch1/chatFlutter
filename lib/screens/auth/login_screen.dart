import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _passwordVisible = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 30, bottom: 50, left: 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      
                      children: <TextSpan>[
                        TextSpan(
                        text: AppLocalizations.of(context).welcomeBack,
                          style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
                        ),
                      TextSpan(text: AppLocalizations.of(context).exclamation, style: textTheme.headlineLarge),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      color: colorScheme.onBackground,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 10),
                    child: Text(
                    AppLocalizations.of(context).emailAddress,
                      style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    controller: _email,
                    cursorColor: colorScheme.onBackground,
                    style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).emailAddress,
                      hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 10),
                    child: Text(
                    AppLocalizations.of(context).password,
                      style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: _passwordVisible,
                    cursorColor: colorScheme.onBackground,
                    style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).password,
                      hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                      suffixIcon: IconButton(
                      color: colorScheme.onBackground,
                        icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(
                            () {
                              _passwordVisible = !_passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        ),
                        onPressed: () {},
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'resetPasswordScreen');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: colorScheme.primary),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context).forgotPasswordAction,
                          style: textTheme.headlineMedium!.copyWith(color: colorScheme.primary, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: TextButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.resolveWith(
                            (states) => const Size(320, 45),
                          ),
                        ),
                        onPressed: () {
                          _login(context);
                        },
                        child: Text(
                        AppLocalizations.of(context).loginAction,
                          style: textTheme.headlineLarge!.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                          text: AppLocalizations.of(context).noAccountMessage,
                            style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'signupScreen');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: colorScheme.onBackground),
                                    ),
                                  ),
                                  child: Text(
                                AppLocalizations.of(context).signUpAction,
                                    style: textTheme.headlineMedium!.copyWith(fontSize: 12),
                                  ),
                            ),
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String email = _email.text.trim();
    final String password = _password.text.trim();

    UserCredential? userCredential = await FirebaseFunction.instance.signIn(context, email, password);

    if (userCredential != null) {
      Navigator.pushNamed(context, 'loginLoadingScreen');
    } else {
      debugPrint('ERROR: signIn: ${userCredential.toString()}');
    }
  }
}

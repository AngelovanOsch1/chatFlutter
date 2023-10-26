import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _telephoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repeatPassword = TextEditingController();

  bool _passwordVisible = true;
  bool _repeatPasswordVisible = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _telephoneNumber.dispose();
    _password.dispose();
    _repeatPassword.dispose();
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
                        text: AppLocalizations.of(context).createAccountAction,
                        style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).account,
                        style: textTheme.headlineLarge,
                      ),
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
                  padding: const EdgeInsets.only(top: 60),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).firstName,
                              style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: _firstName,
                                cursorColor: colorScheme.onBackground,
                                style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context).emptyValueError;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context).firstName,
                                  hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 40),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).lastName,
                              style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: _lastName,
                                cursorColor: colorScheme.onBackground,
                                style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context).emptyValueError;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context).lastName,
                                  hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 10),
                  child: Text(
                    AppLocalizations.of(context).emailAddress,
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _email,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).emptyValueError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).emailAddress,
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                    AppLocalizations.of(context).phoneNumber,
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _telephoneNumber,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).emptyValueError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).phoneNumber,
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 10),
                  child: Text(
                    AppLocalizations.of(context).password,
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _password,
                  obscureText: _passwordVisible,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).emptyValueError;
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                    AppLocalizations.of(context).resetPasswordAction,
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _repeatPassword,
                  obscureText: _repeatPasswordVisible,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).emptyValueError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).resetPasswordAction,
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                    suffixIcon: IconButton(
                      color: colorScheme.onBackground,
                      icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            _repeatPasswordVisible = !_repeatPasswordVisible;
                          },
                        );
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: TextButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(320, 45),
                        ),
                      ),
                      onPressed: () {
                        _register(context);
                      },
                      child: Text(
                        AppLocalizations.of(context).signUpAction,
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
                          text: AppLocalizations.of(context).alreadyHaveAnAccount,
                          style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, 'loginScreen');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: colorScheme.onBackground),
                                ),
                              ),
                              child: Text(
                                AppLocalizations.of(context).signInAction,
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

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String firstName = _firstName.text.trim();
    final String lastName = _lastName.text.trim();
    final String email = _email.text.trim();
    final String telephoneNumber = _telephoneNumber.text.trim();
    final String password = _password.text.trim();
    final String repeatPassword = _repeatPassword.text.trim();

    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).passwordMismatchMessage),
        ),
      );
      return;
    }

    final UserCredential? userCredential = await FirebaseFunction.instance.createUser(context, email, password);

    if (userCredential != null) {

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set(
        {
        'name': '$firstName $lastName',
        'email': email,
        'telephoneNumber': telephoneNumber,
        },
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        'loginLoadingScreen',
        (route) => false,
      );
    } else {
      debugPrint('ERROR: createUser: ${userCredential.toString()}');
    }
  }
}

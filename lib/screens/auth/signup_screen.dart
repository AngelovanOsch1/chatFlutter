import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _telephoneNumber = TextEditingController();
  final _password = TextEditingController();
  final _repeatPassword = TextEditingController();

  bool _passwordVisible = true;
  bool _repeatPasswordVisible = true;

  final _formKey = GlobalKey<FormState>();

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
                        text: 'Create an ',
                        style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
                      ),
                      TextSpan(
                        text: 'account',
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
                              'First name',
                              style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: _firstName,
                                cursorColor: colorScheme.onBackground,
                                style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'First name',
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
                              'Last name',
                              style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: _lastName,
                                cursorColor: colorScheme.onBackground,
                                style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Last name',
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
                    'Email address',
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _email,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                    'Telephone number',
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _telephoneNumber,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Telephone number',
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 10),
                  child: Text(
                    'Password',
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _password,
                  obscureText: _passwordVisible,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                    'Repeat password',
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _repeatPassword,
                  obscureText: _repeatPasswordVisible,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Repeat password',
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
                        'Sign up',
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
                          text: 'Already have an account? ',
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
                                'Sign in!',
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
        const SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
      return;
    }

    UserCredential? userCredential = await FirebaseFunction.instance.createUser(context, email, password);

    if (userCredential != null) {
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      await users.doc(userCredential.user?.uid).set({
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

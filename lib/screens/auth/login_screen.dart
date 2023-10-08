import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _isInvalid = false;

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
            padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Welcome back ',
                          style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
                        ),
                        TextSpan(text: '!', style: textTheme.headlineLarge),
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
                      'Email address',
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
                      labelText: 'Email address',
                      labelStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60, bottom: 10),
                    child: Text(
                      'Password',
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
                      labelText: 'Password',
                      labelStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                      suffixIcon: IconButton(
                        color: _isInvalid ? colorScheme.error : colorScheme.onBackground,
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
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: colorScheme.primary),
                            ),
                          ),
                          child: Text(
                            'Forgot password!',
                            style: textTheme.headlineSmall!.copyWith(color: colorScheme.primary),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
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
                        'Login',
                        style: textTheme.headlineLarge!.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Do you not have an account yet? ',
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
                                    'Sign up!',
                                    style: textTheme.headlineMedium!.copyWith(fontSize: 12),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
        // body: SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 80, right: 30, left: 30),
        //     child: Form(
        //       key: _formKey,
        //       child: Column(
        //         children: [
        //           const Text(
        //             'Login',
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 35,
        //                 fontWeight: FontWeight.w700),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(top: 120),
        //             child: TextFormField(
        //               controller: _email,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please enter some text';
        //                 }
        //                 return null;
        //               },
        //               decoration: const InputDecoration(
        //                 hintText: 'Email',
        //                 labelText: 'Email',
        //                 filled: true,
        //                 fillColor: Colors.white,
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(top: 30),
        //             child: TextFormField(
        //               controller: _password,
        //               obscureText: _passwordVisible,
        //               validator: (value) {
        //                 if (value == null || value.isEmpty) {
        //                   return 'Please enter some text';
        //                 }
        //                 return null;
        //               },
        //               decoration: InputDecoration(
        //                 hintText: 'Password',
        //                 labelText: 'Password',
        //                 filled: true,
        //                 fillColor: Colors.white,
        //                 suffixIcon: IconButton(
        //                   icon: Icon(_passwordVisible
        //                       ? Icons.visibility
        //                       : Icons.visibility_off),
        //                   onPressed: () {
        //                     setState(
        //                       () {
        //                         _passwordVisible = !_passwordVisible;
        //                       },
        //                     );
        //                   },
        //                 ),

        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: const EdgeInsets.only(top: 30),
        //             child: TextButton(
        //               onPressed: () {
        //                 _login(context);
        //               },
        //               child: const Text('Login'),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  Future<void> _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _isInvalid = true;
      });
      return;
    }

    final String email = _email.text.trim();
    final String password = _password.text.trim();

    UserCredential? userCredential = await FirebaseFunction.instance.signIn(context, email, password);

    if (userCredential != null) {
      DocumentSnapshot userDoc = await context.read<Repository>().getFirestore.collection('users').doc(userCredential.user?.uid).get();
      Object? userData = userDoc.data();
      debugPrint(userData.toString());

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (route) => false,
      );
    } else {}
  }
}

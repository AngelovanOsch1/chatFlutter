import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
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
                hintText: 'Email address',
                hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _resetPassword(context);
            },
            child: Text(
              'Reset password',
              style: textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }

  void _resetPassword(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String email = _email.text.trim();

    FirebaseFunction.instance.resetPassword(context, email);
  }
}

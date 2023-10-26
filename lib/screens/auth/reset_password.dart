import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
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
                Text(
                  AppLocalizations.of(context).resetPasswordAction,
                  style: textTheme.headlineLarge,
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
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      _resetPassword(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Text(
                        AppLocalizations.of(context).sendAction,
                        style: textTheme.headlineMedium,
                      ),
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

  void _resetPassword(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String email = _email.text.trim();

    FirebaseFunction.instance.resetPassword(context, email);
  }
}

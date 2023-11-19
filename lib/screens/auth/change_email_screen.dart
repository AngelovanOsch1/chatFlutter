import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreen();
}

class _ChangeEmailScreen extends State<ChangeEmailScreen> {
  final _newEmailAddress = TextEditingController();
  final _password = TextEditingController();

  bool _passwordVisible = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newEmailAddress.dispose();
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
                Text(
                  AppLocalizations.of(context).changeEmailAction,
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
                    AppLocalizations.of(context).newEmailAddress,
                    style: textTheme.headlineLarge!.copyWith(fontSize: 16),
                  ),
                ),
                TextFormField(
                  controller: _newEmailAddress,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).emptyValueError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context).newEmailAddress,
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      _changeEmail(context);
                      // try {
                      //   HttpsCallable callable = context.read<Repository>().getCloudFunction.httpsCallable('updateEmail');
                      //   await callable('test321');
                      // } catch (e) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(AppLocalizations.of(context).oopsMessage),
                      //     ),
                      //   );
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Text(
                        AppLocalizations.of(context).changeAction,
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

  void _changeEmail(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String newEmailAddress = _newEmailAddress.text.trim();
    final String password = _password.text.trim();

    FirebaseFunction.instance.changeEmailAddress(context, newEmailAddress, password);
  }
}

import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/repository.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _email = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Contact us',
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, bottom: 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).loremIpsumText,
                  style: textTheme.headlineSmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    'Send us an email'.toUpperCase(),
                    style: textTheme.headlineMedium!.copyWith(
                      color: colorScheme.primary,
                      fontSize: 13,
                    ),
                  ),
                ),
                Divider(
                  color: colorScheme.onBackground,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Email',
                    style: textTheme.headlineMedium!.copyWith(
                      fontSize: 13,
                    ),
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
                    hintText: 'Email address',
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 5),
                  child: Text(
                    'Message',
                    style: textTheme.headlineMedium!.copyWith(fontSize: 14),
                  ),
                ),
                TextFormField(
                  controller: _message,
                  maxLines: 3,
                  cursorColor: colorScheme.onBackground,
                  style: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context).emptyValueError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Message',
                    hintStyle: textTheme.headlineSmall!.copyWith(color: colorScheme.onBackground, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith(
                          (states) => const EdgeInsets.only(left: 10, right: 10),
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      icon: const Directionality(
                        textDirection: TextDirection.ltr,
                        child: Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      label: Text(
                        'Send',
                        style: textTheme.headlineSmall,
                      ),
                      onPressed: () {
                        sendMessage(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Divider(
                    color: colorScheme.onBackground,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Wrap(
                    runSpacing: 30,
                    spacing: 30,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    children: [
                      Wrap(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.phone,
                            color: colorScheme.primary,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone number'.toUpperCase(),
                                style: textTheme.headlineMedium!.copyWith(fontSize: 10, color: colorScheme.onBackground),
                              ),
                              Text(
                                '+31 0636561082',
                                style: textTheme.headlineSmall,
                              ),
                            ],
                          )
                        ],
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.email,
                            color: colorScheme.primary,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email'.toUpperCase(),
                                style: textTheme.headlineMedium!.copyWith(fontSize: 10, color: colorScheme.onBackground),
                              ),
                              Text(
                                'Angelo.van.osch@hotmail.com',
                                style: textTheme.headlineSmall,
                              ),
                            ],
                          )
                        ],
                      ),
                      Wrap(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: colorScheme.primary,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Location',
                                style: textTheme.headlineMedium!.copyWith(fontSize: 10, color: colorScheme.onBackground),
                              ),
                              Text(
                                'The Netherlands, Essinklaan 2, 5361JT Grave',
                                style: textTheme.headlineSmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendMessage(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String email = _email.text.trim();
    String message = _message.text;

    Map<String, dynamic> body = {
      'email': email,
      'message': message,
    };

    HttpsCallable callable = context.read<Repository>().cloudFunction.httpsCallable('contactUsSendEmail');
    await callable.call(body);
  }
}

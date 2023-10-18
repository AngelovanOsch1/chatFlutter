import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModelProvider>(context).userData;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Text(
          'Settings',
          style: textTheme.headlineLarge!.copyWith(fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 30,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  FirebaseFunction.instance.signOut(context);
                },
                icon: const Icon(
                  Icons.logout,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            ListTile(
              minLeadingWidth: 50,
              leading: Icon(
                Icons.perm_contact_calendar,
                color: colorScheme.primary,
                size: 40,
              ),
              title: Text(
                'My profile'.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(
                  color: colorScheme.onBackground,
                  fontSize: 12,
                ),
              ),
              subtitle: Text(
                userModel.name,
                style: textTheme.headlineSmall,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'profileScreen');
              },
            ),
            ListTile(
              minLeadingWidth: 50,
              leading: Icon(
                Icons.language,
                color: colorScheme.primary,
                size: 40,
              ),
              title: Text(
                'App language'.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                "English (device's language)",
                style: textTheme.headlineSmall,
              ),
            ),
            ListTile(
              minLeadingWidth: 50,
              leading: Icon(
                Icons.quick_contacts_mail_rounded,
                color: colorScheme.primary,
                size: 40,
              ),
              title: Text(
                'Contact us'.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                "Let's talk and connect",
                style: textTheme.headlineSmall,
              ),
            ),
            ListTile(
              minLeadingWidth: 50,
              leading: Icon(
                Icons.warning_amber,
                color: colorScheme.primary,
                size: 40,
              ),
              title: Text(
                'Disclaimer'.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                'Legal notices and terms',
                style: textTheme.headlineSmall,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'About this App',
                        style: textTheme.headlineSmall!.copyWith(color: colorScheme.primary),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Version: 1.0.0',
                            style: textTheme.headlineSmall!.copyWith(color: colorScheme.primary),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel',
                            style: textTheme.headlineSmall!.copyWith(color: colorScheme.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              minLeadingWidth: 50,
              leading: Icon(
                Icons.info_outline,
                color: colorScheme.primary,
                size: 40,
              ),
              title: Text(
                'App info'.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                '1.0.0',
                style: textTheme.headlineSmall,
              ),
            ),
            Divider(
              color: colorScheme.onBackground,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 50,
              ),
              child: Wrap(
                spacing: 15,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith(
                        (states) => const EdgeInsets.only(left: 10, right: 10),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'resetPasswordScreen');
                    },
                    child: Text(
                      'Forgot password?',
                      style: textTheme.headlineLarge!.copyWith(color: colorScheme.background, fontSize: 12),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith(
                        (states) => const EdgeInsets.only(left: 10, right: 10),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'changeEmailScreen');
                    },
                    child: Text(
                      'Change email',
                      style: textTheme.headlineLarge!.copyWith(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith(
                        (states) => const EdgeInsets.only(left: 10, right: 10),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Delete account',
                      style: textTheme.headlineLarge!.copyWith(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

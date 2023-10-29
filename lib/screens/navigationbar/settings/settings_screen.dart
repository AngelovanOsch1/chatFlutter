import 'package:chatapp/colors.dart';
import 'package:chatapp/firebase/auth_utils.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/screens/navigationbar/settings/app_language.dart';
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
    final UserModel userModel = Provider.of<UserModelProvider>(context).userData;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        title: Text(
          AppLocalizations.of(context).appSettings,
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
                AppLocalizations.of(context).myProfile.toUpperCase(),
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
                AppLocalizations.of(context).applicationLanguage.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                  AppLocalizations.of(context).appLanguage,
                style: textTheme.headlineSmall,
              ),
              onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AppLanguageScreen();
                    },
                  );
                }
            ),
            ListTile(
              minLeadingWidth: 50,
              leading: Icon(
                Icons.quick_contacts_mail_rounded,
                color: colorScheme.primary,
                size: 40,
              ),
              title: Text(
                AppLocalizations.of(context).contactUsAction.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                AppLocalizations.of(context).connectAction,
                style: textTheme.headlineSmall,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'contactUsScreen');
              },
            ),
            ListTile(
              minLeadingWidth: 50,
              leading: Icon(
                Icons.warning_amber,
                color: colorScheme.primary,
                size: 40,
              ),
              title: Text(
                AppLocalizations.of(context).legalDisclaimer.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                AppLocalizations.of(context).legalNotices,
                style: textTheme.headlineSmall,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        AppLocalizations.of(context).appDescription,
                        style: textTheme.headlineSmall!.copyWith(color: colorScheme.primary),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).appVersion,
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
                            AppLocalizations.of(context).cancelAction,
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
                AppLocalizations.of(context).appInformation.toUpperCase(),
                style: textTheme.headlineLarge!.copyWith(color: colorScheme.onBackground, fontSize: 12),
              ),
              subtitle: Text(
                AppLocalizations.of(context).appVersion,
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
                      AppLocalizations.of(context).resetPasswordAction,
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
                      AppLocalizations.of(context).changeEmailAction,
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
                      AppLocalizations.of(context).deleteAccountAction,
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

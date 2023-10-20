import 'package:chatapp/colors.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, right: 30, bottom: 50, left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: AppLocalizations.of(context).welcomeMessage, style: textTheme.headlineLarge),
                    TextSpan(
                      text: AppLocalizations.of(context).chatAction,
                      style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
                    ),
                    TextSpan(text: '!', style: textTheme.headlineLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  AppLocalizations.of(context).loremIpsumText,
                  style: textTheme.headlineSmall!.copyWith(fontSize: 16),
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
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'loginScreen');
                    },
                    child: Text(
                      AppLocalizations.of(context).loginAction,
                      style: textTheme.headlineLarge!.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'signupScreen');
                    },
                    child: Text(
                      AppLocalizations.of(context).signUpAction,
                      style: textTheme.headlineLarge!.copyWith(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

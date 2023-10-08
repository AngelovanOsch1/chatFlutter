import 'package:chatapp/colors.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100, right: 50, left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: 'Welcome to ', style: textTheme.headlineLarge),
                    TextSpan(
                      text: 'chat ',
                      style: textTheme.headlineLarge!.copyWith(color: colorScheme.primary),
                    ),
                    TextSpan(text: '!', style: textTheme.headlineLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc consequat consectetur purus, ut aliquam lorem vestibulum ac.',
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
                child: TextButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.resolveWith(
                      (states) => const Size(320, 45),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'loginScreen');
                  },
                  child: Text(
                    'Login',
                    style: textTheme.headlineLarge!.copyWith(fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.resolveWith(
                      (states) => const Size(320, 45),
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
                    Navigator.pushNamed(context, 'signupScreen');
                  },
                  child: Text(
                    'Sign up',
                    style: textTheme.headlineLarge!.copyWith(fontSize: 20),
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

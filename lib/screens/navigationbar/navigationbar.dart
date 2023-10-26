import 'package:chatapp/colors.dart';
import 'package:chatapp/l10n/l10n.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_screen.dart';
import 'package:chatapp/screens/navigationbar/home/home_screen.dart';
import 'package:chatapp/screens/navigationbar/profile/profile_screen.dart';
import 'package:chatapp/screens/navigationbar/settings/settings_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavigationBarClass extends StatefulWidget {
  int? index;

  NavigationBarClass({super.key, this.index});

  @override
  State<NavigationBarClass> createState() => _NavigationBarClass();
}

class _NavigationBarClass extends State<NavigationBarClass> {

  int? index;
  @override
  void initState() {
    index = widget.index ?? 0;
    super.initState();
  }

  final screens = [
    const HomeScreen(),
    const ChatScreen(),
     ProfileScreen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    if (index == null) {} 

    return Scaffold(
      body: screens[index!],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: colorScheme.background,
          indicatorColor: colorScheme.primary,
          labelTextStyle: MaterialStateProperty.resolveWith(
            (states) => textTheme.headlineMedium!.copyWith(color: colorScheme.primary, fontSize: 12),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index!,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(seconds: 1),
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: colorScheme.onBackground),
                  ),
                ),
                child: NavigationDestination(
                  icon: const Icon(Icons.home),
                  selectedIcon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: AppLocalizations.of(context).homeAction,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: colorScheme.onBackground),
                  ),
                ),
                child: NavigationDestination(
                  icon: const Icon(Icons.chat),
                  selectedIcon: const Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  label: AppLocalizations.of(context).chatAction,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: colorScheme.onBackground),
                  ),
                ),
                child: NavigationDestination(
                  icon: const Icon(Icons.person),
                  selectedIcon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: AppLocalizations.of(context).myProfile,
                    
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: colorScheme.onBackground),
                  ),
                ),
                child: NavigationDestination(
                  icon: const Icon(Icons.settings),
                  selectedIcon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  label: AppLocalizations.of(context).appSettings,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

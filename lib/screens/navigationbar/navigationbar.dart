import 'package:chatapp/colors.dart';
import 'package:chatapp/screens/navigationbar/chat/chat_screen.dart';
import 'package:chatapp/screens/navigationbar/home/home_screen.dart';
import 'package:chatapp/screens/navigationbar/profile/profile_screen.dart';
import 'package:chatapp/screens/navigationbar/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class NavigationBarClass extends StatefulWidget {
  const NavigationBarClass({super.key});

  @override
  State<NavigationBarClass> createState() => _NavigationBarClass();
}

class _NavigationBarClass extends State<NavigationBarClass> {
  int index = 0;
  final screens = [
    const HomeScreen(),
    const ChatScreen(),
    ProfileSceen(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: colorScheme.background,
          indicatorColor: colorScheme.primary,
          labelTextStyle: MaterialStateProperty.resolveWith(
            (states) => textTheme.headlineMedium!.copyWith(color: colorScheme.primary, fontSize: 12),
          ),
        ),
        child: NavigationBar(
          selectedIndex: index,
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
                child: const NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: 'Home',
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
                child: const NavigationDestination(
                  icon: Icon(Icons.chat),
                  selectedIcon: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  label: 'Chat',
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
                child: const NavigationDestination(
                  icon: Icon(Icons.person),
                  selectedIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: 'Person',
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
                child: const NavigationDestination(
                  icon: Icon(Icons.settings),
                  selectedIcon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  label: 'Settings',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

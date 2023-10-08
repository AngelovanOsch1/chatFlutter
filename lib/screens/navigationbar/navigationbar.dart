import 'package:chatapp/colors.dart';
import 'package:chatapp/screens/navigationbar/chat_screen.dart';
import 'package:chatapp/screens/navigationbar/home_screen.dart';
import 'package:chatapp/screens/navigationbar/profile_screen.dart';
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
    const ProfileSceen(),
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
            (states) => textTheme.headlineMedium!.copyWith(fontSize: 12),
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
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: 'Person',
            ),
          ],
        ),
      ),
    );
  }
}

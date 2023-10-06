import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
    fontFamily: 'interFontFamily',
    scaffoldBackgroundColor: colorScheme.background,
    appBarTheme: AppBarTheme(color: colorScheme.background, elevation: 0),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: false,
    //   labelStyle: TextStyle(color: colorScheme.onBackground),
    //   hintStyle: TextStyle(color: colorScheme.onBackground),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(50),
    //     borderSide: const BorderSide(color: Colors.white),
    //   ),

    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(60.0),
    //     borderSide: BorderSide(color: Colors.red), // Focused border color
    //   ),
    // ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => colorScheme.primary),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(textTheme.headlineLarge!),
      ),
    ),
    dividerColor: colorScheme.onBackground);

const TextTheme textTheme = TextTheme(
  headlineLarge: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900), //black
  headlineMedium: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700), //bold
  headlineSmall: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400), //regular
);

const colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0XFF85CB33),
  onPrimary: Color(0XFFFFFFFF),
  secondary: Color(0XFF805600),
  onSecondary: Color(0XFFFFFFFF),
  error: Color(0XFFBA1A1A),
  onError: Color(0XFFFFFFFF),
  background: Color(0XFF2E294E),
  onBackground: Color(0XFF9A9A9A),
  surface: Color(0XFFFFFFFF),
  onSurface: Color(0XFFFFFFFF),
);

Color myMessage = const Color(0XFF716E87);
Color friendsMessage = const Color(0XFFDCFFB2);

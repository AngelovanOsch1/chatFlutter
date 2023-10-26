import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
    fontFamily: 'interFontFamily',
    scaffoldBackgroundColor: colorScheme.background,
    appBarTheme: AppBarTheme(color: colorScheme.background, elevation: 0),
  inputDecorationTheme: InputDecorationTheme(
    errorMaxLines: 2,
    labelStyle: TextStyle(color: colorScheme.onBackground),
    hintStyle: TextStyle(color: colorScheme.onBackground),
    border: const OutlineInputBorder(),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
  colorScheme: colorScheme,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: colorScheme.primary,
    insetPadding: const EdgeInsets.only(left: 30),
  ),
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
  dividerColor: colorScheme.onBackground,
);

const TextTheme textTheme = TextTheme(
  headlineLarge: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900), //black
  headlineMedium: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700), //bold
  headlineSmall: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400), //regular
);

const ColorScheme colorScheme = ColorScheme(
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
  onSurface: Color(0XFF5C5875),
);

const Color myMessage = Color(0XFF716E87);
const Color friendsMessage = Color(0XFFDCFFB2);
const Color bottomNavigationBar = Color(0XFF5C5875);

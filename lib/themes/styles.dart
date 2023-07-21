import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {

  //Custom text theme
  static final customTextTheme = TextTheme(
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
    ),
  );

  //Light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Kanit',
    textTheme: customTextTheme,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.light(primary: primary),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: icons,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Kanit',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: primary,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );

  // dark theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Kanit',
    textTheme: customTextTheme,
    primaryColor: primary,
    primaryColorDark: primaryDark,
    primaryColorLight: primaryLight,
    hoverColor: divider,
    hintColor: accent,
    colorScheme: const ColorScheme.dark(primary: icons),
    iconTheme: const IconThemeData(color: primaryText),
    scaffoldBackgroundColor: primaryText,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'Kanit',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      backgroundColor: primaryText,
      foregroundColor: icons,
      iconTheme: IconThemeData(color: icons),
    ),
  );
}
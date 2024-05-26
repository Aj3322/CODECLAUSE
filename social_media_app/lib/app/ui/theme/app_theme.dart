import 'package:flutter/material.dart';
import 'color_palette.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ColorPalette.primaryColor,
    primaryColorLight: ColorPalette.primaryVariant,
    primaryColorDark: ColorPalette.primaryVariant,
    hintColor: ColorPalette.secondaryColor,
    backgroundColor: ColorPalette.backgroundColor,
    scaffoldBackgroundColor: ColorPalette.backgroundColor,
    cardColor: ColorPalette.surfaceColor,
    errorColor: ColorPalette.errorColor,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: ColorPalette.onBackgroundColor),
      displayMedium: TextStyle(color: ColorPalette.onBackgroundColor),
      displaySmall: TextStyle(color: ColorPalette.onBackgroundColor),
      headlineMedium: TextStyle(color: ColorPalette.onBackgroundColor),
      headlineSmall: TextStyle(color: ColorPalette.onBackgroundColor),
      titleLarge: TextStyle(color: ColorPalette.onBackgroundColor),
      bodyLarge: TextStyle(color: ColorPalette.onBackgroundColor),
      bodyMedium: TextStyle(color: ColorPalette.onBackgroundColor),
      titleMedium: TextStyle(color: ColorPalette.onBackgroundColor),
      titleSmall: TextStyle(color: ColorPalette.onBackgroundColor),
      labelLarge: TextStyle(color: ColorPalette.onPrimaryColor),
      bodySmall: TextStyle(color: ColorPalette.onBackgroundColor),
      labelSmall: TextStyle(color: ColorPalette.onBackgroundColor),
    ),
    appBarTheme: const AppBarTheme(
      color: ColorPalette.primaryColor,
      iconTheme: IconThemeData(color: ColorPalette.onPrimaryColor),
      titleTextStyle:
          TextStyle(color: ColorPalette.onPrimaryColor, fontSize: 20),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorPalette.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.primaryVariant),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorPalette.primaryColor,
    hintColor: ColorPalette.secondaryColor,
    backgroundColor: ColorPalette.onBackgroundColor,
    scaffoldBackgroundColor: ColorPalette.onBackgroundColor,
    cardColor: ColorPalette.onSurfaceColor,
    errorColor: ColorPalette.errorColor,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: ColorPalette.backgroundColor),
      displayMedium: TextStyle(color: ColorPalette.backgroundColor),
      displaySmall: TextStyle(color: ColorPalette.backgroundColor),
      headlineMedium: TextStyle(color: ColorPalette.backgroundColor),
      headlineSmall: TextStyle(color: ColorPalette.backgroundColor),
      titleLarge: TextStyle(color: ColorPalette.backgroundColor),
      bodyLarge: TextStyle(color: ColorPalette.backgroundColor),
      bodyMedium: TextStyle(color: ColorPalette.backgroundColor),
      titleMedium: TextStyle(color: ColorPalette.backgroundColor),
      titleSmall: TextStyle(color: ColorPalette.backgroundColor),
      labelLarge: TextStyle(color: ColorPalette.onPrimaryColor),
      bodySmall: TextStyle(color: ColorPalette.backgroundColor),
      labelSmall: TextStyle(color: ColorPalette.backgroundColor),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(color: ColorPalette.onPrimaryColor),
      titleTextStyle:
          TextStyle(color: ColorPalette.onPrimaryColor, fontSize: 20),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorPalette.onBackgroundColor,
        unselectedIconTheme: IconThemeData(color: ColorPalette.backgroundColor),
        selectedIconTheme: IconThemeData(color: ColorPalette.primaryColor),
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(color: ColorPalette.primaryColor)),
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorPalette.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.primaryColor),
      ),
    ),

  );
}

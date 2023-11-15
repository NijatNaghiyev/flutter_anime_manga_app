import 'package:flutter/material.dart';

import 'colors.dart';

//!  Dark Theme
ThemeData myThemeDark = ThemeData(
  primaryColor: MyColors.primary,
  scaffoldBackgroundColor: MyColors.scaffoldBackground,
  colorScheme: const ColorScheme.dark(
    primary: MyColors.primary,
  ),
  textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.white)),
  brightness: Brightness.dark,
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  useMaterial3: true,

  /// ElevatedButtonThemeData
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Colors.blue),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

  /// ScrollBarThemeData
  scrollbarTheme: ScrollbarThemeData(
    interactive: true,
    crossAxisMargin: 2,
    thumbVisibility: const MaterialStatePropertyAll(false),
    thickness: MaterialStateProperty.all(5),
    thumbColor: MaterialStateProperty.all(MyColors.primary),
    trackColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
  ),
);

// ! Light Theme
ThemeData myThemeLight = ThemeData(
  primaryColor: MyColors.primary,
  scaffoldBackgroundColor: Colors.grey[300],
  textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.black)),
  highlightColor: Colors.transparent,
  splashColor: Colors.transparent,
  useMaterial3: true,
  brightness: Brightness.light,
);

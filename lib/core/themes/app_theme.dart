import 'package:flutter/material.dart';

enum AppThemeType { light, dark, blue, green, red }

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.deepOrange,
    ),
  );

  static final ThemeData blueTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFF0D47A1), // Deep Blue
    primaryColor: const Color(0xFF0D47A1),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0D47A1),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF0D47A1),
      brightness: Brightness.light,
    ),
  );

  static final ThemeData greenTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFF1B5E20), // Deep Green
    primaryColor: const Color(0xFF1B5E20),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1B5E20),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF1B5E20),
      brightness: Brightness.light,
    ),
  );

  static final ThemeData redTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFB71C1C), // Deep Red
    primaryColor: const Color(0xFFB71C1C),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFB71C1C),
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFB71C1C),
      brightness: Brightness.light,
    ),
  );
}

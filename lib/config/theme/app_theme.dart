import 'package:flutter/material.dart';

// app theme
class AppTheme {
  // light theme
  final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.green.shade500,
    ),
  );

  // dark theme
  final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.green.shade500,
    ),
  );
}

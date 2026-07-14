import 'package:flutter/material.dart';

class AppTheme {
  static const Color skyBlue = Color(0xFF80DEEA);
  static const Color grassGreen = Color(0xFF81C784);
  static const Color sunYellow = Color(0xFFFFEE58);
  static const Color softPink = Color(0xFFFFCDD2);
  static const Color softPurple = Color(0xFFE1BEE7);
  static const Color textDark = Color(0xFF37474F);

  static ThemeData get cartoonTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: skyBlue),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: textDark),
        bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textDark),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NerdLandTheme {
  static const Color background = Color(0xFF0B090F);
  static const Color surface = Color(0xFF15111B);
  static const Color surfaceLight = Color(0xFF21182B);
  static const Color primary = Color(0xFFA04DEB);
  static const Color primaryDark = Color(0xFF7B2FD3);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA9A1B8);
  static const Color border = Color(0xFF2A2233);
  static const Color danger = Color(0xFFE53935);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    fontFamily: 'Arial',
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: primary,
      surface: surface,
      error: danger,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      hintStyle: const TextStyle(color: textSecondary),
      labelStyle: const TextStyle(color: textPrimary),
      prefixIconColor: textSecondary,
      suffixIconColor: textSecondary,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: primary, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: danger),
      ),
    ),
  );
}
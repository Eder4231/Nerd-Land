import 'package:flutter/material.dart';

class NerdLandTheme {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.dark,
  );

  static bool get isDark => themeMode.value == ThemeMode.dark;

  static void toggleTheme() {
    themeMode.value = isDark ? ThemeMode.light : ThemeMode.dark;
  }

  static Color get background =>
      isDark ? const Color(0xFF0B090F) : const Color(0xFFF7F2FC);
  static Color get surface => isDark ? const Color(0xFF15111B) : Colors.white;
  static Color get surfaceLight =>
      isDark ? const Color(0xFF21182B) : const Color(0xFFEDE1F8);
  static Color get primary => const Color(0xFFA04DEB);
  static Color get primaryDark => const Color(0xFF7B2FD3);
  static Color get textPrimary =>
      isDark ? Colors.white : const Color(0xFF1B1026);
  static Color get textSecondary =>
      isDark ? const Color(0xFFA9A1B8) : const Color(0xFF675678);
  static Color get border =>
      isDark ? const Color(0xFF2A2233) : const Color(0xFFD9C7EA);
  static Color get danger => const Color(0xFFE53935);

  static ThemeData get darkTheme => _theme(Brightness.dark);
  static ThemeData get lightTheme => _theme(Brightness.light);

  static ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final backgroundColor = dark
        ? const Color(0xFF0B090F)
        : const Color(0xFFF7F2FC);
    final surfaceColor = dark ? const Color(0xFF15111B) : Colors.white;
    final textColor = dark ? Colors.white : const Color(0xFF1B1026);
    final secondaryTextColor = dark
        ? const Color(0xFFA9A1B8)
        : const Color(0xFF675678);
    final borderColor = dark
        ? const Color(0xFF2A2233)
        : const Color(0xFFD9C7EA);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Arial',
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: primary,
            brightness: brightness,
          ).copyWith(
            primary: primary,
            secondary: primary,
            surface: surfaceColor,
            background: backgroundColor,
            onSurface: textColor,
            onBackground: textColor,
            error: danger,
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: ThemeData(
        brightness: brightness,
      ).textTheme.apply(bodyColor: textColor, displayColor: textColor),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: TextStyle(color: secondaryTextColor),
        labelStyle: TextStyle(color: textColor),
        prefixIconColor: secondaryTextColor,
        suffixIconColor: secondaryTextColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primary, width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: danger),
        ),
      ),
    );
  }
}

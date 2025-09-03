import 'package:flutter/material.dart';

class AppTheme {
  // --- تعريف ثوابت الألوان الأساسية ---

  // اللوحة الحديثة والنظيفة (الوضع النهاري)
  static const Color lightBackground = Color(0xFFF2F4F8); // Light Smoke
  static const Color lightPrimaryText = Color(0xFF111111); // Deep Slate
  static const Color lightAccent = Color(0xFF1565C0); // Strong Blue
  static const Color lightSecondaryText = Color(0xFF616161); // Graphite

  // لوحة الوضع الليلي
  static const Color darkBackground = Color(0xFF0B1220); // Deep Navy
  static const Color darkPrimaryText = Color(0xFFE6E6E6); // Light Periwinkle
  static const Color darkAccent = Color(0xFFFFB74D); // Bright Amber
  static const Color darkSecondaryText = Color(0xFF8997AB); // Cool Slate

  // --- تعريف هوية الوضع النهاري (Light Theme) ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    primaryColor: lightAccent,
    colorScheme: const ColorScheme.light(
      primary: lightAccent,
      secondary: lightAccent,
      surface: Colors.white, // لون البطاقات والنواقل
      onPrimary: Colors.white, // لون النصوص فوق الألوان الأساسية
      onSecondary: Colors.white, // لون النصوص فوق الخلفية
      onSurface: lightPrimaryText, // لون النصوص فوق البطاقات
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: lightPrimaryText, // لون الأيقونات والنص في AppBar
      elevation: 1,
      iconTheme: const IconThemeData(color: lightPrimaryText),
      titleTextStyle: const TextStyle(
        color: lightPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: lightPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: lightPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: lightPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: lightPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: lightPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: lightPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: lightPrimaryText),
      bodyMedium: TextStyle(color: lightSecondaryText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );

  // --- تعريف هوية الوضع الليلي (Dark Theme) ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    primaryColor: darkAccent,
    colorScheme: const ColorScheme.dark(
      primary: darkAccent,
      secondary: darkAccent,
      surface: Color(0xFF1A2A47), // لون أغمق قليلاً للبطاقات
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: darkPrimaryText,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkPrimaryText,
      elevation: 1,
      iconTheme: const IconThemeData(color: darkPrimaryText),
      titleTextStyle: const TextStyle(
        color: darkPrimaryText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: darkPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: darkPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: darkPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: darkPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: darkPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: darkPrimaryText,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: darkPrimaryText),
      bodyMedium: TextStyle(color: darkSecondaryText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkAccent,
        foregroundColor: Colors.black, // نص داكن على خلفية العنبر الفاتحة
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

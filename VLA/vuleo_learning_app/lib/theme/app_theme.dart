import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color seedColor = Color(0xFF4B7BF5);

  static const Color parentColor = Color(0xFF4B7BF5);
  static const Color teacherColor = Color(0xFF9C5FF5);
  static const Color childColor = Color(0xFFFF9B42);

  static const Color quizColor = Color(0xFFFF6B6B);
  static const Color lessonsColor = Color(0xFF4ECDC4);
  static const Color statsColor = Color(0xFFEFB93C);

  // Colorblind-safe categorical order (validated: passes lightness, chroma,
  // CVD-separation and normal-vision-separation checks in fixed order).
  static const List<Color> topicColors = [
    Color(0xFF2A78D6), // blue
    Color(0xFFEB6834), // orange
    Color(0xFF1BAF7A), // aqua
    Color(0xFFEDA100), // yellow
    Color(0xFFE87BA4), // magenta
  ];

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(seedColor: seedColor);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 32),
        headlineMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        bodyLarge: TextStyle(fontSize: 16),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

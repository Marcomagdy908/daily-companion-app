// ─── core/theme/app_theme.dart ─────────────────────────────────────────
// Daily Companion (رفيق يومي) — Light & dark theme configuration
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ── Color Palette ───────────────────────────────────────────────────
  static const Color primaryColor = Color(0xFF2C3E50); // Deep navy
  static const Color secondaryColor = Color(0xFFE8D5B7); // Warm sand
  static const Color accentColor = Color(0xFFD4A574); // Gold/amber
  static const Color divineLight = Color(0xFFFFF8E7); // Soft parchment
  static const Color growthGreen = Color(0xFF4CAF50);
  static const Color altarRose = Color(0xFFE8A0BF);
  static const Color curriculumPurple = Color(0xFF7E57C2);
  static const Color backgroundColor = Color(0xFFF8F4F0);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFE57373);
  static const Color textPrimary = Color(0xFF2C1810);
  static const Color textSecondary = Color(0xFF8D6E63);

  // ── Gradient Presets ───────────────────────────────────────────────
  static const LinearGradient divineGradient = LinearGradient(
    colors: [Color(0xFFFFF8E7), Color(0xFFF5E6CC), Color(0xFFFFF8E7)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient altarGradient = LinearGradient(
    colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient growthGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Light Theme ─────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Cairo',

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      ),

      // Cards
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: surfaceColor,
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),

      // Text styles
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          color: textSecondary,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      ),
    );
  }

  // ── Dark Theme ─────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: accentColor,
        secondary: secondaryColor,
        surface: const Color(0xFF1E1E2E),
        error: errorColor,
      ),
      scaffoldBackgroundColor: const Color(0xFF12121A),
      fontFamily: 'Cairo',
      // ... additional dark theme customization
    );
  }
}

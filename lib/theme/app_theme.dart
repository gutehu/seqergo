import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primary = Color(0xFF0F766E);
  static const Color _surface = Color(0xFFF3F5F7);
  static const Color _onSurface = Color(0xFF0F172A);

  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      surface: _surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _surface,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: _surface,
        foregroundColor: _onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
          color: _onSurface,
        ),
        titleLarge: TextStyle(fontWeight: FontWeight.w600, color: _onSurface),
        bodyLarge: TextStyle(height: 1.35, color: Color(0xFF334155)),
        bodyMedium: TextStyle(height: 1.4, color: Color(0xFF64748B)),
      ),
    );
  }
}

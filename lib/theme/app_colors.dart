import 'package:flutter/material.dart';

class AppColors {
  // Couleurs de base - Premium Palette
  static const Color primary = Color(0xFF14B8A6); // Teal 500
  static const Color primaryVariant = Color(0xFF0D9488); // Teal 600
  static const Color secondary = Color(0xFFF59E0B); // Amber 500
  static const Color secondaryVariant = Color(0xFFD97706); // Amber 600

  // Couleurs fonctionnelles
  static const Color success = Color(0xFF10B981); // Emerald 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color error = Color(0xFFEF4444); // Red 500

  // Couleurs de fond ou de surface (Dark Mode)
  static const Color backgroundDark = Color(0xFF0F172A); // Slate 900
  static const Color cardDark = Color(0xFF1E293B); // Slate 800
  static const Color borderDark = Color(0xFF334155); // Slate 700

  // Couleurs de fond ou de surface (Light Mode)
  static const Color backgroundLight = Color(0xFFF8FAFC); // Slate 50
  static const Color cardLight = Colors.white;
  static const Color borderLight = Color(0xFFE2E8F0); // Slate 200

  static const Color separator = Color(0xFFCBD5E1); // Slate 300
  static const Color instagram = Color(0xFFE1306C);

  // Thèmes de couleurs sélectionnables
  static const Map<String, Color> seedColors = {
    'teal': Color(0xFF14B8A6),
    'indigo': Color(0xFF6366F1),
    'amber': Color(0xFFF59E0B),
    'rose': Color(0xFFF43F5E),
    'emerald': Color(0xFF10B981),
  };
}
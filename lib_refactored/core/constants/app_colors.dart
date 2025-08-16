import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFE65F2B);
  static const Color primaryLight = Color(0xFFF07A4A);
  static const Color primaryDark = Color(0xFFCC4A1A);
  
  // Background Colors
  static const Color background = Color(0xFFEBDFD7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFF8F9FA);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212529);
  static const Color textSecondary = Color(0xFF6C757D);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color pageNameColor = Color(0xFF525252);
  
  // Status Colors
  static const Color success = Color(0xFF28A745);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFDC3545);
  static const Color info = Color(0xFF17A2B8);
  
  // Project Card Colors
  static const Color projectCard1 = Color(0xFFF8E9C8);
  static const Color projectCard2 = Color(0xFFDEECEC);
  static const Color projectCard3 = Color(0xFFE1B4B4);
  static const Color projectCard4 = Color(0xFFDED3FD);
  
  // Border Colors
  static const Color border = Color(0xFFDEE2E6);
  static const Color borderLight = Color(0xFFE9ECEF);
  
  // Overlay Colors
  static Color transparentWhite = const Color(0xFFFFFFFF).withOpacity(0.34);
  static Color overlay = Colors.black.withOpacity(0.5);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFFE65F2B),
    Color(0xFFF07A4A),
  ];
  
  static const List<Color> successGradient = [
    Color(0xFF28A745),
    Color(0xFF20C997),
  ];
  
  static const List<Color> errorGradient = [
    Color(0xFFDC3545),
    Color(0xFFE74C3C),
  ];
  
  // Get random project card color
  static Color getRandomProjectCardColor() {
    final colors = [projectCard1, projectCard2, projectCard3, projectCard4];
    return colors[DateTime.now().millisecondsSinceEpoch % colors.length];
  }
}
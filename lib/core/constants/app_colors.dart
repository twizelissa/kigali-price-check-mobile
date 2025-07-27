import 'package:flutter/material.dart';

class AppColors {
  // Primary colors from your Figma design
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color secondary = Color(0xFFFF7043);
  static const Color accent = Color(0xFF4CAF50);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Background colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFFAFAFA);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Border and divider colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderFocused = primary;
  
  // Rwanda flag inspired colors
  static const Color rwandaBlue = Color(0xFF00A1DE);
  static const Color rwandaYellow = Color(0xFFFFD100);
  static const Color rwandaGreen = Color(0xFF00A651);
  
  // Price-related colors
  static const Color priceDown = Color(0xFF4CAF50);
  static const Color priceUp = Color(0xFFF44336);
  static const Color priceStable = Color(0xFF757575);
  
  // Vendor rating colors
  static const Color rating5Star = Color(0xFF4CAF50);
  static const Color rating4Star = Color(0xFF8BC34A);
  static const Color rating3Star = Color(0xFFFF9800);
  static const Color rating2Star = Color(0xFFFF5722);
  static const Color rating1Star = Color(0xFFF44336);
  
  // Shimmer colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  
  // Gradient colors
  static const List<Color> primaryGradient = [primary, primaryDark];
  static const List<Color> successGradient = [success, Color(0xFF388E3C)];
  static const List<Color> warningGradient = [warning, Color(0xFFF57C00)];
}
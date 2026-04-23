import 'package:flutter/material.dart';

class AppConstants {
  static const Color deepBlue = Color(0xFF1E3A8A);
  static const Color brightBlue = Color(0xFF3B82F6);
  static const Color lightBlue = Color(0xFF60A5FA);
  static const List<Color> primaryGradient = [deepBlue, brightBlue, lightBlue];
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}

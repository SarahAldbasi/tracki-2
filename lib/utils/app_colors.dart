import 'package:flutter/material.dart';

class AppColors {
  // Main theme colors
  static const Color textColor = Colors.black; // For main text
  static const Color backgroundColor = Colors.white; // For main background
  static const Color borderColor = Colors.grey; // For borders (light gray)

  // Custom colors from the gradient (based on your image)
  static const Color lightestPurple =
      Color(0xFFF6EFE9); // Top-most color in the image
  static const Color lightPurple = Color(0xFFE1CFE3); // Second from the top
  static const Color mediumPurple = Color(0xFFD0A9E3); // Third color
  static const Color darkPurple = Color(0xFF8D4D91); // Bottom-most color

  // Primary colors for buttons, accents, or highlights
  static const Color primaryLight =
      Color(0xFFB285C8); // Light primary color (based on the medium purple)
  static const Color primaryDark =
      Color(0xFF6A2B7D); // Dark primary color (a deeper purple)

  // Example: You can use these primary colors for buttons, highlights, etc.
}

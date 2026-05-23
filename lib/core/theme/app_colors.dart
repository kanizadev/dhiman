import 'package:flutter/material.dart';

/// ধীমান (Dhiman) — official color system only.
abstract final class AppColors {
  // ☕ Primary
  static const Color coffeeBrown = Color(0xFF6F4E37);
  static const Color latte = Color(0xFF8B6B4A);
  static const Color caramel = Color(0xFFA67B5B);

  /// @deprecated Use [latte]
  static const Color latteBrown = latte;

  // 🌿 Accents
  static const Color softGreen = Color(0xFFA8D5BA);
  static const Color skyBlue = Color(0xFFA9D6FF);
  static const Color peach = Color(0xFFFFD6BA);
  static const Color softYellow = Color(0xFFFFE599);

  // 🧁 Light mode
  static const Color cream = Color(0xFFF5F1EC);

  // 🌙 Dark mode
  static const Color darkBackground = Color(0xFF1E1B18);
  static const Color darkSurface = Color(0xFF2B2622);
  static const Color darkCard = Color(0xFF3A322D);
  static const Color darkText = Color(0xFFF8F4EF);

  // Semantic aliases (palette only)
  static const Color lightText = coffeeBrown;
  static const Color lightTextSecondary = latte;
  static const Color darkTextSecondary = caramel;
  static const Color lightCard = cream;
  static const Color lightSurface = cream;
  static const Color onPrimary = cream;
  static const Color borderLight = caramel;
  static const Color borderDark = latte;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [coffeeBrown, latte],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [softGreen, skyBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [peach, softYellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

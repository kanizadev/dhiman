import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const double radiusSmall = 16;
  static const double radiusMedium = 24;
  static const double radiusLarge = 32;

  static ThemeData light() {
    final textTheme = _textTheme(Brightness.light);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.cream,
      colorScheme: const ColorScheme.light(
        surfaceTint: Colors.transparent,
        primary: AppColors.coffeeBrown,
        onPrimary: AppColors.cream,
        secondary: AppColors.softGreen,
        onSecondary: AppColors.coffeeBrown,
        tertiary: AppColors.skyBlue,
        surface: AppColors.cream,
        onSurface: AppColors.coffeeBrown,
        error: AppColors.caramel,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.coffeeBrown,
        titleTextStyle: textTheme.titleLarge,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.cream,
        indicatorColor: AppColors.peach,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.coffeeBrown,
            );
          }
          return textTheme.labelMedium?.copyWith(color: AppColors.latte);
        }),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cream,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          side: const BorderSide(color: AppColors.caramel),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coffeeBrown,
          foregroundColor: AppColors.cream,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
            side: const BorderSide(color: AppColors.latte, width: 1.5),
          ),
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.coffeeBrown,
          side: const BorderSide(color: AppColors.caramel, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cream,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.caramel, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.caramel, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.coffeeBrown, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.coffeeBrown, width: 1.5),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.latte),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cream,
        selectedItemColor: AppColors.coffeeBrown,
        unselectedItemColor: AppColors.latte,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.caramel, thickness: 1),
    );
  }

  static ThemeData dark() {
    final textTheme = _textTheme(Brightness.dark);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        surfaceTint: Colors.transparent,
        primary: AppColors.caramel,
        onPrimary: AppColors.darkText,
        secondary: AppColors.softGreen,
        onSecondary: AppColors.darkText,
        tertiary: AppColors.skyBlue,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText,
        error: AppColors.peach,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.darkText,
        titleTextStyle: textTheme.titleLarge,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.darkSurface,
        indicatorColor: AppColors.darkCard,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          side: BorderSide(color: AppColors.latte),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.caramel,
          foregroundColor: AppColors.darkText,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.latte, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.latte, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.caramel, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.peach, width: 1.5),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.caramel,
        unselectedItemColor: AppColors.latte,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final base = brightness == Brightness.light
        ? GoogleFonts.notoSansBengaliTextTheme()
        : GoogleFonts.notoSansBengaliTextTheme(ThemeData.dark().textTheme);
    final color =
        brightness == Brightness.light ? AppColors.coffeeBrown : AppColors.darkText;
    final secondary =
        brightness == Brightness.light ? AppColors.latte : AppColors.caramel;

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: -0.5,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: color,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: color,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: color,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: color),
      bodyMedium: base.bodyMedium?.copyWith(color: secondary),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

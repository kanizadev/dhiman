import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_theme.dart';

/// Consistent bordered surfaces — border color matches fill / gradient.
abstract final class AppBorders {
  static const double width = 1.5;
  static const double widthThin = 1;
  static const double widthStrong = 2;

  /// Default neutral border when no surface color is known.
  static Color color(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.caramel
        : AppColors.latte;
  }

  /// Emphasis border (focus, selection ring) — still palette-only.
  static Color strongColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.coffeeBrown
        : AppColors.caramel;
  }

  /// Icon tint that pairs with a surface / accent fill (matches border logic).
  static Color iconOn(Color fill, BuildContext context) {
    if (fill == AppColors.coffeeBrown || fill == AppColors.latte) {
      return AppColors.cream;
    }
    return forSurface(fill, context);
  }

  /// Border that harmonizes with a solid fill color.
  static Color forSurface(Color fill, BuildContext context) {
    if (fill == AppColors.coffeeBrown) return AppColors.latte;
    if (fill == AppColors.latte) return AppColors.coffeeBrown;
    if (fill == AppColors.caramel) return AppColors.coffeeBrown;
    if (fill == AppColors.softGreen) return AppColors.coffeeBrown;
    if (fill == AppColors.skyBlue) return AppColors.coffeeBrown;
    if (fill == AppColors.peach) return AppColors.caramel;
    if (fill == AppColors.softYellow) return AppColors.caramel;
    if (fill == AppColors.cream) return AppColors.caramel;
    if (fill == AppColors.darkCard) return AppColors.latte;
    if (fill == AppColors.darkSurface) return AppColors.latte;
    if (fill == AppColors.darkBackground) return AppColors.caramel;

    final card = Theme.of(context).cardTheme.color;
    if (card != null && fill == card) {
      return Theme.of(context).brightness == Brightness.light
          ? AppColors.caramel
          : AppColors.latte;
    }

    return color(context);
  }

  /// Icon tint for gradient surfaces.
  static Color iconOnGradient(Gradient gradient, BuildContext context) {
    final colors = gradient.colors;
    if (colors.contains(AppColors.coffeeBrown)) return AppColors.cream;
    if (colors.contains(AppColors.softGreen) &&
        colors.contains(AppColors.skyBlue)) {
      return AppColors.coffeeBrown;
    }
    if (colors.contains(AppColors.peach) &&
        colors.contains(AppColors.softYellow)) {
      return AppColors.coffeeBrown;
    }
    return strongColor(context);
  }

  /// Border that harmonizes with a gradient fill.
  static Color forGradient(Gradient gradient, BuildContext context) {
    final colors = gradient.colors;
    if (colors.length >= 2) {
      if (colors.contains(AppColors.coffeeBrown) &&
          colors.contains(AppColors.latte)) {
        return AppColors.latte;
      }
      if (colors.contains(AppColors.softGreen) &&
          colors.contains(AppColors.skyBlue)) {
        return AppColors.coffeeBrown;
      }
      if (colors.contains(AppColors.peach) &&
          colors.contains(AppColors.softYellow)) {
        return AppColors.caramel;
      }
    }
    return strongColor(context);
  }

  static BorderSide side(
    BuildContext context, {
    double? borderWidth,
    Color? fill,
  }) {
    final borderColor = fill != null ? forSurface(fill, context) : color(context);
    return BorderSide(color: borderColor, width: borderWidth ?? width);
  }

  static BoxDecoration box({
    required BuildContext context,
    Color? backgroundColor,
    Gradient? gradient,
    double radius = AppTheme.radiusMedium,
    double borderWidth = width,
    Color? borderColorOverride,
  }) {
    final borderColor = borderColorOverride ??
        (gradient != null
            ? forGradient(gradient, context)
            : backgroundColor != null
                ? forSurface(backgroundColor, context)
                : color(context));

    return BoxDecoration(
      color: gradient == null ? backgroundColor : null,
      gradient: gradient,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth),
    );
  }

  static OutlineInputBorder inputBorder(
    BuildContext context, {
    double borderWidth = width,
    Color? fill,
    Color? borderColor,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      borderSide: BorderSide(
        color: borderColor ??
            (fill != null ? forSurface(fill, context) : color(context)),
        width: borderWidth,
      ),
    );
  }
}

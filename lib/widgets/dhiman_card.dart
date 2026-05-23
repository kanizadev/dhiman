import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/theme/app_borders.dart';
import '../core/theme/app_theme.dart';

class DhimanCard extends StatelessWidget {
  const DhimanCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(20),
    this.gradient,
    this.animate = true,
    this.delay = Duration.zero,
    this.borderWidth = AppBorders.width,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Gradient? gradient;
  final bool animate;
  final Duration delay;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    Widget card = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        child: Ink(
          decoration: AppBorders.box(
            context: context,
            backgroundColor: gradient == null
                ? Theme.of(context).cardTheme.color
                : null,
            gradient: gradient,
            borderWidth: borderWidth,
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );

    if (animate) {
      card = card
          .animate(delay: delay)
          .fadeIn(duration: 400.ms, curve: Curves.easeOut)
          .slideY(
            begin: 0.08,
            end: 0,
            duration: 400.ms,
            curve: Curves.easeOutCubic,
          );
    }
    return card;
  }
}

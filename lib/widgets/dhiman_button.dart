import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/theme/app_borders.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

enum DhimanButtonVariant { primary, secondary, outline, ghost }

class DhimanButton extends StatefulWidget {
  const DhimanButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = DhimanButtonVariant.primary,
    this.isLoading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final DhimanButtonVariant variant;
  final bool isLoading;
  final bool expand;

  @override
  State<DhimanButton> createState() => _DhimanButtonState();
}

class _DhimanButtonState extends State<DhimanButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.isLoading
        ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.cream,
            ),
          )
        : Row(
            mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(widget.label),
            ],
          );

    Widget button;
    switch (widget.variant) {
      case DhimanButtonVariant.primary:
        button = ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          child: child,
        );
      case DhimanButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.softGreen,
            foregroundColor: AppColors.lightText,
            side: const BorderSide(color: AppColors.coffeeBrown, width: 1.5),
          ),
          child: child,
        );
      case DhimanButtonVariant.outline:
        button = OutlinedButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          child: child,
        );
      case DhimanButtonVariant.ghost:
        button = TextButton(
          onPressed: widget.isLoading ? null : widget.onPressed,
          child: child,
        );
    }

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: widget.expand
            ? SizedBox(width: double.infinity, child: button)
            : button,
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class DhimanIconButton extends StatelessWidget {
  const DhimanIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: AppBorders.box(
          context: context,
          backgroundColor: Theme.of(context).cardTheme.color,
          radius: AppTheme.radiusSmall,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color: color ??
                  AppBorders.iconOn(
                    Theme.of(context).cardTheme.color ?? AppColors.cream,
                    context,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

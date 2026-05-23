import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Decorative blobs using palette colors only.
class BlobBackground extends StatelessWidget {
  const BlobBackground({super.key, required this.child, this.showBlobs = true});

  final Widget child;
  final bool showBlobs;

  @override
  Widget build(BuildContext context) {
    if (!showBlobs) return child;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: _Blob(
            size: 220,
            color: isDark ? AppColors.darkSurface : AppColors.softGreen,
          ),
        ),
        Positioned(
          bottom: 120,
          left: -70,
          child: _Blob(
            size: 180,
            color: isDark ? AppColors.darkCard : AppColors.skyBlue,
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.35,
          left: MediaQuery.sizeOf(context).width * 0.6,
          child: _Blob(
            size: 100,
            color: isDark ? AppColors.caramel : AppColors.peach,
          ),
        ),
        child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(size * 0.6),
          topRight: Radius.circular(size * 0.4),
          bottomLeft: Radius.circular(size * 0.5),
          bottomRight: Radius.circular(size * 0.7),
        ),
      ),
    );
  }
}

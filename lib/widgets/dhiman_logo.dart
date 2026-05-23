import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

/// App wordmark matching mockup — ধীমান with sparkle
class DhimanLogo extends StatelessWidget {
  const DhimanLogo({super.key, this.size = 36, this.showSubtitle = false});

  final double size;
  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w800,
                color: AppColors.coffeeBrown,
                height: 1.1,
              ),
            ),
            Positioned(
              top: -6,
              right: size * 0.15,
              child: Icon(
                Icons.wb_sunny_rounded,
                size: size * 0.35,
                color: AppColors.softYellow,
              ),
            ),
          ],
        ),
        if (showSubtitle) ...[
          const SizedBox(height: 4),
          Text(
            AppConstants.appNameEn,
            style: TextStyle(
              fontSize: size * 0.35,
              color: AppColors.lightTextSecondary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ],
    );
  }
}

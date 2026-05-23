import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

enum OnboardingIllustrationType { studyDesk, goals, community }

/// Flat friendly student illustrations (mockup style) via CustomPaint
class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({
    super.key,
    required this.type,
    this.height = 220,
  });

  final OnboardingIllustrationType type;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _IllustrationPainter(type),
      ),
    );
  }
}

class _IllustrationPainter extends CustomPainter {
  _IllustrationPainter(this.type);

  final OnboardingIllustrationType type;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = AppColors.peach;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.08, size.height * 0.1, size.width * 0.84, size.height * 0.75),
        const Radius.circular(32),
      ),
      bg,
    );

    final skin = Paint()..color = AppColors.peach;
    final hair = Paint()..color = AppColors.coffeeBrown;
    final shirt = Paint()..color = AppColors.softGreen;
    final desk = Paint()..color = AppColors.caramel;

    final cx = size.width * 0.5;
    final cy = size.height * 0.42;

    // Head
    canvas.drawCircle(Offset(cx, cy - 30), 28, skin);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy - 38), radius: 30),
      3.14,
      3.14,
      true,
      hair,
    );

    // Body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, cy + 20), width: 56, height: 50),
        const Radius.circular(16),
      ),
      shirt,
    );

    if (type == OnboardingIllustrationType.studyDesk) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width * 0.2, cy + 45, size.width * 0.6, 12),
          const Radius.circular(4),
        ),
        desk,
      );
      final book = Paint()..color = AppColors.skyBlue;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(cx - 20, cy + 30, 40, 18),
          const Radius.circular(4),
        ),
        book,
      );
      // Lamp
      canvas.drawCircle(
        Offset(size.width * 0.78, cy + 20),
        14,
        Paint()..color = AppColors.softYellow,
      );
    }

    if (type == OnboardingIllustrationType.goals) {
      final colors = [AppColors.peach, AppColors.skyBlue, AppColors.softGreen];
      for (var i = 0; i < 3; i++) {
        final ox = size.width * (0.22 + i * 0.28);
        final oy = size.height * 0.2;
        canvas.drawCircle(
          Offset(ox, oy),
          22,
          Paint()..color = colors[i],
        );
      }
    }

    if (type == OnboardingIllustrationType.community) {
      for (var i = -1; i <= 1; i++) {
        canvas.drawCircle(Offset(cx + i * 45, cy - 10), 20, skin);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

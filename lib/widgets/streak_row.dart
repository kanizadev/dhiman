import 'package:flutter/material.dart';

import '../core/theme/app_borders.dart';
import '../core/theme/app_colors.dart';

/// Horizontal study-streak row with day checkmarks (mockup home screen)
class StreakRow extends StatelessWidget {
  const StreakRow({
    super.key,
    required this.streakDays,
    this.completedDays = const [true, true, true, true, true, true, false],
  });

  final int streakDays;
  final List<bool> completedDays;

  static const _dayLabels = ['শ', 'সো', 'ম', 'বু', 'বৃ', 'শু', 'র'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: AppBorders.box(
        context: context,
        backgroundColor: Theme.of(context).cardTheme.color,
        radius: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: AppBorders.box(
                  context: context,
                  backgroundColor: AppColors.peach,
                  radius: 12,
                  borderWidth: AppBorders.widthThin,
                ),
                child: Icon(
                  Icons.local_fire_department,
                  color: AppBorders.iconOn(AppColors.peach, context),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$streakDays দিনের স্ট্রিক',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Text(
                'চালিয়ে যান! 🔥',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final done = i < completedDays.length && completedDays[i];
              return Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: done
                          ? AppColors.softGreen
                          : AppColors.cream,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppBorders.forSurface(
                          done ? AppColors.softGreen : AppColors.cream,
                          context,
                        ),
                        width: AppBorders.widthThin,
                      ),
                    ),
                    child: Icon(
                      done ? Icons.check_rounded : Icons.circle_outlined,
                      size: 20,
                      color: done
                          ? AppBorders.iconOn(AppColors.softGreen, context)
                          : AppBorders.iconOn(AppColors.cream, context),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _dayLabels[i],
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

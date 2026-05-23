import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_button.dart';
import '../../../widgets/dhiman_card.dart';

/// Exam results screen (mockup screen 8)
class ExamResultScreen extends StatelessWidget {
  const ExamResultScreen({
    super.key,
    this.scorePercent = 0.85,
    this.correct = 42,
    this.wrong = 8,
    this.total = 50,
  });

  final double scorePercent;
  final int correct;
  final int wrong;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlobBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'ফলাফল',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Center(
                child: CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 14,
                  percent: scorePercent,
                  center: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(scorePercent * 100).toInt()}%',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.coffeeBrown,
                            ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: AppBorders.box(
                          context: context,
                          backgroundColor: AppColors.softYellow,
                          radius: 12,
                          borderWidth: AppBorders.widthThin,
                        ),
                        child: const Text(
                          'চমৎকার! 🎉',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  progressColor: AppColors.softGreen,
                  backgroundColor: AppColors.cream,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  _StatBox('সঠিক', '$correct', AppColors.softGreen),
                  const SizedBox(width: 12),
                  _StatBox('ভুল', '$wrong', AppColors.peach),
                  const SizedBox(width: 12),
                  _StatBox('মোট', '$total', AppColors.skyBlue),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'বিষয়ভিত্তিক পারফরম্যান্স',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              DhimanCard(
                animate: false,
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 160,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 100,
                      barTouchData: const BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, _) {
                              const labels = ['Phy', 'Chem', 'Math', 'Bio'];
                              return Text(
                                labels[v.toInt()],
                                style: const TextStyle(fontSize: 11),
                              );
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(),
                        topTitles: const AxisTitles(),
                        rightTitles: const AxisTitles(),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        _bar(0, 88, AppColors.skyBlue),
                        _bar(1, 72, AppColors.softGreen),
                        _bar(2, 65, AppColors.peach),
                        _bar(3, 90, AppColors.caramel),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              DhimanButton(
                label: 'হোমে ফিরুন',
                onPressed: () => context.go('/home'),
              ),
              const SizedBox(height: 12),
              DhimanButton(
                label: 'উত্তরপত্র দেখুন',
                variant: DhimanButtonVariant.outline,
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _bar(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 22,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox(this.label, this.value, this.color);

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: AppBorders.box(
          context: context,
          backgroundColor: color,
          radius: 20,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

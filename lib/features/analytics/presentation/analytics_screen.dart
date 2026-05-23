import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weekly = MockData.weeklyStudyMinutes;

    return Scaffold(
      appBar: AppBar(title: const Text('অ্যাকাডেমিক অ্যানালিটিক্স')),
      body: BlobBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(
                  child: DhimanCard(
                    child: Column(
                      children: [
                        CircularPercentIndicator(
                          radius: 50,
                          lineWidth: 10,
                          percent: 0.72,
                          center: const Text(
                            '72%',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          progressColor: AppColors.softGreen,
                        ),
                        const SizedBox(height: 8),
                        const Text('সাপ্তাহিক লক্ষ্য'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DhimanCard(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: AppBorders.box(
                            context: context,
                            backgroundColor: AppColors.peach,
                            radius: 14,
                            borderWidth: AppBorders.widthThin,
                          ),
                          child: Icon(
                            Icons.local_fire_department,
                            size: 28,
                            color: AppBorders.iconOn(AppColors.peach, context),
                          ),
                        ),
                        Text(
                          '${MockData.demoProfile.streakDays}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const Text('দিন স্ট্রিক'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'সাপ্তাহিক পড়ার সময় (মিনিট)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            DhimanCard(
              padding: const EdgeInsets.all(20),
              animate: false,
              child: SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 150,
                    barTouchData: const BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            const days = ['শ', 'সো', 'ম', 'বু', 'বৃ', 'শু', 'র'];
                            return Text(
                              days[value.toInt() % 7],
                              style: const TextStyle(fontSize: 11),
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(),
                      rightTitles: const AxisTitles(),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(
                      weekly.length,
                      (i) => BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: weekly[i].toDouble(),
                            color: AppBorders.iconOn(AppColors.caramel, context),
                            width: 18,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'বিষয়ভিত্তিক পারফরম্যান্স',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _SubjectBar('Physics', 0.85, AppColors.skyBlue),
            _SubjectBar('Chemistry', 0.72, AppColors.softGreen),
            _SubjectBar('Higher Math', 0.58, AppColors.peach),
            const SizedBox(height: 20),
            DhimanCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppBorders.iconOn(
                          Theme.of(context).cardTheme.color ?? AppColors.cream,
                          context,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'স্মার্ট সুপারিশ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Higher Math অধ্যায় ৩-৪ এ দুর্বলতা দেখা যাচ্ছে। আজ ৩০ মিনিট MCQ অনুশীলন করুন।',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectBar extends StatelessWidget {
  const _SubjectBar(this.name, this.percent, this.color);

  final String name;
  final double percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Text('${(percent * 100).toInt()}%'),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 10,
              backgroundColor: AppColors.caramel,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

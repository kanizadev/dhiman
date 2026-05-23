import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

/// Daily routine / planner tab (mockup screen 10)
class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  int _selectedDay = DateTime.now().weekday % 7;

  static const _tasks = [
    ('৬:০০ – ৭:৩০', 'বাংলা পড়া', true),
    ('৮:০০ – ৯:৩০', 'Physics MCQ ২০টি', false),
    ('১০:০০ – ১১:০০', 'Chemistry notes', false),
    ('বিকেল ৪:০০', 'মডেল টেস্ট', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlobBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'দৈনিক রুটিন',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    TextButton.icon(
                      onPressed: () => context.push('/pomodoro'),
                      icon: const Icon(Icons.timer_outlined, size: 20),
                      label: const Text('পোমোডোরো'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 72,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 7,
                  itemBuilder: (_, i) {
                    final selected = i == _selectedDay;
                    final day = DateTime.now().subtract(Duration(days: _selectedDay - i));
                    return GestureDetector(
                      onTap: () => setState(() => _selectedDay = i),
                      child: Container(
                        width: 52,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: AppBorders.box(
                          context: context,
                          backgroundColor: selected
                              ? AppColors.coffeeBrown
                              : Theme.of(context).cardTheme.color,
                          radius: 16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${day.day}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selected ? AppColors.cream : null,
                              ),
                            ),
                            Text(
                              ['র', 'শ', 'সো', 'ম', 'বু', 'বৃ', 'শু'][day.weekday % 7],
                              style: TextStyle(
                                fontSize: 11,
                                color: selected ? AppColors.latte : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _tasks.length,
                  itemBuilder: (_, i) {
                    final task = _tasks[i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DhimanCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 28,
                              child: Text(
                                task.$1,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: AppColors.caramel,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(task.$2)),
                            Checkbox(
                              value: task.$3,
                              onChanged: (_) {},
                              activeColor: AppColors.coffeeBrown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

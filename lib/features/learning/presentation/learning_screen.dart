import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/subject_icon.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  String _level = 'HSC';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlobBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'বিষয়সমূহ',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: AppBorders.box(
                          context: context,
                          backgroundColor: Theme.of(context).cardTheme.color,
                          radius: 20,
                        ),
                        child: Row(
                          children: ['SSC', 'HSC'].map((level) {
                            final selected = _level == level;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _level = level),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: selected
                                      ? AppBorders.box(
                                          context: context,
                                          backgroundColor: AppColors.coffeeBrown,
                                          radius: 16,
                                        )
                                      : null,
                                  child: Text(
                                    level,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: selected ? AppColors.cream : null,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'বিষয় খুঁজুন...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Theme.of(context).cardTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.88,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final subject = MockData.subjects[i];
                      final progress = 0.3 + (i * 0.11) % 0.65;
                      final cardColors = [
                        AppColors.skyBlue,
                        AppColors.softGreen,
                        AppColors.peach,
                        AppColors.softYellow,
                        AppColors.caramel,
                      ];
                      final bg = cardColors[i % cardColors.length];

                      return Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: AppBorders.box(
                            context: context,
                            backgroundColor: bg,
                            radius: 24,
                          ),
                          child: InkWell(
                          onTap: () =>
                              context.push('/learn/subject/${subject.id}'),
                            borderRadius: BorderRadius.circular(24),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SubjectIcon(subject: subject.name, size: 44),
                                  const Spacer(),
                                  Text(
                                    subject.nameBn,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 5,
                                      backgroundColor: AppColors.caramel,
                                      color: AppBorders.iconOn(bg, context),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'অগ্রগতি ${(progress * 100).toInt()}%',
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: MockData.subjects.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

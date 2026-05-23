import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';
import '../../../widgets/streak_row.dart';
import '../../../widgets/subject_icon.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'সুপ্রভাত';
    if (hour < 17) return 'শুভ অপরাহ্ন';
    return 'শুভ সন্ধ্যা';
  }

  String get _firstName {
    final name = MockData.demoProfile.fullName;
    return name.split(' ').first;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlobBackground(
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$_greeting, $_firstName! 👋',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'আজ কী পড়বে?',
                              style: textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => context.push('/notifications'),
                        icon: const Icon(Icons.notifications_outlined),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/profile'),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.softGreen,
                          child: Text(
                            _firstName[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.coffeeBrown,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StreakRow(streakDays: MockData.demoProfile.streakDays),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DhimanCard(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'আজকের লক্ষ্য',
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: AppBorders.box(
                                context: context,
                                backgroundColor: AppColors.softGreen,
                                radius: 12,
                                borderWidth: AppBorders.widthThin,
                              ),
                              child: const Text(
                                '২/৪ সম্পন্ন',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        _GoalCheck(title: 'Physics MCQ ২০টি', done: true),
                        _GoalCheck(title: 'Chemistry notes', done: true),
                        _GoalCheck(title: 'বাংলা ২য় পত্র', done: false),
                        _GoalCheck(title: 'ICT অধ্যায় ৩', done: false),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: Text(
                    'চালিয়ে যাও',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DhimanCard(
                    gradient: AppColors.primaryGradient,
                    onTap: () => context.push('/learn/subject/physics'),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: AppBorders.box(
                            context: context,
                            backgroundColor: AppColors.cream,
                            radius: 20,
                          ),
                          child: Icon(
                            Icons.science_outlined,
                            color: AppBorders.iconOn(AppColors.cream, context),
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'পদার্থবিজ্ঞান',
                                style: TextStyle(
                                  color: AppColors.cream,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: 0.62,
                                  backgroundColor: AppColors.caramel,
                                  color: AppColors.softYellow,
                                  minHeight: 6,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '৬২% সম্পন্ন • অধ্যায় ৫',
                                style: TextStyle(
                                  color: AppColors.latte,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppBorders.forSurface(
                                AppColors.cream,
                                context,
                              ),
                              width: AppBorders.widthThin,
                            ),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: AppBorders.iconOn(AppColors.cream, context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'জনপ্রিয় বিষয়',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/learn'),
                        child: const Text('সব দেখুন'),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: MockData.subjects.length.clamp(0, 6),
                    itemBuilder: (context, i) {
                      final s = MockData.subjects[i];
                      final progress = 0.35 + (i * 0.1) % 0.55;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Material(
                          color: Colors.transparent,
                          child: Ink(
                            decoration: AppBorders.box(
                              context: context,
                              backgroundColor: Theme.of(context).cardTheme.color,
                              radius: 24,
                            ),
                            child: InkWell(
                              onTap: () => context.push('/learn/subject/${s.id}'),
                              borderRadius: BorderRadius.circular(24),
                              child: SizedBox(
                                width: 110,
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SubjectIcon(subject: s.name, size: 40),
                                      const Spacer(),
                                      Text(
                                        s.nameBn,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'অগ্রগতি ${(progress * 100).toInt()}%',
                                        style: textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ).animate(delay: (50 * i).ms).fadeIn().slideX(begin: 0.1);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _MiniCard(
                          icon: Icons.people_outline,
                          label: 'কমিউনিটি',
                          color: AppColors.skyBlue,
                          onTap: () => context.push('/community'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _MiniCard(
                          icon: Icons.insights_outlined,
                          label: 'অ্যানালিটিক্স',
                          color: AppColors.peach,
                          onTap: () => context.push('/analytics'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalCheck extends StatelessWidget {
  const _GoalCheck({required this.title, required this.done});

  final String title;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle_rounded : Icons.circle_outlined,
            size: 22,
            color: done
                ? AppBorders.iconOn(AppColors.softGreen, context)
                : AppBorders.iconOn(AppColors.cream, context),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              decoration: done ? TextDecoration.lineThrough : null,
              color: done ? AppColors.lightTextSecondary : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: AppBorders.box(
          context: context,
          backgroundColor: color,
          radius: 20,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppBorders.iconOn(color, context), size: 22),
                const SizedBox(width: 8),
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

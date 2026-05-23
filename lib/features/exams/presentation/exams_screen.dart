import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/exam_model.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: BlobBackground(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Text(
                    'পরীক্ষা',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'লাইভ'),
                    Tab(text: 'আসন্ন'),
                    Tab(text: 'সম্পন্ন'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _ExamList(
                        exams: MockData.liveExams
                            .where((e) => e.isLive)
                            .toList(),
                      ),
                      _ExamList(
                        exams: MockData.liveExams
                            .where((e) => !e.isLive)
                            .toList(),
                      ),
                      const Center(child: Text('সম্পন্ন পরীক্ষা')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExamList extends StatelessWidget {
  const _ExamList({required this.exams});

  final List<ExamModel> exams;

  @override
  Widget build(BuildContext context) {
    if (exams.isEmpty) {
      return const Center(child: Text('কোনো পরীক্ষা নেই'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: exams.length,
      itemBuilder: (context, i) {
        final exam = exams[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: DhimanCard(
            delay: Duration(milliseconds: 60 * i),
            onTap: () => context.push('/exams/${exam.id}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (exam.isLive)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: AppBorders.box(
                          context: context,
                          backgroundColor: AppColors.peach,
                          radius: 12,
                          borderWidth: AppBorders.widthThin,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 8,
                              color: AppBorders.iconOn(AppColors.peach, context),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: AppBorders.iconOn(AppColors.peach, context),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                    Text(exam.subject),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  exam.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: AppBorders.iconOn(
                        Theme.of(context).cardTheme.color ?? AppColors.cream,
                        context,
                      ),
                    ),
                    Text(' ${exam.durationMinutes} মিনিট'),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.quiz_outlined,
                      size: 16,
                      color: AppBorders.iconOn(
                        Theme.of(context).cardTheme.color ?? AppColors.cream,
                        context,
                      ),
                    ),
                    Text(' ${exam.questionCount} প্রশ্ন'),
                  ],
                ),
                if (exam.participantCount > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    '${exam.participantCount} জন অংশ নিয়েছে',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

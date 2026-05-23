import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/data/mock_data.dart';
import '../../../widgets/dhiman_button.dart';
import '../../../widgets/dhiman_card.dart';

class ExamDetailScreen extends StatelessWidget {
  const ExamDetailScreen({super.key, required this.examId});

  final String examId;

  @override
  Widget build(BuildContext context) {
    final exam = MockData.liveExams.firstWhere(
      (e) => e.id == examId,
      orElse: () => MockData.liveExams.first,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('পরীক্ষার বিবরণ')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DhimanCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow('বিষয়', exam.subject),
                  _InfoRow('সময়', '${exam.durationMinutes} মিনিট'),
                  _InfoRow('মোট নম্বর', '${exam.totalMarks}'),
                  _InfoRow('প্রশ্ন', '${exam.questionCount}'),
                  if (exam.negativeMarking)
                    _InfoRow('নেগেটিভ মার্ক', '${exam.negativeMarkValue}'),
                ],
              ),
            ),
            const Spacer(),
            DhimanButton(
              label: exam.isLive ? 'পরীক্ষা শুরু করুন' : 'রিমাইন্ডার সেট করুন',
              icon: Icons.play_arrow_rounded,
              onPressed: () => context.push('/exam-session/${exam.id}'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.w600))],
      ),
    );
  }
}

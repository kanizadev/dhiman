import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

class ProductivityScreen extends StatefulWidget {
  const ProductivityScreen({super.key});

  @override
  State<ProductivityScreen> createState() => _ProductivityScreenState();
}

class _ProductivityScreenState extends State<ProductivityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _pomodoroSeconds = AppConstants.pomodoroWorkMinutes * 60;
  bool _pomodoroRunning = false;
  Timer? _pomodoroTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _pomodoroTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _togglePomodoro() {
    if (_pomodoroRunning) {
      _pomodoroTimer?.cancel();
      setState(() => _pomodoroRunning = false);
    } else {
      _pomodoroTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_pomodoroSeconds <= 0) {
          _pomodoroTimer?.cancel();
          setState(() => _pomodoroRunning = false);
        } else {
          setState(() => _pomodoroSeconds--);
        }
      });
      setState(() => _pomodoroRunning = true);
    }
  }

  String get _timeStr {
    final m = _pomodoroSeconds ~/ 60;
    final s = _pomodoroSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('প্রোডাক্টিভিটি'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'পোমোডোরো'),
            Tab(text: 'গোল'),
            Tab(text: 'টু-ডু'),
          ],
        ),
      ),
      body: BlobBackground(
        child: TabBarView(
          controller: _tabController,
          children: [
            Center(
              child: DhimanCard(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _timeStr,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.coffeeBrown,
                          ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: _togglePomodoro,
                      icon: Icon(_pomodoroRunning ? Icons.pause : Icons.play_arrow),
                      label: Text(_pomodoroRunning ? 'বিরতি' : 'শুরু'),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: MockData.studyGoals.length,
              itemBuilder: (_, i) {
                final goal = MockData.studyGoals[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DhimanCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(goal.title),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: goal.progress),
                        Text(
                          '${(goal.progress * 100).toInt()}% সম্পন্ন',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                CheckboxListTile(
                  title: const Text('Physics MCQ ২০টি'),
                  value: false,
                  onChanged: (_) {},
                ),
                CheckboxListTile(
                  title: const Text('Chemistry notes পড়া'),
                  value: true,
                  onChanged: (_) {},
                ),
                CheckboxListTile(
                  title: const Text('Weekly planner আপডেট'),
                  value: false,
                  onChanged: (_) {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

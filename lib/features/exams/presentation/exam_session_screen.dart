import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/dhiman_button.dart';

class ExamSessionScreen extends StatefulWidget {
  const ExamSessionScreen({super.key, required this.examId});

  final String examId;

  @override
  State<ExamSessionScreen> createState() => _ExamSessionScreenState();
}

class _ExamSessionScreenState extends State<ExamSessionScreen> {
  int _currentQuestion = 11; // mock Q12/50
  int? _selectedOption;
  final Map<int, int> _answers = {};
  final Set<int> _flagged = {};
  late int _secondsRemaining;
  Timer? _timer;

  static const _totalQuestions = 50;
  static const _labels = ['A', 'B', 'C', 'D'];

  static const _question =
      'একটি বস্তুকে 10 m/s বেগে নিক্ষেপ করা হলো। 45° কোণে — সর্বোচ্চ উচ্চতা কত?';

  static const _options = [
    '12.5 m',
    '15.2 m',
    '8.7 m',
    '20.1 m',
  ];

  @override
  void initState() {
    super.initState();
    _secondsRemaining = 42 * 60 + 18;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsRemaining <= 0) {
        _submit();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _submit() {
    _timer?.cancel();
    if (mounted) context.pushReplacement('/exam-result');
  }

  String get _timeDisplay {
    final m = _secondsRemaining ~/ 60;
    final s = _secondsRemaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          title: const Text('Physics Model Test'),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: AppBorders.box(
                context: context,
                backgroundColor: AppColors.peach,
                radius: 20,
                borderWidth: AppBorders.widthThin,
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 18),
                  Text(
                    _timeDisplay,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.pause_circle_outline),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Text(
                    'প্রশ্ন ${_currentQuestion + 1}/$_totalQuestions',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_flagged.contains(_currentQuestion)) {
                          _flagged.remove(_currentQuestion);
                        } else {
                          _flagged.add(_currentQuestion);
                        }
                      });
                    },
                    icon: Icon(
                      _flagged.contains(_currentQuestion)
                          ? Icons.flag
                          : Icons.outlined_flag,
                      color: AppBorders.iconOn(AppColors.cream, context),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: AppBorders.box(
                        context: context,
                        backgroundColor: AppColors.cream,
                        radius: 24,
                      ),
                      child: Text(
                        _question,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(4, (i) {
                      final selected = _selectedOption == i;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Material(
                          color: Colors.transparent,
                          child: Ink(
                            decoration: AppBorders.box(
                              context: context,
                              backgroundColor:
                                  selected ? AppColors.softGreen : AppColors.cream,
                              radius: 20,
                            ),
                            child: InkWell(
                              onTap: () => setState(() => _selectedOption = i),
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Radio<int>(
                                      value: i,
                                      groupValue: _selectedOption,
                                      onChanged: (v) =>
                                          setState(() => _selectedOption = v),
                                      activeColor: AppColors.coffeeBrown,
                                    ),
                                    Text(
                                      _labels[i],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(_options[i])),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _currentQuestion > 0
                          ? () => setState(() {
                                if (_selectedOption != null) {
                                  _answers[_currentQuestion] = _selectedOption!;
                                }
                                _currentQuestion--;
                                _selectedOption = _answers[_currentQuestion];
                              })
                          : null,
                      child: const Text('আগের'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: DhimanButton(
                      label: _currentQuestion >= _totalQuestions - 1
                          ? 'জমা দিন'
                          : 'পরের',
                      expand: true,
                      onPressed: () {
                        if (_selectedOption != null) {
                          _answers[_currentQuestion] = _selectedOption!;
                        }
                        if (_currentQuestion < _totalQuestions - 1) {
                          setState(() {
                            _currentQuestion++;
                            _selectedOption = _answers[_currentQuestion];
                          });
                        } else {
                          _submit();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.cream,
                border: Border(top: AppBorders.side(context)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: _totalQuestions.clamp(0, 20),
                  itemBuilder: (_, i) {
                    final answered = _answers.containsKey(i);
                    final current = i == _currentQuestion;
                    final flagged = _flagged.contains(i);
                    return GestureDetector(
                      onTap: () => setState(() {
                        _currentQuestion = i;
                        _selectedOption = _answers[i];
                      }),
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: AppBorders.box(
                          context: context,
                          backgroundColor: current
                              ? AppColors.coffeeBrown
                              : answered
                                  ? AppColors.softGreen
                                  : flagged
                                      ? AppColors.softYellow
                                      : AppColors.cream,
                          radius: 10,
                          borderWidth: AppBorders.widthThin,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: current || answered
                                ? AppColors.cream
                                : AppColors.coffeeBrown,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

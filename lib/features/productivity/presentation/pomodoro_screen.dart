import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/blob_background.dart';

/// Pomodoro focus timer (mockup screen 11)
class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  int _tab = 0;
  int _seconds = AppConstants.pomodoroWorkMinutes * 60;
  bool _running = false;
  Timer? _timer;

  static const _tabs = ['পোমোডোরো', 'ছোট বিরতি', 'দীর্ঘ বিরতি'];
  static const _durations = [25, 5, 15];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _selectTab(int i) {
    setState(() {
      _tab = i;
      _seconds = _durations[i] * 60;
      _running = false;
      _timer?.cancel();
    });
  }

  void _toggle() {
    if (_running) {
      _timer?.cancel();
      setState(() => _running = false);
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_seconds > 0) {
          setState(() => _seconds--);
        } else {
          _timer?.cancel();
          setState(() => _running = false);
        }
      });
      setState(() => _running = true);
    }
  }

  String get _timeStr {
    final m = _seconds ~/ 60;
    final s = _seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (_seconds / (_durations[_tab] * 60));

    return Scaffold(
      appBar: AppBar(title: const Text('ফোকাস টাইমার')),
      body: BlobBackground(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: List.generate(3, (i) {
                  final selected = _tab == i;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Material(
                        color: Colors.transparent,
                        child: Ink(
                          decoration: AppBorders.box(
                            context: context,
                            backgroundColor: selected
                                ? AppColors.coffeeBrown
                                : Theme.of(context).cardTheme.color,
                            radius: 20,
                          ),
                          child: InkWell(
                            onTap: () => _selectTab(i),
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                _tabs[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: selected ? AppColors.cream : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(260, 260),
                    painter: _RingPainter(progress: progress),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.eco_rounded,
                        size: 48,
                        color: AppBorders.iconOn(AppColors.softGreen, context),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _timeStr,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.coffeeBrown,
                            ),
                      ),
                      Text(
                        'ফোকাস সময়',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.large(
                  heroTag: 'pomodoro',
                  backgroundColor: AppColors.coffeeBrown,
                  onPressed: _toggle,
                  child: Icon(
                    _running ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: AppBorders.iconOn(AppColors.coffeeBrown, context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;

    final bg = Paint()
      ..color = AppColors.cream
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final fg = Paint()
      ..color = AppColors.softGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bg);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.progress != progress;
}

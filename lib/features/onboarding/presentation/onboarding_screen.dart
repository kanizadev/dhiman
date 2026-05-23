import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_button.dart';
import '../../../widgets/dhiman_logo.dart';
import '../../../widgets/onboarding_illustration.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _pages = [
    (
      OnboardingIllustrationType.studyDesk,
      'তোমার স্মার্ট স্টাডি সঙ্গী',
      'SSC ও HSC শিক্ষার্থীদের জন্য সব-in-one শেখার প্ল্যাটফর্ম',
      'চল শুরু করি',
    ),
    (
      OnboardingIllustrationType.goals,
      'লক্ষ্য ঠিক করো\nনিজেকে উন্নত করো',
      'স্ট্রিক, গোল ও অ্যানালিটিক্স দিয়ে নিয়মিত পড়াশোনা করো',
      'পরের ধাপ',
    ),
    (
      OnboardingIllustrationType.community,
      'একসাথে শেখার\nঅনুপ্রেরণা',
      'বন্ধুদের সাথে অর্জন শেয়ার করো, পজিটিভ কমিউনিটি',
      'শুরু করি',
    ),
  ];

  Future<void> _finish() async {
    await ref.read(preferencesServiceProvider).setOnboardingDone(true);
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: BlobBackground(
        child: SafeArea(
          child: Column(
            children: [
              if (_page < _pages.length - 1)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _finish,
                    child: const Text('এড়িয়ে যান'),
                  ),
                )
              else
                const SizedBox(height: 48),
              const DhimanLogo(size: 28),
              const SizedBox(height: 8),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemCount: _pages.length,
                  itemBuilder: (_, i) {
                    final p = _pages[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        children: [
                          OnboardingIllustration(type: p.$1, height: 240)
                              .animate()
                              .fadeIn()
                              .slideY(begin: 0.05, end: 0),
                          const SizedBox(height: 32),
                          Text(
                            p.$2,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  height: 1.25,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            p.$3,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: _pages.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: AppColors.coffeeBrown,
                  dotColor: AppColors.latte,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: DhimanButton(
                  label: _pages[_page].$4,
                  onPressed: () {
                    if (_page < _pages.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                      );
                    } else {
                      _finish();
                    }
                  },
                ),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

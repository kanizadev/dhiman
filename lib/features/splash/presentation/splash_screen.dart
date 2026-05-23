import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/firebase/firebase_service.dart';
import '../../../widgets/blob_background.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    final prefs = ref.read(preferencesServiceProvider);
    final onboardingDone = await prefs.isOnboardingDone();
    if (!mounted) return;
    if (!onboardingDone) {
      context.go('/onboarding');
      return;
    }
    // Demo mode: go straight to home
    if (FirebaseService.isDemoMode) {
      context.go('/home');
      return;
    }
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlobBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: AppBorders.box(
                  context: context,
                  gradient: AppColors.primaryGradient,
                  radius: 32,
                ),
                child: Icon(
                  Icons.school_rounded,
                  size: 52,
                  color: AppBorders.iconOnGradient(
                    AppColors.primaryGradient,
                    context,
                  ),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 600.ms,
                    curve: Curves.elasticOut,
                  ),
              const SizedBox(height: 28),
              Text(
                AppConstants.appName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.coffeeBrown,
                    ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Text(
                AppConstants.appTagline,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 48),
              const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.coffeeBrown,
                ),
              ).animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }
}

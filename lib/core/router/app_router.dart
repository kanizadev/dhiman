import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/analytics/presentation/analytics_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/otp_screen.dart';
import '../../features/auth/presentation/phone_login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/dashboard/presentation/main_shell.dart';
import '../../features/exams/presentation/exam_detail_screen.dart';
import '../../features/exams/presentation/exam_result_screen.dart';
import '../../features/exams/presentation/exam_session_screen.dart';
import '../../features/exams/presentation/exams_screen.dart';
import '../../features/learning/presentation/learning_screen.dart';
import '../../features/learning/presentation/subject_detail_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/productivity/presentation/pomodoro_screen.dart';
import '../../features/productivity/presentation/routine_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/profile_setup_screen.dart';
import '../../features/social/presentation/social_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, s) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, s) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, s) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, s) => const RegisterScreen()),
      GoRoute(
        path: '/forgot-password',
        builder: (_, s) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: '/phone-login', builder: (_, s) => const PhoneLoginScreen()),
      GoRoute(
        path: '/otp',
        builder: (_, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          return OtpScreen(phoneNumber: phone);
        },
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (_, s) => const ProfileSetupScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, s, shell) => MainShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (_, s) => const DashboardScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/learn',
                builder: (_, s) => const LearningScreen(),
                routes: [
                  GoRoute(
                    path: 'subject/:id',
                    builder: (_, state) => SubjectDetailScreen(
                      subjectId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/exams',
                builder: (_, s) => const ExamsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (_, state) => ExamDetailScreen(
                      examId: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/routine', builder: (_, s) => const RoutineScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/profile', builder: (_, s) => const ProfileScreen()),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/exam-session/:id',
        builder: (_, state) =>
            ExamSessionScreen(examId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/exam-result', builder: (_, s) => const ExamResultScreen()),
      GoRoute(path: '/analytics', builder: (_, s) => const AnalyticsScreen()),
      GoRoute(path: '/pomodoro', builder: (_, s) => const PomodoroScreen()),
      GoRoute(path: '/community', builder: (_, s) => const SocialScreen()),
      GoRoute(
        path: '/notifications',
        builder: (_, s) => const NotificationsScreen(),
      ),
    ],
  );
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = MockData.demoProfile;

    return Scaffold(
      body: BlobBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'প্রোফাইল',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.softGreen,
                      child: Text(
                        profile.fullName[0],
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.coffeeBrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      profile.fullName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      'HSC 24 • ${profile.department} • ${profile.board} বোর্ড',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _StatTile(
                    value: '${profile.streakDays}',
                    label: 'স্ট্রিক',
                    icon: Icons.local_fire_department,
                    accent: AppColors.peach,
                  ),
                  _StatTile(
                    value: '128',
                    label: 'MCQ',
                    icon: Icons.quiz_outlined,
                    accent: AppColors.skyBlue,
                  ),
                  _StatTile(
                    value: '78%',
                    label: 'গড় স্কোর',
                    icon: Icons.trending_up,
                    accent: AppColors.softGreen,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _MenuItem(
                icon: Icons.person_outline,
                title: 'আমার প্রোফাইল',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.emoji_events_outlined,
                title: 'অর্জিত পদক',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.bookmark_outline,
                title: 'সংরক্ষিত',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.download_outlined,
                title: 'ডাউনলোড',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.settings_outlined,
                title: 'সেটিংস',
                onTap: () {},
              ),
              _MenuItem(
                icon: Icons.help_outline,
                title: 'সাহায্য ও সহায়তা',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              DhimanCard(
                onTap: () async {
                  await ref.read(authServiceProvider).signOut();
                  if (context.mounted) context.go('/login');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: AppColors.coffeeBrown),
                    SizedBox(width: 8),
                    Text(
                      'লগআউট',
                      style: TextStyle(
                        color: AppColors.coffeeBrown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.value,
    required this.label,
    required this.icon,
    required this.accent,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: AppBorders.box(
          context: context,
          backgroundColor: Theme.of(context).cardTheme.color,
          radius: 20,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: AppBorders.box(
                context: context,
                backgroundColor: accent,
                radius: 12,
                borderWidth: AppBorders.widthThin,
              ),
              child: Icon(
                icon,
                color: AppBorders.iconOn(accent, context),
                size: 22,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: AppBorders.box(
            context: context,
            backgroundColor: Theme.of(context).cardTheme.color,
            radius: 20,
          ),
          child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: Icon(
            icon,
            color: AppBorders.iconOn(
              Theme.of(context).cardTheme.color ?? AppColors.cream,
              context,
            ),
          ),
          title: Text(title),
          trailing: const Icon(Icons.chevron_right),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

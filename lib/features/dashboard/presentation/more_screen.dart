import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: BlobBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'আরও',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 20),
              DhimanCard(
                onTap: () => context.push('/analytics'),
                child: const _MenuTile(
                  icon: Icons.insights_rounded,
                  accent: AppColors.skyBlue,
                  title: 'অ্যাকাডেমিক অ্যানালিটিক্স',
                  subtitle: 'স্ট্রিক, গ্রাফ ও রিপোর্ট',
                ),
              ),
              const SizedBox(height: 12),
              DhimanCard(
                onTap: () => context.push('/productivity'),
                child: const _MenuTile(
                  icon: Icons.timer_rounded,
                  accent: AppColors.peach,
                  title: 'প্রোডাক্টিভিটি',
                  subtitle: 'পোমোডোরো, গোল, টু-ডু',
                ),
              ),
              const SizedBox(height: 12),
              DhimanCard(
                onTap: () => context.push('/profile'),
                child: const _MenuTile(
                  icon: Icons.person_outline,
                  accent: AppColors.softYellow,
                  title: 'প্রোফাইল',
                  subtitle: 'অ্যাকাউন্ট ও সেটিংস',
                ),
              ),
              const SizedBox(height: 24),
              Text('থিম', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              SegmentedButton<ThemeMode>(
                segments: const [
                  ButtonSegment(
                    value: ThemeMode.light,
                    icon: Icon(Icons.light_mode),
                    label: Text('লাইট'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.dark,
                    icon: Icon(Icons.dark_mode),
                    label: Text('ডার্ক'),
                  ),
                  ButtonSegment(
                    value: ThemeMode.system,
                    icon: Icon(Icons.brightness_auto),
                    label: Text('সিস্টেম'),
                  ),
                ],
                selected: {themeMode},
                onSelectionChanged: (s) {
                  ref.read(themeModeProvider.notifier).setTheme(s.first);
                },
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings_outlined),
                title: const Text('অ্যাডমিন প্যানেল'),
                subtitle: const Text('শীঘ্যই আসছে'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.accent,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color accent;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: AppBorders.box(
            context: context,
            backgroundColor: accent,
            radius: 16,
            borderWidth: AppBorders.widthThin,
          ),
          child: Icon(icon, color: AppBorders.iconOn(accent, context)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleSmall),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const Icon(Icons.chevron_right),
      ],
    );
  }
}

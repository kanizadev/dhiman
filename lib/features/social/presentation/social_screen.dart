import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_borders.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/social_post.dart';
import '../../../shared/data/mock_data.dart';
import '../../../widgets/blob_background.dart';
import '../../../widgets/dhiman_card.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlobBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Text(
                      'কমিউনিটি',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    _FeedTab(
                      label: 'ফিড',
                      selected: _tab == 0,
                      onTap: () => setState(() => _tab = 0),
                    ),
                    const SizedBox(width: 8),
                    _FeedTab(
                      label: 'লিডারবোর্ড',
                      selected: _tab == 1,
                      onTap: () => setState(() => _tab = 1),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _tab == 0
                    ? ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: MockData.socialPosts.length,
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _PostCard(post: MockData.socialPosts[i]),
                        ),
                      )
                    : Center(
                        child: Text(
                          'সাপ্তাহিক লিডারবোর্ড শীঘ্যই',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedTab extends StatelessWidget {
  const _FeedTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: AppBorders.box(
            context: context,
            backgroundColor:
                selected ? AppColors.coffeeBrown : Theme.of(context).cardTheme.color,
            radius: 16,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.cream : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({required this.post});

  final SocialPost post;

  @override
  Widget build(BuildContext context) {
    return DhimanCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.peach,
                child: Text(
                  post.authorName[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.authorName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      DateFormat('d MMM, h:mm a').format(post.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (post.type == PostType.streak)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: AppBorders.box(
                context: context,
                gradient: AppColors.warmGradient,
                radius: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_fire_department,
                    size: 32,
                    color: AppBorders.iconOnGradient(
                      AppColors.warmGradient,
                      context,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '12 দিন স্ট্রিক',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          Text(post.content),
          const SizedBox(height: 14),
          Row(
            children: [
              _ActionChip(icon: Icons.favorite_border, label: 'লাইক'),
              const SizedBox(width: 16),
              _ActionChip(
                icon: Icons.chat_bubble_outline,
                label: '${post.commentCount}',
              ),
              const SizedBox(width: 16),
              _ActionChip(icon: Icons.share_outlined, label: 'শেয়ার'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppBorders.iconOn(
            Theme.of(context).cardTheme.color ?? AppColors.cream,
            context,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
